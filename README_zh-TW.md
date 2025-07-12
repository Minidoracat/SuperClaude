# SuperClaude – Claude Code 開發框架

[![授權：MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![版本](https://img.shields.io/badge/version-2.0.1-blue.svg)](https://github.com/NomenAK/SuperClaude)
[![GitHub issues](https://img.shields.io/github/issues/NomenAK/SuperClaude)](https://github.com/NomenAK/SuperClaude/issues)
[![歡迎 PR](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/NomenAK/SuperClaude/blob/master/CONTRIBUTING.md)

**一個設定框架，透過專門的命令、認知角色和開發方法論來增強 Claude Code。**

## 🚀 版本 2.0.1 更新

重要：透過移除 .claude 中的舊檔案和目錄（RULES.md、MCP.md、PERSONAS.md、CLAUDE.md 和 /commands 目錄）來重新開始

SuperClaude v2 引入了著重於可維護性和可擴展性的架構改進：

- **⚡ 簡化架構**：用於設定管理的 @include 參考系統
- **🎭 角色作為標誌**：9 個認知角色整合到標誌系統中（`--persona-architect`、`--persona-security` 等）
- **📦 增強安裝程式**：install.sh 具有更新模式、乾運行、備份處理和平台偵測
- **🔧 模組化設計**：用於新增命令和功能的範本系統
- **🎯 統一體驗**：所有命令的一致標誌行為

請參閱 [ROADMAP.md](ROADMAP.md) 了解未來開發想法和貢獻機會。

## 🎯 背景

Claude Code 提供強大的功能，但可以從以下方面受益：
- **專業知識** 用於不同的技術領域
- **代幣效率** 用於複雜專案
- **以證據為基礎的方法** 進行開發
- **上下文保存** 在除錯會話期間
- **特定領域的思維** 用於各種任務

## ✨ SuperClaude 功能

SuperClaude 透過以下方式增強 Claude Code：
- **18 個專門命令** 涵蓋開發生命週期任務
- **9 個認知角色** 用於特定領域的方法
- **代幣優化** 具有壓縮選項
- **以證據為基礎的方法論** 鼓勵文件化
- **MCP 整合** 與 Context7、Sequential、Magic、Puppeteer
- **Git 檢查點支援** 用於安全實驗
- **內省模式** 用於框架改進和疑難排解

## 🚀 安裝

### 增強安裝程式 v2.0.1

#### 🇹🇼 繁體中文版安裝
SuperClaude 現在提供完整的繁體中文版本，包含中文命令支援：

```bash
git clone https://github.com/NomenAK/SuperClaude.git
cd SuperClaude

# 安裝繁體中文版
./install-zh-TW.sh                     # 預設：~/.claude/

# 進階選項（與英文版相同）
./install-zh-TW.sh --dir /opt/claude   # 自訂位置
./install-zh-TW.sh --update            # 更新現有安裝
./install-zh-TW.sh --dry-run --verbose # 預覽更改並顯示詳細資訊
./install-zh-TW.sh --force             # 跳過確認（自動化）
./install-zh-TW.sh --log install.log   # 記錄所有操作
```

**繁體中文版特色：**
- 🀄 **中文命令**：支援 `/建構`、`/分析`、`/部署` 等中文命令
- 🌐 **雙語相容**：同時支援中英文命令（例如：`/build` 和 `/建構` 都可使用）
- 📝 **完整翻譯**：所有文檔、提示和錯誤訊息都已中文化
- 🎯 **保持功能**：與英文版功能完全相同

#### 英文版安裝
```bash
# 基本安裝
./install.sh                           # 預設：~/.claude/

# 進階選項
./install.sh --dir /opt/claude        # 自訂位置
./install.sh --update                 # 更新現有安裝
./install.sh --dry-run --verbose      # 預覽更改並顯示詳細資訊
./install.sh --force                  # 跳過確認（自動化）
./install.sh --log install.log        # 記錄所有操作
```

**v2.0.1 安裝程式功能：**
- 🔄 **更新模式**：在更新時保留自訂設定
- 👁️ **乾運行**：在套用之前預覽更改
- 💾 **智慧備份**：帶時間戳記的自動備份
- 🧹 **清理更新**：移除過時的檔案
- 🖥️ **平台偵測**：適用於 Linux、macOS、WSL
- 📊 **進度追蹤**：安裝回饋

零依賴。預設安裝到 `~/.claude/`。

**注意：** 安裝後，所有設定檔案都位於 `~/.claude/`（您的主目錄），而不是專案目錄中。

## 💡 核心功能

### 🧠 **認知角色（現在作為標誌！）**
使用角色標誌在不同方法之間切換：

```bash
# 繁體中文版 - 使用中文命令和角色
/分析 --code --角色-架構師              # 系統思維方法
/建構 --react --角色-前端               # 以 UX 為重點的開發
/掃描 --security --角色-安全專家        # 安全優先分析
/故障排除 --prod --角色-分析師          # 根本原因分析方法

# 英文版相容性 - 相同功能
/analyze --code --persona-architect     # 系統思維方法
/build --react --persona-frontend       # 以 UX 為重點的開發
/scan --security --persona-security     # 安全優先分析
/troubleshoot --prod --persona-analyzer # 根本原因分析方法
```

**v2.0.1 更新**：所有 9 個角色現在都是通用標誌，可在每個命令上使用，以便一致地存取專門方法。

### ⚡ **19 個命令**
開發生命週期涵蓋：

**開發命令**
```bash
# 繁體中文版
/建構 --react --magic --tdd    # 使用 AI 元件進行開發
/開發設置 --ci --monitor       # 環境設定
/測試 --coverage --e2e --pup   # 測試策略

# 英文版相容
/build --react --magic --tdd    # 使用 AI 元件進行開發
/dev-setup --ci --monitor       # 環境設定
/test --coverage --e2e --pup    # 測試策略
```

**分析與品質**
```bash
# 繁體中文版
/審查 --quality --evidence --角色-品保專家  # AI 驅動的程式碼審查
/分析 --architecture --seq                  # 系統分析

# 英文版相容
/review --quality --evidence --persona-qa   # AI 驅動的程式碼審查
/analyze --architecture --seq               # 系統分析
/troubleshoot --prod --five-whys # 問題解決
/improve --performance --iterate # 優化
/explain --depth expert --visual # 文件
```

**營運與安全**
```bash
/deploy --env prod --plan       # 部署規劃
/scan --security --owasp --deps # 安全稽核
/migrate --dry-run --rollback   # 資料庫遷移
/cleanup --all --validate       # 維護任務
```

### 🎛️ **MCP 整合**
- **Context7**：存取程式庫文件
- **Sequential**：多步驟推理功能
- **Magic**：AI 生成的 UI 元件
- **Puppeteer**：瀏覽器測試和自動化

**⚠️ 重要：** SuperClaude 不包含 MCP 伺服器。您需要在 Claude Code 的 MCP 設定中單獨安裝它們以使用 MCP 相關標誌（--c7、--seq、--magic、--pup）。

### 📊 **代幣效率**
SuperClaude 的 @include 範本系統有助於管理代幣使用：
- **UltraCompressed 模式** 用於減少代幣的選項
- **範本參考** 用於設定管理
- **快取機制** 以避免冗餘
- **上下文感知壓縮** 選項

## 🎮 範例工作流程

### 企業架構流程
```bash
/design --api --ddd --bounded-context --persona-architect    # 領域驅動設計
/estimate --detailed --worst-case --seq                      # 資源規劃
/scan --security --validate --persona-security               # 安全審查
/build --api --tdd --coverage --persona-backend              # 實作
```

### 生產問題解決
```bash
/troubleshoot --investigate --prod --persona-analyzer        # 分析
/analyze --profile --perf --seq                             # 效能審查
/improve --performance --threshold 95% --persona-performance # 優化
/test --integration --e2e --pup                             # 驗證
```

### 框架疑難排解與改進
```bash
/troubleshoot --introspect                                  # 除錯 SuperClaude 行為
/analyze --introspect --seq                                 # 分析框架模式
/improve --introspect --uc                                  # 優化代幣使用
```

### 全端功能開發
```bash
/build --react --magic --watch --persona-frontend           # UI 開發
/test --coverage --e2e --strict --persona-qa                # 品質保證
/scan --validate --deps --persona-security                  # 安全檢查
```

## 🎭 可用角色

| 角色 | 重點領域 | 工具 | 使用案例 |
|---------|-----------|-------|-----------|
| **architect** | 系統設計 | Sequential、Context7 | 架構規劃 |
| **frontend** | 使用者體驗 | Magic、Puppeteer、Context7 | UI 開發 |
| **backend** | 伺服器系統 | Context7、Sequential | API 開發 |
| **security** | 安全分析 | Sequential、Context7 | 安全審查 |
| **analyzer** | 問題解決 | 所有 MCP 工具 | 除錯 |
| **qa** | 品質保證 | Puppeteer、Context7 | 測試 |
| **performance** | 優化 | Puppeteer、Sequential | 效能調整 |
| **refactorer** | 程式碼品質 | Sequential、Context7 | 程式碼改進 |
| **mentor** | 知識分享 | Context7、Sequential | 文件 |

## 🛠️ 設定選項

### 思考深度控制
```bash
# 標準分析
/analyze --think

# 更深入的分析
/design --think-hard

# 最大深度
/troubleshoot --ultrathink
```

### 內省模式
```bash
# 啟用自我感知分析以改進 SuperClaude
/analyze --introspect

# 除錯 SuperClaude 行為
/troubleshoot --introspect --seq

# 優化框架效能
/improve --introspect --persona-performance
```

### 代幣管理
```bash
# 標準模式
/build --react --magic

# 使用壓縮
/analyze --architecture --uc

# 僅原生工具
/scan --security --no-mcp
```

### 以證據為基礎的開發
SuperClaude 鼓勵：
- 設計決策的文件
- 品質改進的測試
- 效能工作的指標
- 部署的安全驗證
- 架構選擇的分析

## 📋 命令類別

### 開發（3 個命令）
- `/build` - 具有堆疊範本的專案建構器
- `/dev-setup` - 開發環境設定
- `/test` - 測試框架

### 分析與改進（5 個命令）
- `/review` - AI 驅動的程式碼審查，具有以證據為基礎的建議
- `/analyze` - 程式碼和系統分析
- `/troubleshoot` - 除錯和問題解決
- `/improve` - 增強和優化
- `/explain` - 文件和解釋

### 營運（6 個命令）
- `/deploy` - 應用程式部署
- `/migrate` - 資料庫和程式碼遷移
- `/scan` - 安全和驗證
- `/estimate` - 專案估算
- `/cleanup` - 專案維護
- `/git` - Git 工作流程管理

### 設計與工作流程（5 個命令）
- `/design` - 系統架構
- `/spawn` - 平行任務執行
- `/document` - 文件建立
- `/load` - 專案上下文載入
- `/task` - 任務管理

## 🔧 技術架構 v2

SuperClaude v2 的架構實現了可擴展性：

**🏗️ 模組化設定**
- **CLAUDE.md** – 具有 @include 參考的核心設定
- **.claude/shared/** – 集中式 YAML 範本
- **commands/shared/** – 可重複使用的命令模式
- **@include 系統** – 設定的範本引擎

**🎯 統一命令系統**
- **19 個命令** – 開發生命週期涵蓋
- **標誌繼承** – 所有命令的通用標誌
- **角色整合** – 9 個認知模式作為標誌
- **範本驗證** – 參考完整性檢查

**📦 架構優勢**
- **單一真實來源** – 集中式更新
- **易於擴展** – 新增命令/標誌
- **一致行為** – 統一標誌處理
- **減少重複** – 基於範本的設定

**✅ 品質功能**
- **以證據為基礎的方法** – 鼓勵文件
- **研究整合** – 程式庫文件存取
- **錯誤恢復** – 優雅的失敗處理
- **結構化輸出** – 組織的檔案位置

## 📊 比較

| 方面 | 標準 Claude Code | SuperClaude 框架 |
|--------|---------------------|----------------------|
| **專業知識** | 一般回應 | 9 個專門角色 |
| **命令** | 手動指令 | 19 個工作流程命令 |
| **上下文** | 基於會話 | Git 檢查點支援 |
| **代幣** | 標準使用 | 壓縮選項 |
| **方法** | 通用目的 | 以證據為基礎 |
| **文件** | 按需 | 系統方法 |
| **品質** | 可變 | 驗證模式 |
| **整合** | 基本工具 | MCP 編排 |

## 🔮 使用案例

**開發團隊**
- 跨領域的一致方法
- 標準化工作流程
- 以證據為基礎的決策
- 文件實踐

**技術領導者**
- 架構審查
- 效能優化
- 程式碼品質改進
- 團隊知識分享

**營運**
- 部署程序
- 除錯工作流程
- 安全管理
- 維護任務

## 🎯 適用性

**適合：**
- ✅ 希望獲得一致 AI 協助的團隊
- ✅ 需要專門方法的專案
- ✅ 以證據為基礎的開發實踐
- ✅ 注重代幣的工作流程
- ✅ 特定領域的專業知識需求

**可能不適合：**
- ❌ 純手動工作流程
- ❌ 最小設定偏好
- ❌ 臨時開發風格
- ❌ 單一領域重點

## 🚦 入門

1. **安裝 SuperClaude**
   ```bash
   git clone https://github.com/NomenAK/SuperClaude.git && cd SuperClaude && ./install.sh
   ```

2. **驗證安裝**
   ```bash
   /load                                    # 載入專案上下文
   /analyze --code --think                  # 測試分析
   /analyze --architecture --persona-architect  # 嘗試角色
   ```

3. **範例工作流程**
   ```bash
   /design --api --ddd            # 架構設計
   /build --feature --tdd         # 實作
   /test --coverage --e2e         # 品質保證
   /deploy --env staging --plan   # 部署
   ```

## 🛟 支援

- **安裝說明**：執行 `./install.sh --help`
- **命令詳細資訊**：查看 `~/.claude/commands/`
- **貢獻**：請參閱 [CONTRIBUTING.md](CONTRIBUTING.md)
- **問題**：[GitHub Issues](https://github.com/NomenAK/SuperClaude/issues)

## 🤝 社群

SuperClaude 歡迎貢獻：
- **新角色** 用於專門工作流程
- **命令** 用於特定領域操作
- **模式** 用於開發實踐
- **整合** 用於生產力工具

加入社群：[討論](https://github.com/NomenAK/SuperClaude/discussions)

## 📈 版本 2.0.1 更改

**🎯 架構改進：**
- **設定管理**：@include 參考系統
- **代幣效率**：保持壓縮選項
- **命令系統**：統一標誌繼承
- **角色系統**：現在可作為標誌使用
- **安裝程式**：使用新模式增強
- **維護**：集中式設定

**📊 框架詳細資訊：**
- **命令**：19 個專門命令
- **角色**：9 種認知方法
- **MCP 伺服器**：4 個整合
- **方法論**：以證據為基礎的方法
- **使用**：由開發團隊使用

## 🎉 增強您的開發

SuperClaude 提供了一種結構化的方法來使用 Claude Code，具有專門的命令、角色和開發模式。

---

*SuperClaude v2.0.1 – Claude Code 的開發框架*

[⭐ 在 GitHub 上加星](https://github.com/NomenAK/SuperClaude) | [💬 討論](https://github.com/NomenAK/SuperClaude/discussions) | [🐛 回報問題](https://github.com/NomenAK/SuperClaude/issues)