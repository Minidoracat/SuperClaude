#!/usr/bin/env bash

# SuperClaude 繁體中文版安裝腳本
# 安裝 SuperClaude 配置框架以增強 Claude Code
# 版本：2.0.1
# 授權：MIT
# 儲存庫：https://github.com/NomenAK/SuperClaude

set -e  # 遇到錯誤時退出
set -o pipefail  # 管道失敗時退出


# 檢查 Bash 版本
check_bash_version() {
    local version_major=${BASH_VERSINFO[0]}
    if (( version_major < MIN_BASH_VERSION )); then
        echo -e "${RED}錯誤：需要 Bash $MIN_BASH_VERSION 或更高版本。${NC}"
        exit 1
    fi
}

# 腳本版本
readonly SCRIPT_VERSION="2.0.1"

# 常數
readonly REQUIRED_SPACE_KB=51200  # 50MB（以 KB 為單位）
readonly MIN_BASH_VERSION=3
readonly CHECKSUM_FILE=".checksums"
readonly CONFIG_FILE=".superclaude.conf"

# 顏色輸出 - 檢測終端支援
if [[ -t 1 ]] && [[ "$(tput colors 2>/dev/null)" -ge 8 ]]; then
    # 終端支援顏色
    readonly GREEN='\033[0;32m'
    readonly YELLOW='\033[1;33m'
    readonly RED='\033[0;31m'
    readonly BLUE='\033[0;34m'
    readonly NC='\033[0m' # 無顏色
else
    # 不支援顏色
    readonly GREEN=''
    readonly YELLOW=''
    readonly RED=''
    readonly BLUE=''
    readonly NC=''
fi

# 配置模式
readonly -a CUSTOMIZABLE_CONFIGS=("CLAUDE.md" "RULES.md" "PERSONAS.md" "MCP.md")

# 預設設定
INSTALL_DIR="$HOME/.claude"
FORCE_INSTALL=false
UPDATE_MODE=false
UNINSTALL_MODE=false
VERIFY_MODE=false
VERBOSE=false
DRY_RUN=false
LOG_FILE=""
VERIFICATION_FAILURES=0
ROLLBACK_ON_FAILURE=true
BACKUP_DIR=""
INSTALLATION_PHASE=false


# 錯誤/警告追蹤
ERROR_COUNT=0
WARNING_COUNT=0
ERROR_DETAILS=()
WARNING_DETAILS=()
# 原始工作目錄
ORIGINAL_DIR=$(pwd)

# 函數：generate_error_report
# 說明：生成完整的錯誤和警告報告
# 參數：無
# 返回：無
generate_error_report() {
    if [[ $ERROR_COUNT -eq 0 ]] && [[ $WARNING_COUNT -eq 0 ]]; then
        return 0
    fi
    
    echo ""
    echo -e "${BLUE}=== 安裝報告 ===${NC}"
    echo "時間戳記：$(date '+%Y-%m-%d %H:%M:%S')"
    echo "腳本版本：$SCRIPT_VERSION"
    echo "安裝目錄：$INSTALL_DIR"
    echo ""
    
    if [[ $ERROR_COUNT -gt 0 ]]; then
        echo -e "${RED}錯誤 ($ERROR_COUNT)：${NC}"
        for error in "${ERROR_DETAILS[@]}"; do
            echo "  • $error"
        done
        echo ""
    fi
    
    if [[ $WARNING_COUNT -gt 0 ]]; then
        echo -e "${YELLOW}警告 ($WARNING_COUNT)：${NC}"
        for warning in "${WARNING_DETAILS[@]}"; do
            echo "  • $warning"
        done
        echo ""
    fi
    
    # 基於錯誤/警告的建議
    if [[ $ERROR_COUNT -gt 0 ]]; then
        echo -e "${BLUE}建議：${NC}"
        echo "  • 檢查檔案權限和擁有者"
        echo "  • 驗證磁碟空間可用性"
        echo "  • 確保所有必需的命令已安裝"
        echo "  • 查看日誌檔案以獲取詳細資訊：${LOG_FILE:-未指定}"
        echo ""
    fi
}

# 退出時清理
cleanup() {
    local exit_code=$?
    
    # 返回原始目錄
    cd "$ORIGINAL_DIR" 2>/dev/null || true
    
    # 如果有問題則生成錯誤報告
    if [[ $exit_code -ne 0 ]] || [[ $ERROR_COUNT -gt 0 ]] || [[ $WARNING_COUNT -gt 0 ]]; then
        generate_error_report
    fi
    
    # 如果啟用且在安裝階段，失敗時回滾
    if [[ $exit_code -ne 0 ]] && [[ "${ROLLBACK_ON_FAILURE:-true}" = true ]] && [[ -n "$BACKUP_DIR" ]] && [[ "${INSTALLATION_PHASE:-false}" = true ]]; then
        echo -e "${YELLOW}安裝失敗，嘗試回滾...${NC}" >&2
        if rollback_installation; then
            echo -e "${GREEN}回滾成功完成${NC}" >&2
        else
            echo -e "${RED}回滾失敗 - 需要手動介入${NC}" >&2
            echo -e "${YELLOW}備份位於：$BACKUP_DIR${NC}" >&2
        fi
    fi
    
    exit $exit_code
}
trap cleanup EXIT INT TERM HUP QUIT

# 例外模式 - 清理期間永不刪除的檔案/模式
EXCEPTION_PATTERNS=(
    "*.custom"
    "*.local"
    "*.new"
    "backup.*"
    ".git*"
    "CLAUDE.md"  # 使用者可能自訂主配置
    "RULES.md"   # 使用者可能自訂規則
    "PERSONAS.md" # 使用者可能自訂角色
    "MCP.md"     # 使用者可能自訂 MCP 配置
)

# 永不刪除或覆寫的使用者資料檔案
PRESERVE_FILES=(
    ".credentials.json"
    "settings.json"
    "settings.local.json"
    ".claude/todos"
    ".claude/statsig"
    ".claude/projects"
    ".claude/local"
    ".claude/local/*"
)

# 函數：check_command
# 說明：檢查命令是否存在
# 參數：$1 - 命令名稱
# 返回：0 如果命令存在，1 否則
check_command() {
    local cmd="$1"
    
    # 驗證輸入
    if [[ -z "$cmd" ]]; then
        log_error "check_command：命令名稱不能為空"
        return 1
    fi
    
    # 檢查危險的命令模式（增強安全性）
    if [[ "$cmd" =~ [\;\&\|\`\$\(\)\{\}\"\'\\] ]] || [[ "$cmd" =~ \.\.|^/ ]] || [[ "$cmd" =~ [[:space:]] ]]; then
        log_error "check_command：無效的命令名稱包含危險字元：$cmd"
        return 1
    fi
    
    command -v "$cmd" &> /dev/null
}

# 函數：compare_versions
# 說明：比較兩個語意版本
# 參數：$1 - version1，$2 - version2
# 返回：0 如果 version1 < version2，1 如果 version1 >= version2
compare_versions() {
    local version1="$1"
    local version2="$2"
    
    # 驗證輸入參數
    if [[ -z "$version1" ]] || [[ -z "$version2" ]]; then
        log_error "compare_versions：需要兩個版本參數"
        return 1
    fi
    
    # 驗證版本格式（基本語意版本模式）
    if [[ ! "$version1" =~ ^[0-9]+(\.[0-9]+)*([.-][a-zA-Z0-9]+)*$ ]]; then
        log_error "compare_versions：無效的版本格式：$version1"
        return 1
    fi
    
    if [[ ! "$version2" =~ ^[0-9]+(\.[0-9]+)*([.-][a-zA-Z0-9]+)*$ ]]; then
        log_error "compare_versions：無效的版本格式：$version2"
        return 1
    fi
    
    # 處理相同版本
    if [[ "$version1" == "$version2" ]]; then
        return 1
    fi
    
    # 將版本分割成陣列
    local v1_parts=() v2_parts=()
    IFS='.' read -ra v1_parts <<< "$version1"
    IFS='.' read -ra v2_parts <<< "$version2"
    
    # 比較每個部分
    for i in {0..2}; do
        local v1_part="${v1_parts[$i]:-0}"
        local v2_part="${v2_parts[$i]:-0}"
        
        # 移除任何非數字後綴以進行比較
        v1_part="${v1_part%%[!0-9]*}"
        v2_part="${v2_part%%[!0-9]*}"
        
        # 驗證我們有數字值
        if [[ ! "$v1_part" =~ ^[0-9]+$ ]]; then v1_part=0; fi
        if [[ ! "$v2_part" =~ ^[0-9]+$ ]]; then v2_part=0; fi
        
        if ((v1_part < v2_part)); then
            return 0
        elif ((v1_part > v2_part)); then
            return 1
        fi
    done
    
    return 1
}

# 函數：rollback_installation
# 說明：使用備份回滾失敗的安裝
# 參數：無（使用全域 BACKUP_DIR）
# 返回：0 成功，1 失敗
rollback_installation() {
    if [[ -z "$BACKUP_DIR" ]] || [[ ! -d "$BACKUP_DIR" ]]; then
        log_error "沒有可用的備份進行回滾"
        return 1
    fi
    
    echo -e "${YELLOW}正在回滾安裝...${NC}" >&2
    log_verbose "備份目錄：$BACKUP_DIR"
    log_verbose "安裝目錄：$INSTALL_DIR"
    
    # 在繼續之前驗證備份目錄內容
    if [[ -z "$(ls -A "$BACKUP_DIR" 2>/dev/null)" ]]; then
        log_error "備份目錄為空，無法回滾"
        return 1
    fi
    
    # 建立臨時目錄以進行安全操作
    local temp_dir
    temp_dir=$(mktemp -d 2>/dev/null) || {
        log_error "無法建立臨時目錄進行回滾"
        return 1
    }
    
    # 安全地移除失敗的安裝
    if [[ -d "$INSTALL_DIR" ]]; then
        log_verbose "將失敗的安裝移至臨時位置"
        if ! mv "$INSTALL_DIR" "$temp_dir/failed_install" 2>/dev/null; then
            log_error "無法移動失敗的安裝"
            rm -rf "$temp_dir" 2>/dev/null
            return 1
        fi
    fi
    
    # 還原備份
    log_verbose "將備份還原到安裝目錄"
    if ! mv "$BACKUP_DIR" "$INSTALL_DIR" 2>/dev/null; then
        log_error "無法還原備份"
        # 嘗試還原失敗的安裝
        if [[ -d "$temp_dir/failed_install" ]]; then
            mv "$temp_dir/failed_install" "$INSTALL_DIR" 2>/dev/null || true
        fi
        rm -rf "$temp_dir" 2>/dev/null
        return 1
    fi
    
    # 清理臨時目錄
    rm -rf "$temp_dir" 2>/dev/null
    
    # 清除備份目錄變數以防止意外使用
    BACKUP_DIR=""
    
    echo -e "${GREEN}安裝成功回滾${NC}" >&2
    return 0
}

# 函數：validate_directory_path
# 說明：驗證目錄路徑的安全性和合理性
# 參數：$1 - 目錄路徑
# 返回：0 如果有效，1 如果無效
validate_directory_path() {
    local dir_path="$1"
    
    # 檢查路徑是否為空
    if [[ -z "$dir_path" ]]; then
        log_error "目錄路徑不能為空"
        return 1
    fi
    
    # 檢查危險路徑
    local dangerous_paths=("/" "/bin" "/sbin" "/usr" "/usr/bin" "/usr/sbin" "/etc" "/sys" "/proc" "/dev" "/boot" "/lib" "/lib64")
    for dangerous in "${dangerous_paths[@]}"; do
        if [[ "$dir_path" == "$dangerous" ]] || [[ "$dir_path" == "$dangerous"/* ]]; then
            log_error "不允許安裝到系統目錄：$dir_path"
            return 1
        fi
    done
    
    # 檢查路徑遍歷嘗試
    if [[ "$dir_path" =~ \.\./|/\.\. ]]; then
        log_error "目錄路徑中不允許路徑遍歷：$dir_path"
        return 1
    fi
    
    # 基本字元驗證 - 只拒絕明顯危險的模式
    # （移除空字節檢查，因為它會導致誤報）
    
    return 0
}

# 函數：load_config
# 說明：從檔案載入配置（如果存在）
# 參數：$1 - 配置檔案路徑
# 返回：0 成功
load_config() {
    local config_file="$1"
    
    # 驗證輸入參數
    if [[ -z "$config_file" ]]; then
        log_error "load_config：配置檔案路徑不能為空"
        return 1
    fi
    
    # 安全檢查
    if [[ ! -f "$config_file" ]]; then
        log_error "找不到配置檔案：$config_file"
        return 1
    fi
    
    if [[ ! -r "$config_file" ]]; then
        log_error "無法讀取配置檔案：$config_file"
        return 1
    fi
    
    # 檢查檔案大小（防止載入極大的檔案）
    local file_size
    if command -v stat >/dev/null 2>&1; then
        file_size=$(stat -c%s "$config_file" 2>/dev/null || stat -f%z "$config_file" 2>/dev/null || echo "0")
        if [[ "$file_size" -gt 10240 ]]; then  # 10KB 限制
            log_error "配置檔案太大（>10KB）：$config_file"
            return 1
        fi
    fi
    
    # 檢查檔案擁有者（如果不是當前使用者擁有則警告）
    local file_owner=""
    if command -v stat >/dev/null 2>&1; then
        # 先嘗試 GNU stat，然後嘗試 BSD stat
        file_owner=$(stat -c "%U" "$config_file" 2>/dev/null || stat -f "%Su" "$config_file" 2>/dev/null || echo "")
        if [[ -n "$file_owner" ]] && [[ "$file_owner" != "$(whoami)" ]]; then
            log_warning "配置檔案由 $file_owner 擁有，不是當前使用者"
        fi
    else
        log_verbose "stat 工具不可用，跳過擁有者檢查"
    fi
    
    # 檢查可疑模式（增強安全性）
    if grep -qE '(\$\(|\$\{|`|;[[:space:]]*rm|;[[:space:]]*exec|;[[:space:]]*eval|\|\||&&|>[^>]|<[^<]|nc[[:space:]]|wget[[:space:]]|curl[[:space:]].*\||bash[[:space:]]*<|sh[[:space:]]*<)' "$config_file"; then
        log_error "配置檔案包含潛在危險的命令"
        return 1
    fi
    
    # 在子 shell 中來源配置檔案以進行驗證
    if (source "$config_file" 2>/dev/null); then
        # 只有在驗證通過時才來源
        source "$config_file"
        log_verbose "從 $config_file 載入配置"
    else
        log_error "無效的配置檔案：$config_file"
        return 1
    fi
    
    return 0
}

# 函數：show_usage
# 說明：顯示使用資訊
# 參數：無
# 返回：無
show_usage() {
    echo "SuperClaude 安裝程式 v$SCRIPT_VERSION"
    echo ""
    echo "用法：$0 [選項]"
    echo ""
    echo "選項："
    echo "  --dir <目錄>         安裝到自訂目錄（預設：$HOME/.claude）"
    echo "  --force              跳過確認提示（用於自動化）"
    echo "  --update             更新現有安裝（保留自訂設定）"
    echo "  --uninstall          從指定目錄移除 SuperClaude"
    echo "  --verify-checksums   驗證現有安裝的完整性"
    echo "  --verbose            在安裝期間顯示詳細輸出"
    echo "  --dry-run            預覽變更而不實際執行"
    echo "  --log <檔案>         將安裝日誌儲存到檔案"
    echo "  --config <檔案>      從檔案載入配置"
    echo "  --no-rollback        失敗時停用自動回滾"
    echo "  --check-update       檢查 SuperClaude 更新"
    echo "  --version            顯示安裝程式版本"
    echo "  -h, --help          顯示此說明訊息"
    echo ""
    echo "範例："
    echo "  $0                          # 安裝到預設位置"
    echo "  $0 --dir /opt/claude        # 安裝到 /opt/claude"
    echo "  $0 --dir ./local-claude     # 安裝到 ./local-claude"
    echo "  $0 --force                  # 不提示安裝"
    echo "  $0 --update                 # 更新現有安裝"
    echo "  $0 --uninstall              # 移除 SuperClaude"
    echo "  $0 --verify-checksums       # 驗證現有安裝"
    echo "  $0 --dry-run --verbose      # 使用詳細輸出預覽"
}

# 函數：log
# 說明：將訊息記錄到標準輸出和可選的檔案
# 參數：$1 - 訊息
# 返回：無
log() {
    local message="$1"
    if [[ -n "$LOG_FILE" ]]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] $message" >> "$LOG_FILE"
    fi
    echo "$message"
}

# 函數：log_verbose
# 說明：記錄詳細訊息（只有使用 --verbose 時才顯示）
# 參數：$1 - 訊息
# 返回：無
log_verbose() {
    local message="$1"
    if [[ -n "$LOG_FILE" ]]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] [詳細] $message" >> "$LOG_FILE"
    fi
    if [[ "$VERBOSE" = true ]]; then
        echo -e "${BLUE}[詳細]${NC} $message" >&2
    fi
}

# 全域錯誤追蹤
ERROR_COUNT=0
WARNING_COUNT=0
declare -a ERROR_DETAILS=()
declare -a WARNING_DETAILS=()

# 函數：log_error
# 說明：將錯誤訊息記錄到 stderr 並追蹤以供報告
# 參數：$1 - 訊息，$2 - 可選的上下文
# 返回：無
log_error() {
    local message="$1"
    local context="${2:-unknown}"
    
    ((ERROR_COUNT++))
    ERROR_DETAILS+=("[$context] $message")
    
    if [[ -n "$LOG_FILE" ]]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] [錯誤] [$context] $message" >> "$LOG_FILE"
    fi
    echo -e "${RED}[錯誤]${NC} $message" >&2
}

# 函數：log_warning
# 說明：將警告訊息記錄到 stderr 並追蹤以供報告
# 參數：$1 - 訊息，$2 - 可選的上下文
# 返回：無
log_warning() {
    local message="$1"
    local context="${2:-unknown}"
    
    ((WARNING_COUNT++))
    WARNING_DETAILS+=("[$context] $message")
    
    if [[ -n "$LOG_FILE" ]]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] [警告] [$context] $message" >> "$LOG_FILE"
    fi
    echo -e "${YELLOW}[警告]${NC} $message" >&2
}

# 函數：is_exception
# 說明：檢查檔案是否符合任何例外模式
# 參數：$1 - 檔案路徑
# 返回：0 如果符合例外模式，1 否則
is_exception() {
    local file="$1"
    local basename_file=$(basename "$file")
    
    for pattern in "${EXCEPTION_PATTERNS[@]}"; do
        if [[ "$basename_file" == $pattern ]]; then
            return 0
        fi
    done
    return 1
}

# 函數：is_preserve_file
# 說明：檢查檔案是否應該保留（使用者資料）
# 參數：$1 - 檔案路徑
# 返回：0 如果檔案應該保留，1 否則
is_preserve_file() {
    local file="$1"
    
    for preserve in "${PRESERVE_FILES[@]}"; do
        # 檢查檔案路徑是否以保留模式結尾
        if [[ "$file" == *"$preserve" ]]; then
            return 0
        fi
    done
    return 1
}

# 函數：verify_file_integrity
# 說明：使用 SHA256 校驗和驗證檔案完整性
# 參數：$1 - 來源檔案，$2 - 目標檔案
# 返回：0 如果校驗和相符，1 否則
verify_file_integrity() {
    local src_file="$1"
    local dest_file="$2"
    
    # 驗證輸入參數
    if [[ -z "$src_file" ]] || [[ -z "$dest_file" ]]; then
        log_error "verify_file_integrity：需要來源和目標檔案"
        return 1
    fi
    
    # 檢查檔案是否存在並可讀
    if [[ ! -f "$src_file" ]]; then
        log_error "verify_file_integrity：來源檔案不存在：$src_file"
        return 1
    fi
    
    if [[ ! -r "$src_file" ]]; then
        log_error "verify_file_integrity：無法讀取來源檔案：$src_file"
        return 1
    fi
    
    if [[ ! -f "$dest_file" ]]; then
        log_error "verify_file_integrity：目標檔案不存在：$dest_file"
        return 1
    fi
    
    if [[ ! -r "$dest_file" ]]; then
        log_error "verify_file_integrity：無法讀取目標檔案：$dest_file"
        return 1
    fi
    
    # 如果 sha256sum 不可用，跳過驗證
    if ! check_command sha256sum; then
        log_verbose "sha256sum 不可用，跳過完整性檢查"
        return 0
    fi
    
    # 使用錯誤處理計算校驗和
    local src_checksum dest_checksum
    
    if ! src_checksum=$(sha256sum "$src_file" 2>/dev/null | awk '{print $1}'); then
        log_error "verify_file_integrity：無法計算來源的校驗和：$src_file"
        return 1
    fi
    
    if ! dest_checksum=$(sha256sum "$dest_file" 2>/dev/null | awk '{print $1}'); then
        log_error "verify_file_integrity：無法計算目標的校驗和：$dest_file"
        return 1
    fi
    
    # 驗證校驗和相符
    if [[ -z "$src_checksum" ]] || [[ -z "$dest_checksum" ]]; then
        log_error "verify_file_integrity：計算出的校驗和為空"
        return 1
    fi
    
    # 驗證校驗和格式（64 個十六進位字元）
    if [[ ! "$src_checksum" =~ ^[a-f0-9]{64}$ ]] || [[ ! "$dest_checksum" =~ ^[a-f0-9]{64}$ ]]; then
        log_error "verify_file_integrity：無效的校驗和格式"
        return 1
    fi
    
    if [[ "$src_checksum" != "$dest_checksum" ]]; then
        log_error "verify_file_integrity：校驗和不符"
        log_error "  來源：$src_file ($src_checksum)"
        log_error "  目標：$dest_file ($dest_checksum)"
        return 1
    fi
    
    log_verbose "檔案完整性已驗證：$dest_file"
    return 0
}

# 函數：get_source_files
# 說明：取得相對於來源根目錄的所有來源檔案
# 參數：$1 - 來源根目錄
# 返回：檔案清單（每行一個）
get_source_files() {
    (  # 在子 shell 中執行以隔離目錄變更
        local source_root="$1"
        
        # 驗證輸入參數
        if [[ -z "$source_root" ]]; then
            log_error "get_source_files：需要來源根目錄"
            return 1
        fi
        
        # 驗證來源根目錄存在且為目錄
        if [[ ! -d "$source_root" ]]; then
            log_error "get_source_files：來源根目錄不是目錄：$source_root"
            return 1
        fi
        
        # 使用錯誤處理變更到來源目錄
        if ! cd "$source_root"; then
            log_error "get_source_files：無法存取來源目錄：$source_root"
            return 1
        fi
        
        # 驗證 zh-TW/.claude 目錄存在
        if [[ ! -d "zh-TW/.claude" ]]; then
            log_error "get_source_files：在來源根目錄中找不到 zh-TW/.claude 目錄"
            return 1
        fi
        
        # 使用錯誤處理尋找 zh-TW/.claude 目錄中的所有檔案並將它們映射到根目錄
        file_list=""
        if ! file_list=$(find zh-TW/.claude -type f \
            -not -path "*/.git*" \
            -not -path "*/backup.*" \
            -not -path "*/log/*" \
            -not -path "*/logs/*" \
            -not -path "*/.log/*" \
            -not -path "*/.logs/*" \
            -not -name "*.log" \
            -not -name "*.logs" \
            -not -name "settings.local.json" \
            -not -name "CLAUDE.md" \
            2>/dev/null | sed 's|^zh-TW/\.claude/||' | sort); then
            log_error "get_source_files：無法枚舉 zh-TW/.claude 目錄中的檔案"
            return 1
        fi
        
        # 輸出檔案清單
        echo "$file_list"
        
        # 如果存在，也包括來自 zh-TW 的 CLAUDE.md
        if [[ -f "zh-TW/CLAUDE.md" ]]; then
            echo "CLAUDE.md"
        fi
        
        return 0
    )
}

# 函數：get_installed_files
# 說明：取得相對於安裝目錄的所有已安裝檔案
# 參數：$1 - 安裝目錄
# 返回：檔案清單（每行一個）
get_installed_files() {
    local install_dir="$1"
    local current_dir=$(pwd)
    cd "$install_dir" || return 1
    
    # 尋找所有檔案，排除備份（符合實際備份模式）
    find . -type f \
        -not -path "./superclaude-backup.*" \
        | sed 's|^\./||' | sort
    
    cd "$current_dir" || return 1
}

# 函數：check_for_updates
# 說明：從 GitHub 檢查 SuperClaude 更新
# 參數：無
# 返回：0 如果有更新可用，1 如果是最新的，2 出錯
check_for_updates() {
    local repo_url="https://api.github.com/repos/nshkrdotcom/SuperClaude/releases/latest"
    
    if ! check_command curl; then
        log_error "更新檢查需要 curl"
        return 2
    fi
    
    log "正在檢查 SuperClaude 更新..."
    
    # 使用超時取得最新版本資訊
    local release_info
    if ! release_info=$(timeout 30 curl -s --max-time 30 --connect-timeout 10 "$repo_url" 2>/dev/null); then
        log_error "無法檢查更新（網路超時或錯誤）"
        return 2
    fi
    
    if [[ -z "$release_info" ]] || [[ "$release_info" == *"Not Found"* ]] || [[ "$release_info" == *"API rate limit"* ]]; then
        log_error "無法檢查更新（空回應或 API 限制）"
        return 2
    fi
    
    # 從版本中提取版本
    local latest_version=$(echo "$release_info" | grep -o '"tag_name":\s*"v\?[^"]*"' | sed 's/.*"v\?\([^"]*\)".*/\1/')
    if [[ -z "$latest_version" ]]; then
        log_error "無法確定最新版本"
        return 2
    fi
    
    log "當前版本：$SCRIPT_VERSION"
    log "最新版本：$latest_version"
    
    # 使用語意版本比較來比較版本
    if compare_versions "$SCRIPT_VERSION" "$latest_version"; then
        echo -e "${YELLOW}有更新可用！${NC}"
        echo "下載：https://github.com/nshkrdotcom/SuperClaude/releases/latest"
        return 0
    else
        echo -e "${GREEN}您擁有最新版本${NC}"
        return 1
    fi
}

# 函數：find_obsolete_files
# 說明：尋找在目標中但不在來源中的檔案
# 參數：$1 - 來源根目錄，$2 - 安裝目錄
# 返回：過時檔案清單
find_obsolete_files() {
    local source_root="$1"
    local install_dir="$2"
    
    # 取得檔案清單
    local source_files=$(get_source_files "$source_root" | sort | uniq)
    local installed_files=$(get_installed_files "$install_dir" | sort | uniq)
    
    # 尋找存在於已安裝但不在來源中的檔案
    comm -13 <(echo "$source_files") <(echo "$installed_files")
}

# 函數：cleanup_obsolete_files
# 說明：從安裝中移除過時的檔案
# 參數：$1 - 安裝目錄，$2 - 過時檔案清單
# 返回：0 成功
cleanup_obsolete_files() {
    local install_dir="$1"
    local obsolete_files="$2"
    local cleaned_count=0
    
    if [[ -z "$obsolete_files" ]]; then
        echo "沒有過時的檔案需要清理。"
        return 0
    fi
    
    echo -e "${YELLOW}發現需要清理的過時檔案：${NC}"
    while IFS= read -r file; do
        if [[ -n "$file" ]]; then
            local full_path="$install_dir/$file"
            
            # 檢查檔案是否應該保留
            if is_exception "$file" || is_preserve_file "$file"; then
                echo "  保留：$file（受保護的檔案）"
            else
                if [[ "$DRY_RUN" = true ]]; then
                    echo "  將移除：$file"
                else
                    echo "  正在移除：$file"
                    rm -f "$full_path"
                fi
                ((cleaned_count++))
                
                # 移除空的父目錄
                if [[ "$DRY_RUN" != true ]]; then
                    local parent_dir=$(dirname "$full_path")
                    while [[ "$parent_dir" != "$install_dir" ]] && [[ -d "$parent_dir" ]] && [[ -z "$(ls -A "$parent_dir" 2>/dev/null)" ]]; do
                        rmdir "$parent_dir" 2>/dev/null
                        parent_dir=$(dirname "$parent_dir")
                    done
                fi
            fi
        fi
    done <<< "$obsolete_files"
    
    if [[ $cleaned_count -gt 0 ]]; then
        echo -e "${GREEN}清理了 $cleaned_count 個過時的檔案${NC}"
    fi
}

# 函數：detect_platform
# 說明：檢測作業系統平台
# 參數：無
# 返回：設定全域 OS 變數
detect_platform() {
    OS="Unknown"
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="Linux"
        if grep -q Microsoft /proc/version 2>/dev/null; then
            OS="WSL"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macOS"
    elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]]; then
        OS="Windows"
    fi
    log_verbose "檢測到的平台：$OS"
}

# 函數：run_preflight_checks
# 說明：執行安裝前驗證檢查
# 參數：無
# 返回：0 成功，失敗時退出
run_preflight_checks() {
    log_verbose "正在執行預檢查..."
    
    # 檢測平台
    detect_platform
    
    # 檢查必需的命令
    local required_commands=("find" "comm" "cmp" "sort" "uniq" "basename" "dirname" "grep" "awk" "sed")
    local missing_commands=()
    
    for cmd in "${required_commands[@]}"; do
        if ! command -v "$cmd" &> /dev/null; then
            missing_commands+=("$cmd")
        fi
    done
    
    # 檢查 timeout 命令（用於網路操作）
    if ! command -v timeout &> /dev/null; then
        log_verbose "timeout 命令不可用，網路操作可能會掛起"
    fi
    
    if [[ ${#missing_commands[@]} -gt 0 ]]; then
        log_error "缺少必需的命令：${missing_commands[*]}" "preflight-check"
        echo "請安裝缺少的命令並重試。"
        exit 1
    fi
    
    # 檢查 bash 版本
    local bash_major_version="${BASH_VERSION%%.*}"
    if [[ -z "$bash_major_version" ]] || [[ "$bash_major_version" -lt "$MIN_BASH_VERSION" ]]; then
        log_error "需要 Bash 版本 $MIN_BASH_VERSION.0 或更高（當前：${BASH_VERSION:-未知}）" "preflight-check"
        exit 1
    fi
    
    # 檢查磁碟空間
    if [[ ! "$DRY_RUN" = true ]]; then
        local install_parent=$(dirname "$INSTALL_DIR")
        if [[ -d "$install_parent" ]]; then
            # 取得可用空間 - 處理不同的 df 輸出格式
            local available_space=""
            if command -v df &>/dev/null; then
                # 先嘗試 POSIX 相容的 df
                available_space=$(df -P -k "$install_parent" 2>/dev/null | awk 'NR==2 && NF>=4 {print $4}')
                # 如果失敗，嘗試不使用 -P 標誌
                if [[ -z "$available_space" ]] || [[ ! "$available_space" =~ ^[0-9]+$ ]]; then
                    available_space=$(df -k "$install_parent" 2>/dev/null | awk 'NR==2 && NF>=4 {print $4}')
                fi
                # 最終備用 - 嘗試從 df 輸出解析任何數值
                if [[ -z "$available_space" ]] || [[ ! "$available_space" =~ ^[0-9]+$ ]]; then
                    available_space=$(df "$install_parent" 2>/dev/null | awk '/[0-9]/ {for(i=1;i<=NF;i++) if($i ~ /^[0-9]+$/ && $i > 1000) print $i; exit}')
                fi
            else
                log_verbose "df 工具不可用，跳過磁碟空間檢查"
            fi
            if [[ -n "$available_space" ]] && [[ "$available_space" -lt "$REQUIRED_SPACE_KB" ]]; then
                log_error "磁碟空間不足。需要至少 $((REQUIRED_SPACE_KB / 1024))MB 可用空間。" "disk-space-check"
                exit 1
            fi
        fi
    fi
    
    # 平台特定檢查
    if [[ "$OS" == "macOS" ]]; then
        # macOS 特定檢查
        if ! command -v sw_vers &> /dev/null; then
            log_verbose "在 macOS 上執行但找不到 sw_vers"
        else
            log_verbose "macOS 版本：$(sw_vers -productVersion)"
        fi
    fi
    
    log_verbose "預檢查通過"
}

# 從預設位置載入配置
load_default_config() {
    # 系統級配置
    if [[ -f "/etc/superclaude.conf" ]]; then
        load_config "/etc/superclaude.conf"
    fi
    
    # 使用者配置
    if [[ -f "$HOME/.superclaude.conf" ]]; then
        load_config "$HOME/.superclaude.conf"
    fi
    
    # 本地配置
    if [[ -f ".superclaude.conf" ]]; then
        load_config ".superclaude.conf"
    fi
}

# 載入預設配置
load_default_config

# 解析命令行參數
while [[ $# -gt 0 ]]; do
    case $1 in
        --dir)
            if [[ -z "$2" ]] || [[ "$2" == --* ]]; then
                log_error "--dir 需要目錄參數"
                exit 1
            fi
            
            # 驗證目錄路徑
            if ! validate_directory_path "$2"; then
                log_error "無效的安裝目錄：$2"
                exit 1
            fi
            
            INSTALL_DIR="$2"
            shift 2
            ;;
        --force)
            FORCE_INSTALL=true
            shift
            ;;
        --update)
            UPDATE_MODE=true
            shift
            ;;
        --uninstall)
            UNINSTALL_MODE=true
            shift
            ;;
        --verify-checksums)
            VERIFY_MODE=true
            shift
            ;;
        --verbose)
            VERBOSE=true
            shift
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --config)
            if [[ -z "$2" ]] || [[ "$2" == --* ]]; then
                log_error "--config 需要檔案參數"
                exit 1
            fi
            if [[ -f "$2" ]]; then
                load_config "$2"
            else
                log_error "找不到配置檔案：$2"
                exit 1
            fi
            shift 2
            ;;
        --no-rollback)
            ROLLBACK_ON_FAILURE=false
            shift
            ;;
        --check-update)
            check_for_updates
            exit $?
            ;;
        --log)
            if [[ -z "$2" ]] || [[ "$2" == --* ]]; then
                log_error "--log 需要檔案參數"
                exit 1
            fi
            
            # 驗證日誌檔案路徑
            if [[ "$2" =~ [[:cntrl:]] ]]; then
                log_error "日誌檔案路徑中有無效字元：$2"
                exit 1
            fi
            
            # 檢查日誌檔案中的路徑遍歷
            if [[ "$2" =~ \.\./|/\.\. ]]; then
                log_error "日誌檔案路徑中不允許路徑遍歷：$2"
                exit 1
            fi
            
            LOG_FILE="$2"
            # 如果需要，建立日誌目錄
            log_dir=$(dirname "$LOG_FILE")
            if [[ ! -d "$log_dir" ]]; then
                if ! mkdir -p "$log_dir" 2>/dev/null; then
                    log_error "無法建立日誌目錄：$log_dir"
                    log_error "檢查權限和路徑有效性"
                    exit 1
                fi
            fi
            
            # 測試是否可以寫入日誌檔案
            if ! touch "$LOG_FILE" 2>/dev/null; then
                log_error "無法寫入日誌檔案：$LOG_FILE"
                log_error "檢查權限和目錄存在"
                exit 1
            fi
            
            shift 2
            ;;
        --version)
            echo "SuperClaude 安裝程式 v$SCRIPT_VERSION"
            exit 0
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        *)
            echo -e "${RED}錯誤：未知選項 $1${NC}"
            show_usage
            exit 1
            ;;
    esac
done

# 如果是相對路徑則轉換為絕對路徑
if [[ ! "$INSTALL_DIR" = /* ]]; then
    # 檢查父目錄是否存在
    parent_dir=$(dirname "$INSTALL_DIR")
    if [[ ! -d "$parent_dir" ]]; then
        echo -e "${RED}錯誤：父目錄 '$parent_dir' 不存在${NC}"
        exit 1
    fi
    INSTALL_DIR="$(cd "$parent_dir" && pwd)/$(basename "$INSTALL_DIR")" || {
        echo -e "${RED}錯誤：無法解析安裝目錄${NC}"
        exit 1
    }
fi

# 處理解除安裝模式
if [[ "$UNINSTALL_MODE" = true ]]; then
    echo -e "${GREEN}SuperClaude 解除安裝程式${NC}"
    echo "========================"
    echo -e "目標目錄：${YELLOW}$INSTALL_DIR${NC}"
    echo ""
    
    if [[ ! -d "$INSTALL_DIR" ]]; then
        echo -e "${RED}錯誤：在 $INSTALL_DIR 找不到 SuperClaude${NC}"
        exit 1
    fi
    
    if [[ "$FORCE_INSTALL" != true ]]; then
        echo -e "${YELLOW}這將從 $INSTALL_DIR 移除 SuperClaude${NC}"
        echo -n "您確定要繼續嗎？(y/n)："
        read -r confirm_uninstall
        if [ "$confirm_uninstall" != "y" ]; then
            echo "解除安裝已取消。"
            exit 0
        fi
    fi
    
    echo "正在移除 SuperClaude 檔案並保留使用者資料..."
    
    # 移除 SuperClaude 檔案但保留使用者資料
    removed_count=0
    preserved_count=0
    
    # 首先，移除所有 SuperClaude 檔案（將從來源安裝的檔案）
    if [[ -d "$INSTALL_DIR" ]]; then
        # 從來源取得將安裝的檔案清單
        current_dir=$(pwd)
        cd "$INSTALL_DIR" || exit 1
        
        # 處理檔案並正確計數（修復變數範圍問題）
        while IFS= read -r installed_file; do
            installed_file="${installed_file#./}"  # 移除開頭的 ./
            
            if is_preserve_file "$installed_file"; then
                echo "  保留：$installed_file"
                ((preserved_count++))
            else
                # 檢查此檔案是否存在於來源中（是 SuperClaude 檔案）
                # 驗證 current_dir 路徑以防止路徑遍歷
                if [[ "$current_dir" =~ \.\. ]]; then
                    log_error "檢測到無效的當前目錄路徑：$current_dir"
                    continue
                fi
                
                # 只移除我們知道已安裝的檔案
                if [[ -f "$current_dir/zh-TW/.claude/$installed_file" ]] || 
                   [[ "$installed_file" == "CLAUDE.md" && -f "$current_dir/zh-TW/CLAUDE.md" ]] || 
                   [[ "$installed_file" == "VERSION" && -f "$current_dir/VERSION" ]] || 
                   [[ "$installed_file" == ".checksums" && -f "$current_dir/.checksums" ]]; then
                    if [[ "$DRY_RUN" = true ]]; then
                        echo "  將移除：$installed_file"
                    else
                        echo "  正在移除：$installed_file"
                        rm -f "$installed_file"
                    fi
                    ((removed_count++))
                fi
            fi
        done < <(get_installed_files "$INSTALL_DIR")
        
        # 移除空目錄，但如果包含保留檔案則不移除主目錄
        if [[ "$DRY_RUN" != true ]]; then
            find . -type d -empty -delete 2>/dev/null || true
        fi
        
        cd "$current_dir" || exit 1
        
        # 檢查主目錄是否為空（沒有保留檔案）
        if [[ -z "$(ls -A "$INSTALL_DIR" 2>/dev/null)" ]]; then
            if [[ "$DRY_RUN" != true ]]; then
                rmdir "$INSTALL_DIR" 2>/dev/null || true
            fi
            echo -e "${GREEN}✓ SuperClaude 已完全解除安裝！${NC}"
        else
            echo ""
            echo -e "${GREEN}✓ SuperClaude 已成功解除安裝！${NC}"
            echo -e "${YELLOW}注意：使用者資料檔案保留在 $INSTALL_DIR${NC}"
        fi
        
        # 顯示摘要
        echo ""
        echo "摘要："
        echo "  已移除的檔案：$removed_count"
        echo "  已保留的檔案：$preserved_count"
    fi
    exit 0
fi

# 處理驗證模式
if [[ "$VERIFY_MODE" = true ]]; then
    echo -e "${GREEN}SuperClaude 驗證${NC}"
    echo "========================="
    echo -e "目標目錄：${YELLOW}$INSTALL_DIR${NC}"
    echo ""
    
    if [[ ! -d "$INSTALL_DIR" ]]; then
        echo -e "${RED}錯誤：在 $INSTALL_DIR 找不到 SuperClaude${NC}"
        exit 1
    fi
    
    # 檢查我們是否在 SuperClaude 目錄中
    if [ ! -f "zh-TW/CLAUDE.md" ] || [ ! -d "zh-TW/.claude" ] || [ ! -d "zh-TW/.claude/commands" ]; then
        echo -e "${RED}錯誤：此腳本必須從 SuperClaude 目錄執行${NC}"
        echo ""
        echo "找不到預期的檔案。請確保您在 SuperClaude 根目錄中。"
        echo "缺少：$([ ! -f "zh-TW/CLAUDE.md" ] && echo "zh-TW/CLAUDE.md ")$([ ! -d "zh-TW/.claude" ] && echo "zh-TW/.claude/ ")$([ ! -d "zh-TW/.claude/commands" ] && echo "zh-TW/.claude/commands/")"
        echo ""
        echo "解決方案：cd 到 SuperClaude 目錄並執行：./install-zh-TW.sh --verify-checksums"
        exit 1
    fi
    
    # 檢查校驗和檔案是否存在
    checksums_file="$INSTALL_DIR/.checksums"
    if [[ ! -f "$checksums_file" ]]; then
        echo -e "${YELLOW}警告：在 $checksums_file 找不到校驗和檔案${NC}"
        echo "安裝可能是使用舊版本的安裝程式完成的。"
        echo ""
    fi
    
    # 驗證安裝與來源
    echo "正在驗證安裝完整性..."
    
    if ! command -v sha256sum &> /dev/null; then
        echo -e "${YELLOW}警告：sha256sum 不可用，無法驗證校驗和${NC}"
        echo "改為執行基本檔案比較..."
        
        # 基本檔案存在檢查
        missing_files=0
        total_checked=0
        
        while IFS= read -r file; do
            ((total_checked++))
            if [[ ! -f "$INSTALL_DIR/$file" ]]; then
                echo -e "  缺少：$file"
                ((missing_files++))
            fi
        done < <(get_source_files ".")
        
        echo ""
        echo "已檢查的檔案：$total_checked"
        echo "缺少的檔案：$missing_files"
        
        if [[ $missing_files -eq 0 ]]; then
            echo -e "${GREEN}✓ 所有檔案都存在${NC}"
        else
            echo -e "${RED}✗ 某些檔案缺失${NC}"
            exit 1
        fi
    else
        # 完整校驗和驗證
        verification_failures=0
        files_checked=0
        files_missing=0
        
        while IFS= read -r file; do
            ((files_checked++))
            src_file="./zh-TW/.claude/$file"
            if [[ "$file" == "CLAUDE.md" ]]; then
                src_file="./zh-TW/$file"
            fi
            dest_file="$INSTALL_DIR/$file"
            
            if [[ ! -f "$dest_file" ]]; then
                echo -e "  缺少：$file"
                ((files_missing++))
            elif ! verify_file_integrity "$src_file" "$dest_file"; then
                echo -e "  不符：$file"
                ((verification_failures++))
            else
                log_verbose "  已驗證：$file"
            fi
        done < <(get_source_files ".")
        
        echo ""
        echo "摘要："
        echo "  已檢查的檔案：$files_checked"
        echo "  缺少的檔案：$files_missing"
        echo "  校驗和不符：$verification_failures"
        echo ""
        
        if [[ $files_missing -eq 0 ]] && [[ $verification_failures -eq 0 ]]; then
            echo -e "${GREEN}✓ 安裝驗證成功！${NC}"
            echo "所有檔案都符合來源。"
        else
            echo -e "${RED}✗ 驗證失敗${NC}"
            if [[ $files_missing -gt 0 ]]; then
                echo "安裝中缺少某些檔案。"
            fi
            if [[ $verification_failures -gt 0 ]]; then
                echo "某些檔案與來源不同（可能已自訂）。"
            fi
            exit 1
        fi
    fi
    
    exit 0
fi

echo -e "${GREEN}SuperClaude 繁體中文版安裝程式${NC}"
echo "================================"
echo -e "安裝目錄：${YELLOW}$INSTALL_DIR${NC}"
if [[ "$DRY_RUN" = true ]]; then
    echo -e "${BLUE}模式：模擬執行（不會進行任何變更）${NC}"
fi
if [[ "$VERBOSE" = true ]]; then
    echo -e "${BLUE}模式：詳細輸出${NC}"
fi
if [[ -n "$LOG_FILE" ]]; then
    echo -e "日誌檔案：${YELLOW}$LOG_FILE${NC}"
fi
echo ""

# 執行預檢查
run_preflight_checks

# 檢查寫入權限（使用原子測試）- 在模擬執行模式下跳過
if [[ "$DRY_RUN" != true ]]; then
    parent_for_write=$(dirname "$INSTALL_DIR")
    write_test_file=""
    
    if [[ -d "$INSTALL_DIR" ]]; then
        # 目錄存在，使用 mktemp 原子測試寫入權限
        write_test_file=$(mktemp "$INSTALL_DIR/.write_test_XXXXXX" 2>/dev/null) || {
            log_error "沒有 $INSTALL_DIR 的寫入權限"
            exit 1
        }
        rm -f "$write_test_file" 2>/dev/null
    else
        # 目錄不存在，測試父目錄寫入權限
        if [[ ! -d "$parent_for_write" ]]; then
            log_error "父目錄不存在：$parent_for_write"
            exit 1
        fi
        write_test_file=$(mktemp "$parent_for_write/.write_test_XXXXXX" 2>/dev/null) || {
            log_error "沒有權限建立 $INSTALL_DIR"
            exit 1
        }
        rm -f "$write_test_file" 2>/dev/null
    fi
fi

# 確認提示（如果沒有使用 --force 則跳過）
if [[ "$FORCE_INSTALL" != true ]]; then
    if [[ "$UPDATE_MODE" = true ]]; then
        echo -e "${YELLOW}這將更新 $INSTALL_DIR 中的 SuperClaude${NC}"
    else
        echo -e "${YELLOW}這將在 $INSTALL_DIR 安裝 SuperClaude 繁體中文版${NC}"
    fi
    echo -n "您確定要繼續嗎？(y/n)："
    read -r confirm_install
    if [ "$confirm_install" != "y" ]; then
        echo "安裝已取消。"
        exit 0
    fi
fi
echo ""

# 檢查我們是否在 SuperClaude 目錄中
if [ ! -f "zh-TW/CLAUDE.md" ] || [ ! -d "zh-TW/.claude" ] || [ ! -d "zh-TW/.claude/commands" ]; then
    echo -e "${RED}錯誤：此腳本必須從 SuperClaude 目錄執行${NC}"
    echo ""
    echo "找不到預期的檔案。請確保您在 SuperClaude 根目錄中，並且 zh-TW 目錄已建立。"
    echo "缺少：$([ ! -f "zh-TW/CLAUDE.md" ] && echo "zh-TW/CLAUDE.md ")$([ ! -d "zh-TW/.claude" ] && echo "zh-TW/.claude/ ")$([ ! -d "zh-TW/.claude/commands" ] && echo "zh-TW/.claude/commands/")"
    echo ""
    echo "解決方案：cd 到 SuperClaude 目錄並執行：./install-zh-TW.sh"
    exit 1
fi

# 取得版本資訊
SUPERCLAUDE_VERSION="unknown"
if [[ -f "VERSION" ]] && [[ -r "VERSION" ]]; then
    SUPERCLAUDE_VERSION=$(< VERSION) || SUPERCLAUDE_VERSION="unknown"
fi
log_verbose "SuperClaude 版本：$SUPERCLAUDE_VERSION"

# 檢查現有安裝版本
if [[ -f "$INSTALL_DIR/VERSION" ]] && [[ -r "$INSTALL_DIR/VERSION" ]]; then
    INSTALLED_VERSION=$(< "$INSTALL_DIR/VERSION") || INSTALLED_VERSION="unknown"
    log_verbose "已安裝版本：$INSTALLED_VERSION"
    
    if [[ "$UPDATE_MODE" = true ]]; then
        echo "當前版本：$INSTALLED_VERSION"
        echo "新版本：$SUPERCLAUDE_VERSION"
        echo ""
    fi
fi

# 檢查現有目錄是否存在並有檔案
if [ -d "$INSTALL_DIR" ] && [ "$(ls -A "$INSTALL_DIR" 2>/dev/null)" ]; then
    echo -e "${YELLOW}在 $INSTALL_DIR 找到現有配置${NC}"
    
    # 在更新模式下，總是備份
    if [[ "$UPDATE_MODE" = true ]] || [[ "$FORCE_INSTALL" = true ]]; then
        backup_choice="y"
    else
        echo -n "備份現有配置？(y/n)："
        read -r backup_choice
    fi
    
    if [ "$backup_choice" = "y" ]; then
        # 使用安全隨機後綴建立備份目錄
        backup_timestamp=$(date +%Y%m%d_%H%M%S)
        # 生成加密安全的隨機後綴 - 嘗試多種方法
        backup_random=""
        random_bytes=""
        
        # 嘗試多個安全隨機來源
        if [[ -r /dev/urandom ]]; then
            random_bytes=$(head -c 16 /dev/urandom 2>/dev/null | od -An -tx1 | tr -d ' \n')
        elif command -v openssl &>/dev/null; then
            random_bytes=$(openssl rand -hex 16 2>/dev/null)
        elif [[ -r /dev/random ]]; then
            # 使用 /dev/random 作為備用（可能會阻塞）
            random_bytes=$(timeout 5 head -c 16 /dev/random 2>/dev/null | od -An -tx1 | tr -d ' \n')
        fi
        
        # 從多個來源生成額外的熵
        if [[ -n "$random_bytes" ]]; then
            backup_random="$random_bytes"
        else
            # 使用多個來源的高熵備用（改進）
            entropy_sources="$(date +%s%N 2>/dev/null)$$${RANDOM}${BASHPID:-$$}$(ps -eo pid,ppid,time 2>/dev/null | md5sum 2>/dev/null | cut -c1-8)"
            backup_random=$(printf "%s" "$entropy_sources" | sha256sum 2>/dev/null | cut -c1-16)
        fi
        
        # 確保 backup_random 不為空
        backup_random="${backup_random:-$(date +%s)$$}"
        
        # 使用限制性權限建立備份目錄
        BACKUP_DIR="$(dirname "$INSTALL_DIR")/superclaude-backup.${backup_timestamp}.${backup_random}"
        if ! mkdir -p "$BACKUP_DIR"; then
            log_error "無法建立備份目錄：$BACKUP_DIR"
            exit 1
        fi
        
        # 在備份目錄上設定限制性權限（僅擁有者）
        chmod 700 "$BACKUP_DIR" || log_warning "無法在備份目錄上設定限制性權限"
        
        # 備份所有現有檔案，包括隱藏檔案
        echo "正在備份所有現有檔案..."
        
        # 使用 find 包括隱藏檔案並處理特殊情況
        if ! cd "$INSTALL_DIR"; then
            log_error "無法進入安裝目錄：$INSTALL_DIR"
            log_error "檢查權限和目錄存在"
            exit 1
        fi
        
        # 尋找所有檔案和目錄，包括隱藏的
        find . -mindepth 1 -maxdepth 1 \( -name "superclaude-backup.*" -prune \) -o -print0 | \
        while IFS= read -r -d '' item; do
            # 保留權限和符號連結的複製，並進行安全檢查
            if [[ -e "$item" ]]; then
                # 驗證項目在安裝目錄內（防止符號連結攻擊）
                real_item=""
                if command -v realpath &>/dev/null; then
                    real_item=$(realpath "$item" 2>/dev/null)
                    real_install_dir=$(realpath "$INSTALL_DIR" 2>/dev/null)
                    if [[ -n "$real_item" ]] && [[ -n "$real_install_dir" ]] && [[ "$real_item" != "$real_install_dir"/* ]]; then
                        log_warning "跳過安裝目錄外可疑項目的備份：$item"
                        continue
                    fi
                fi
                
                cp -rP "$item" "$BACKUP_DIR/" || {
                    log_warning "無法備份：$item"
                }
            fi
        done
        
        if ! cd "$ORIGINAL_DIR"; then
            log_error "無法返回原始目錄：$ORIGINAL_DIR"
            log_error "這可能會影響後續操作"
            # 不要在此退出，因為備份已成功
        fi
        
        echo -e "${GREEN}已將現有檔案備份到：$BACKUP_DIR${NC}"
    fi
elif [ -d "$INSTALL_DIR" ]; then
    echo -e "${YELLOW}目錄 $INSTALL_DIR 存在但為空${NC}"
fi

# 在更新模式下，在複製新檔案之前清理過時的檔案
if [[ "$UPDATE_MODE" = true ]] && [[ -d "$INSTALL_DIR" ]]; then
    echo ""
    echo "正在檢查過時的檔案..."
    
    # 尋找過時的檔案
    obsolete_files=$(find_obsolete_files "." "$INSTALL_DIR")
    
    if [[ -n "$obsolete_files" ]]; then
        cleanup_obsolete_files "$INSTALL_DIR" "$obsolete_files"
    else
        echo "沒有找到過時的檔案。"
    fi
fi

echo ""
if [[ "$UPDATE_MODE" = true ]]; then
    echo "正在更新 SuperClaude 繁體中文版..."
else
    echo "正在安裝 SuperClaude 繁體中文版..."
fi

# 標記我們正在進入安裝階段
INSTALLATION_PHASE=true

# 基於來源動態建立目錄結構
if [[ "$DRY_RUN" != true ]]; then
    echo "正在建立目錄結構..."
    # 尋找 zh-TW/.claude 中的所有目錄並在目標中建立它們（不含 zh-TW/.claude 前綴）
    find zh-TW/.claude -type d \
        -not -path "*/.git*" \
        -not -path "*/backup.*" \
        -not -path "*/log" \
        -not -path "*/log/*" \
        -not -path "*/logs" \
        -not -path "*/logs/*" \
        -not -path "*/.log" \
        -not -path "*/.log/*" \
        -not -path "*/.logs" \
        -not -path "*/.logs/*" \
        | while read -r dir; do
        # 去除 zh-TW/.claude/ 前綴
        target_dir="${dir#zh-TW/.claude/}"
        if [[ -n "$target_dir" ]] && [[ "$target_dir" != "." ]]; then
            mkdir -p "$INSTALL_DIR/$target_dir" || {
                log_error "無法建立目錄：$INSTALL_DIR/$target_dir"
                exit 1
            }
        fi
    done
else
    echo "將建立目錄結構..."
fi

# 函數：使用更新模式處理和完整性驗證複製檔案
copy_with_update_check() {
    local src_file="$1"
    local dest_file="$2"
    local basename_file=$(basename "$src_file")
    local copy_performed=false
    local target_file="$dest_file"
    local retry_count=0
    local max_retries=3
    
    # 驗證輸入
    if [[ -z "$src_file" ]] || [[ -z "$dest_file" ]]; then
        log_error "copy_with_update_check：需要來源和目標檔案"
        return 1
    fi
    
    if [[ ! -f "$src_file" ]]; then
        log_error "copy_with_update_check：來源檔案不存在：$src_file"
        return 1
    fi
    
    if [[ ! -r "$src_file" ]]; then
        log_error "copy_with_update_check：無法讀取來源檔案：$src_file"
        return 1
    fi
    
    # 增強的來源檔案驗證和除錯資訊
    log_verbose "嘗試複製：$src_file -> $dest_file"
    if [[ ! -f "$src_file" ]]; then
        log_error "copy_with_update_check：增強檢查期間來源檔案不存在：$src_file"
        return 1
    fi
    
    # 驗證目標目錄存在
    local dest_dir=$(dirname "$dest_file")
    if [[ ! -d "$dest_dir" ]]; then
        log_error "copy_with_update_check：目標目錄不存在：$dest_dir"
        return 1
    fi
    
    if [[ "$UPDATE_MODE" = true ]] && [[ -f "$dest_file" ]]; then
        # 檢查檔案是否與來源不同
        if ! cmp -s "$src_file" "$dest_file"; then
            # 檢查是否為可能自訂的主配置檔案
            local is_customizable=false
            for config in "${CUSTOMIZABLE_CONFIGS[@]}"; do
                if [[ "$basename_file" == "$config" ]]; then
                    is_customizable=true
                    break
                fi
            done
            
            if [[ "$is_customizable" = true ]]; then
                echo "  保留自訂的 $basename_file（新版本：$basename_file.new）"
                if [[ "$DRY_RUN" != true ]]; then
                    # 使用錯誤捕獲重試複製操作
                    while [[ $retry_count -lt $max_retries ]]; do
                        if cp_error=$(cp "$src_file" "$dest_file.new" 2>&1); then
                            target_file="$dest_file.new"
                            copy_performed=true
                            break
                        else
                            ((retry_count++))
                            log_warning "複製嘗試 $retry_count 失敗於 $basename_file.new：$cp_error"
                            sleep 1
                        fi
                    done
                    
                    if [[ $retry_count -eq $max_retries ]]; then
                        log_error "在 $max_retries 次嘗試後無法複製：$src_file 到 $dest_file.new"
                        return 1
                    fi
                fi
            else
                if [[ "$DRY_RUN" != true ]]; then
                    # 使用錯誤捕獲重試複製操作
                    while [[ $retry_count -lt $max_retries ]]; do
                        if cp_error=$(cp "$src_file" "$dest_file" 2>&1); then
                            copy_performed=true
                            break
                        else
                            ((retry_count++))
                            log_warning "複製嘗試 $retry_count 失敗於 $basename_file：$cp_error"
                            sleep 1
                        fi
                    done
                    
                    if [[ $retry_count -eq $max_retries ]]; then
                        log_error "在 $max_retries 次嘗試後無法複製：$src_file 到 $dest_file"
                        return 1
                    fi
                fi
            fi
        else
            if [[ "$DRY_RUN" != true ]]; then
                # 檔案相同，仍然複製以確保權限正確
                if cp_error=$(cp "$src_file" "$dest_file" 2>&1); then
                    copy_performed=true
                else
                    log_warning "無法更新相同檔案 $basename_file：$cp_error"
                    # 這是非關鍵的，不要讓安裝失敗
                fi
            fi
        fi
    else
        if [[ "$DRY_RUN" != true ]]; then
            # 使用錯誤捕獲重試複製操作
            while [[ $retry_count -lt $max_retries ]]; do
                if cp_error=$(cp "$src_file" "$dest_file" 2>&1); then
                    sync 2>/dev/null || true  # 確保檔案已寫入
                    copy_performed=true
                    break
                else
                    ((retry_count++))
                    log_warning "複製嘗試 $retry_count 失敗於 $basename_file：$cp_error"
                    sleep 1
                fi
            done
            
            if [[ $retry_count -eq $max_retries ]]; then
                log_error "在 $max_retries 次嘗試後無法複製：$src_file 到 $dest_file"
                return 1
            fi
        fi
    fi
    
    # 使用恢復在複製後驗證完整性
    if [[ "$copy_performed" = true ]] && [[ "$DRY_RUN" != true ]]; then
        # 在驗證前暫停以確保檔案系統一致性
        sleep 0.1
        if ! verify_file_integrity "$src_file" "$target_file"; then
            log_warning "$basename_file 的初始完整性驗證失敗，嘗試恢復..."
            
            # 嘗試再次複製檔案
            if cp_error=$(cp "$src_file" "$target_file" 2>&1); then
                sleep 0.1  # 在驗證前暫停
                if verify_file_integrity "$src_file" "$target_file"; then
                    log_verbose "恢復成功：$basename_file 的完整性已驗證"
                else
                    log_error "恢復嘗試後 $basename_file 的完整性驗證失敗"
                    ((VERIFICATION_FAILURES++))
                    return 1
                fi
            else
                log_error "$basename_file 的恢復複製失敗：$cp_error"
                ((VERIFICATION_FAILURES++))
                return 1
            fi
        else
            log_verbose "$basename_file 的完整性已驗證"
        fi
    fi
    
    return 0
}

# 動態複製所有檔案
echo "正在複製檔案..."
# 取得進度追蹤的總檔案數
total_files=$(get_source_files "." | wc -l)
log_verbose "找到 $total_files 個要處理的檔案"
current_file=0
copied_count=0
preserved_count=0

# 使用進度追蹤處理檔案
while IFS= read -r file; do
    if [[ -n "$file" ]]; then
        current_file=$((current_file + 1))
        log_verbose "處理檔案 $current_file/$total_files：$file"
        
        # 確定來源檔案路徑
        if [[ "$file" == "CLAUDE.md" ]]; then
            src_file="./zh-TW/$file"
        else
            src_file="./zh-TW/.claude/$file"
        fi
        
        dest_file="$INSTALL_DIR/$file"
        
        # 顯示進度 - 簡化
        if [[ "$VERBOSE" = true ]]; then
            echo "  進度：[$current_file/$total_files] 處理中：$file"
        fi
        
        # 如果需要，建立父目錄
        dest_dir=$(dirname "$dest_file")
        if [[ "$DRY_RUN" != true ]]; then
            mkdir -p "$dest_dir" || {
                log_error "無法建立目錄：$dest_dir"
                continue
            }
        fi
        
        # 檢查這是否為保留的使用者檔案
        if is_preserve_file "$file" && [[ -f "$dest_file" ]]; then
            log_verbose "保留使用者檔案：$file"
            preserved_count=$((preserved_count + 1))
        else
            # 複製檔案
            if [[ "$DRY_RUN" != true ]]; then
                if cp "$src_file" "$dest_file"; then
                    log_verbose "  已複製：$file"
                else
                    log_error "  複製失敗：$src_file -> $dest_file"
                fi
                
                # 使腳本可執行
                if [[ "$file" == *.sh ]] || [[ "$file" == *.py ]] || [[ "$file" == *.rb ]] || [[ "$file" == *.pl ]]; then
                    chmod +x "$dest_file" || {
                        log_warning "無法在 $dest_file 上設定可執行權限"
                    }
                fi
            fi
            copied_count=$((copied_count + 1))
        fi
    fi
done <<< "$(get_source_files ".")"

# 複製 VERSION 檔案
if [[ "$DRY_RUN" != true ]]; then
    if [[ -f "VERSION" ]]; then
        cp "VERSION" "$INSTALL_DIR/VERSION" || {
            log_warning "無法複製 VERSION 檔案"
        }
    fi
fi

# 清除進度行並顯示摘要
# （簡化 - 無終端控制）
echo "  已複製的檔案：$copied_count"
echo "  已保留的檔案：$preserved_count"


# 驗證安裝
echo ""
echo "正在驗證安裝..."

# 報告複製操作中的驗證失敗
if [[ $VERIFICATION_FAILURES -gt 0 ]]; then
    echo -e "${RED}警告：$VERIFICATION_FAILURES 個檔案在複製期間完整性驗證失敗${NC}"
fi

# 為已安裝的檔案生成校驗和
if command -v sha256sum &> /dev/null && [[ "$DRY_RUN" != true ]]; then
    echo "正在為已安裝的檔案生成校驗和..."
    checksums_file="$INSTALL_DIR/.checksums"
    
    # 建立校驗和檔案
    > "$checksums_file"
    
    # 為所有已安裝的檔案生成校驗和
    if ! cd "$INSTALL_DIR"; then
        log_error "無法進入安裝目錄以生成校驗和：$INSTALL_DIR"
        log_warning "跳過校驗和生成"
    else
    
    # 使用進程替換以避免子 shell 問題
    while IFS= read -r file; do
        # 跳過空檔案
        if [[ -s "$file" ]]; then
            checksum=$(sha256sum "$file" 2>/dev/null | awk '{print $1}')
            if [[ -n "$checksum" ]]; then
                echo "$checksum  $file" >> "$checksums_file"
            fi
        fi
    done < <(find . -type f -not -path "./superclaude-backup.*" -not -name ".checksums" | sort)
    
        cd "$ORIGINAL_DIR" || { log_error "無法返回原始目錄"; exit 1; }
        
        log_verbose "在 $checksums_file 生成了校驗和檔案"
    fi
else
    log_verbose "sha256sum 不可用或模擬執行模式，跳過校驗和生成"
fi

# 從來源取得預期的檔案
expected_files=$(get_source_files "." | wc -l)
# 只計算已安裝的來源檔案（排除生成的檔案如 .checksums）
actual_files=$(get_source_files "." | while IFS= read -r file; do
    if [[ -f "$INSTALL_DIR/$file" ]]; then
        echo "$file"
    fi
done | wc -l)

# 按類別計算檔案以進行詳細報告
main_files=$(find "$INSTALL_DIR" -maxdepth 1 -name "*.md" -type f 2>/dev/null | wc -l)
command_files=$(find "$INSTALL_DIR/commands" -maxdepth 1 -name "*.md" -type f 2>/dev/null | wc -l)
shared_yml=$(find "$INSTALL_DIR/commands/shared" -name "*.yml" -type f 2>/dev/null | wc -l)
shared_scripts=$(find "$INSTALL_DIR/commands/shared" -name "*.sh" -type f 2>/dev/null | wc -l)
claude_shared=$(find "$INSTALL_DIR/shared" -name "*.yml" -type f 2>/dev/null | wc -l)

echo -e "總檔案數：${GREEN}$actual_files${NC}（預期：$expected_files）"
echo ""
echo "檔案明細："
echo -e "  主配置檔案：${GREEN}$main_files${NC}"
echo -e "  命令檔案：${GREEN}$command_files${NC}"
echo -e "  共享 YML 檔案：${GREEN}$shared_yml${NC}"
echo -e "  共享腳本：${GREEN}$shared_scripts${NC}"
echo -e "  Claude 共享檔案：${GREEN}$claude_shared${NC}"

# 驗證關鍵檔案存在
critical_files_ok=true
for critical_file in "CLAUDE.md" "commands" "shared"; do
    if [[ ! -e "$INSTALL_DIR/$critical_file" ]]; then
        echo -e "${YELLOW}警告：缺少關鍵檔案/目錄：$critical_file${NC}"
        critical_files_ok=false
    fi
done

# 檢查安裝是否成功
if [ "$actual_files" -ge "$expected_files" ] && [ "$critical_files_ok" = true ] && [ $VERIFICATION_FAILURES -eq 0 ]; then
    # 將安裝階段標記為完成
    INSTALLATION_PHASE=false
    
    echo ""
    if [[ "$UPDATE_MODE" = true ]]; then
        echo -e "${GREEN}✓ SuperClaude 繁體中文版更新成功！${NC}"
        echo ""
        # 檢查 .new 檔案
        new_files=$(find "$INSTALL_DIR" -name "*.new" 2>/dev/null)
        if [[ -n "$new_files" ]]; then
            echo -e "${YELLOW}注意：以下檔案有可用的更新：${NC}"
            echo "$new_files" | while read -r file; do
                echo "  - $file"
            done
            echo ""
            echo "檢視變更：diff <檔案> <檔案>.new"
            echo "套用更新：mv <檔案>.new <檔案>"
            echo ""
        fi
    else
        echo -e "${GREEN}✓ SuperClaude 繁體中文版安裝成功！${NC}"
        echo ""
        echo "後續步驟："
        echo "1. 使用 Claude Code 開啟任何專案"
        echo "2. 嘗試命令：/分析 --code"
        echo "3. 啟用角色：/分析 --角色-架構師"
        echo ""
        echo "所有命令都支援中英文："
        echo "  中文：/建構 --react --tdd"
        echo "  英文：/build --react --tdd"
        echo ""
    fi
    if [ -n "$BACKUP_DIR" ] && [ -d "$BACKUP_DIR" ]; then
        echo -e "${YELLOW}注意：您先前的配置已備份到：${NC}"
        echo "$BACKUP_DIR"
        echo ""
    fi
    echo "更多資訊，請參閱 README_zh-TW.md"
    
    # 保留 BACKUP_DIR 供使用者參考，但將安裝標記為完成
    INSTALLATION_PHASE=false
    log_verbose "安裝成功完成，回滾已停用"
else
    echo ""
    echo -e "${RED}✗ 安裝可能不完整${NC}"
    echo ""
    echo "預期與實際檔案數："
    echo "  總檔案數：$actual_files/$expected_files$([ "$actual_files" -lt "$expected_files" ] && echo " ❌" || echo " ✓")"
    if [ $VERIFICATION_FAILURES -gt 0 ]; then
        echo "  完整性失敗：$VERIFICATION_FAILURES ❌"
    fi
    echo ""
    
    # 列出任何缺少的檔案
    if [ "$actual_files" -lt "$expected_files" ]; then
        echo "缺少的檔案："
        comm -23 <(get_source_files "." | sort) <(get_installed_files "$INSTALL_DIR" | sort) | head -10 | while read -r file; do
            echo "  - $file"
        done
        echo ""
    fi
    
    echo "故障排除步驟："
    echo "1. 檢查上面的錯誤訊息"
    echo "2. 確保您對 $INSTALL_DIR 有寫入權限"
    echo "3. 驗證所有來源檔案都存在於當前目錄中"
    echo "4. 如果發生權限錯誤，請嘗試使用 sudo 執行"
    echo ""
    echo "有關手動安裝，請參閱 README_zh-TW.md"
    exit 1
fi

# 檢查所需的磁碟空間
check_disk_space() {
    local available
    available=$(df --output=avail "$INSTALL_DIR" 2>/dev/null | tail -1)
    if [[ -z "$available" || "$available" -lt "$REQUIRED_SPACE_KB" ]]; then
        echo -e "${RED}錯誤：$INSTALL_DIR 中沒有足夠的磁碟空間。${NC}"
        ((ERROR_COUNT++))
        ERROR_DETAILS+=("安裝的磁碟空間不足。")
        return 1
    fi
}

# 驗證安裝目錄
validate_install_dir() {
    if [[ ! -d "$(dirname "$INSTALL_DIR")" ]] || [[ ! -w "$(dirname "$INSTALL_DIR")" ]]; then
        echo -e "${RED}錯誤：無法寫入安裝目錄：$INSTALL_DIR${NC}"
        exit 1
    fi
}

# 如果啟用則回滾變更
rollback_changes() {
    echo -e "${YELLOW}正在回滾任何變更...（尚未實施）${NC}"
}