# SuperClaude 命令參考 v2.0.1

## 目錄
- [快速開始](#快速開始)
- [通用旗標（所有命令都可用）](#通用旗標所有命令都可用)
- [角色作為旗標](#角色作為旗標)
- [完整命令參考](#完整命令參考)
- [旗標組合與最佳實踐](#旗標組合與最佳實踐)

---

## 快速開始

**基本用法**：`/命令 [旗標] [參數]`

**範例命令**：
```bash
/審查 --files src/ --quality --evidence    # 含證據的完整程式碼審查
/分析 --code --角色-架構師                 # 以架構師思維進行程式碼分析
/建構 --react --magic --tdd               # 建構含 AI 元件的 React 應用
/故障排除 --prod --five-whys --seq        # 使用推理進行生產環境除錯
/任務:建立 "新增使用者驗證"                # 建立和管理複雜功能
/部署 --env prod --plan --validate        # 安全的生產環境部署
```

**英文相容性**：所有命令同時支援英文版本（例如：`/build` 等同於 `/建構`）

---

## 通用旗標（所有命令都可用）

### 🧠 思考深度控制
| 旗標 | 說明 | Token 使用量 |
|------|-------------|-------------|
| `--think` / `--深度思考` | 多檔案分析與擴展上下文 | ~4K tokens |
| `--think-hard` / `--深層分析` | 架構層級深度分析 | ~10K tokens |
| `--ultrathink` / `--極限分析` | 關鍵系統分析與最大深度 | ~32K tokens |

### 📦 Token 優化
| 旗標 | 別名 | 說明 |
|------|-------|-------------|
| `--uc` | `--ultracompressed` / `--超壓縮` | 啟用超壓縮模式（大幅減少 token）|

### 🔧 MCP 伺服器控制
| 旗標 | 說明 |
|------|-------------|
| `--c7` | 啟用 Context7 文檔查詢 |
| `--seq` | 啟用順序思考分析 |
| `--magic` | 啟用 Magic UI 元件生成 |
| `--playwright` | 啟用 Playwright 瀏覽器自動化 |
| `--brave` | 啟用 Brave Search 即時網路搜尋 |
| `--graph` | 啟用 Graphiti Memory 知識持久化 |
| `--all-mcp` | 啟用所有 MCP 伺服器以獲得最大能力 |
| `--no-mcp` | 停用所有 MCP 伺服器（僅使用原生工具）|
| `--no-c7` | 特別停用 Context7 |
| `--no-seq` | 特別停用順序思考 |
| `--no-magic` | 特別停用 Magic UI 建構器 |
| `--no-playwright` | 特別停用 Playwright |
| `--no-brave` | 特別停用 Brave Search |
| `--no-graph` | 特別停用 Graphiti Memory |

### 🔍 分析與內省
| 旗標 | 說明 |
|------|-------------|
| `--introspect` / `--內省` | 啟用具有認知透明度的自我感知分析 |

### 📋 計劃與執行
| 旗標 | 說明 |
|------|-------------|
| `--plan` / `--計劃` | 在執行前顯示詳細的執行計劃 |
| `--dry-run` / `--模擬執行` | 預覽變更而不執行 |
| `--watch` / `--監視` | 持續監控與即時回饋 |
| `--interactive` / `--互動` | 逐步引導流程 |
| `--force` / `--強制` | 覆蓋安全檢查（謹慎使用）|

### ✅ 品質與驗證
| 旗標 | 說明 |
|------|-------------|
| `--validate` / `--驗證` | 增強的執行前安全檢查 |
| `--security` / `--安全` | 以安全為重點的分析和驗證 |
| `--coverage` / `--覆蓋率` | 生成完整的覆蓋率分析 |
| `--strict` / `--嚴格` | 零容忍模式與增強驗證 |

---

## 角色作為旗標

所有角色現在都整合為旗標，可在每個命令上使用：

| 角色旗標 | 專長 | 最適合 |
|--------------|-----------|----------|
| `--persona-architect` / `--角色-架構師` | 系統思維、可擴展性、模式 | 架構決策、系統設計 |
| `--persona-frontend` / `--角色-前端` | UI/UX 導向、無障礙優先 | 使用者介面、元件設計 |
| `--persona-backend` / `--角色-後端` | API、資料庫、可靠性 | 伺服器架構、資料建模 |
| `--persona-analyzer` / `--角色-分析師` | 根本原因分析、基於證據 | 複雜除錯、調查 |
| `--persona-security` / `--角色-安全專家` | 威脅建模、零信任、OWASP | 安全審計、漏洞評估 |
| `--persona-mentor` / `--角色-導師` | 教學、引導學習、清晰度 | 文檔、知識傳遞 |
| `--persona-refactorer` / `--角色-重構專家` | 程式碼品質、可維護性 | 程式碼清理、技術債務 |
| `--persona-performance` / `--角色-效能專家` | 優化、分析、效率 | 效能調校、瓶頸 |
| `--persona-qa` / `--角色-品保專家` | 測試、邊緣案例、驗證 | 品質保證、測試覆蓋率 |

---

## 完整命令參考

### 🛠️ 開發命令（3 個）

#### `/建構` (`/build`) - 通用專案建構器
使用現代技術棧模板建構專案、功能和元件。

**命令特定旗標**：
- `--init` - 使用技術棧設置初始化新專案
- `--feature` - 使用現有模式實現功能
- `--tdd` - 測試驅動開發工作流程
- `--react` - React 搭配 Vite、TypeScript、Router
- `--api` - Express.js API 搭配 TypeScript
- `--fullstack` - 完整的 React + Node.js + Docker
- `--mobile` - React Native 搭配 Expo
- `--cli` - Commander.js CLI 搭配測試

**範例**：
```bash
/建構 --init --react --magic --tdd         # 新的 React 應用搭配 AI 元件
/建構 --feature "驗證系統" --tdd           # 含測試的功能
/建構 --api --openapi --seq                # 含文檔的 API
/建構 --react --graph                      # 具記憶持久性的 React 應用
```

#### `/開發設置` (`/dev-setup`) - 開發環境
配置專業開發環境，包含 CI/CD 和監控。

**命令特定旗標**：
- `--install` - 安裝和配置相依套件
- `--ci` - CI/CD 管道配置
- `--monitor` - 監控和可觀察性設置
- `--docker` - 容器化設置
- `--testing` - 測試基礎設施
- `--team` - 團隊協作工具
- `--standards` - 程式碼品質標準

**範例**：
```bash
/開發設置 --install --ci --monitor         # 完整環境
/開發設置 --team --standards --docs        # 團隊設置
```

#### `/測試` (`/test`) - 完整測試框架
建立、執行和維護跨技術棧的測試策略。

**命令特定旗標**：
- `--e2e` - 端對端測試
- `--integration` - 整合測試
- `--unit` - 單元測試
- `--visual` - 視覺回歸測試
- `--mutation` - 突變測試
- `--performance` - 效能測試
- `--accessibility` - 無障礙測試
- `--parallel` - 平行測試執行

**範例**：
```bash
/測試 --coverage --e2e --playwright              # 完整測試套件
/測試 --mutation --strict                 # 測試品質驗證
```

### 🔍 分析與改進命令（5 個）

#### `/審查` (`/review`) - AI 驅動的程式碼審查
完整的程式碼審查和品質分析，提供基於證據的建議。

**命令特定旗標**：
- `--files` - 審查特定檔案或目錄
- `--commit` - 審查指定提交中的變更（HEAD、雜湊、範圍）
- `--pr` - 審查拉取請求變更（git diff main..branch）
- `--quality` - 專注於程式碼品質問題（DRY、SOLID、複雜度）
- `--evidence` - 包含所有建議的來源和文檔
- `--fix` - 為識別的問題建議具體修復
- `--summary` - 生成審查發現的執行摘要

**範例**：
```bash
/審查 --files src/auth.ts --角色-安全專家    # 以安全為重點的檔案審查
/審查 --commit HEAD --quality --evidence    # 含來源的品質審查
/審查 --pr 123 --all --interactive         # 完整的 PR 審查
/審查 --files src/ --角色-效能專家 --think  # 效能分析
```

#### `/分析` (`/analyze`) - 多維度分析
程式碼、架構、效能和安全性的完整分析。

**命令特定旗標**：
- `--code` - 程式碼品質分析
- `--architecture` - 系統設計評估
- `--profile` - 效能分析
- `--deps` - 相依性分析
- `--surface` - 快速概覽
- `--deep` - 完整分析
- `--forensic` - 詳細調查

**範例**：
```bash
/分析 --code --architecture --seq --graph  # 完整分析並存入記憶庫
   # 儲存：系統元件、關係、設計決策
   # 未來效益：查詢「我們的快取策略是什麼？」會返回儲存的洞察
/分析 --profile --deep --角色-效能專家      # 效能深入探討
/分析 --deps --brave --security            # 最新依賴安全資訊分析
```

#### `/故障排除` (`/troubleshoot`) - 專業除錯
系統化除錯和問題解決。

**命令特定旗標**：
- `--investigate` - 系統化問題分析
- `--five-whys` - 根本原因分析
- `--prod` - 生產環境除錯
- `--perf` - 效能調查
- `--fix` - 完整解決方案
- `--hotfix` - 緊急修復
- `--rollback` - 安全回滾

**範例**：
```bash
/故障排除 --prod --five-whys --seq        # 生產環境 RCA
/故障排除 --perf --fix --playwright              # 效能修復
/故障排除 --investigate --graph --seq           # 帶記憶追蹤的調查
/故障排除 --prod --brave --hotfix              # 最新生產問題修復
```

#### `/改善` (`/improve`) - 增強與優化
基於證據的改進，具有可衡量的成果。

**命令特定旗標**：
- `--quality` - 程式碼結構改進
- `--performance` - 效能優化
- `--accessibility` - 無障礙改進
- `--iterate` - 反覆改進
- `--threshold` - 品質目標百分比
- `--refactor` - 系統化重構
- `--modernize` - 技術更新

**範例**：
```bash
/改善 --quality --iterate --threshold 95%  # 品質改進
/改善 --performance --cache --playwright          # 效能提升
/改善 --refactor --graph --quality              # 帶偏好記憶的重構
/改善 --modernize --brave --frameworks          # 最新框架更新
```

#### `/解釋` (`/explain`) - 技術文檔
生成完整的解釋和文檔。

**命令特定旗標**：
- `--depth` - 複雜度層級（ELI5|初學者|中級|專家）
- `--visual` - 包含圖表
- `--examples` - 程式碼範例
- `--api` - API 文檔
- `--architecture` - 系統文檔
- `--tutorial` - 學習教程
- `--reference` - 參考文檔

**範例**：
```bash
/解釋 --depth 專家 --visual --seq         # 專家文檔
/解釋 --api --examples --c7               # 含範例的 API 文檔
/解釋 --brave "最新的 React 19 功能"       # 最新技術文檔
/解釋 --architecture --graph --seq        # 帶記憶的架構文檔
/解釋 --tutorial --brave --frameworks      # 最新教程內容
```

### ⚙️ 操作命令（6 個）

#### `/部署` (`/deploy`) - 應用程式部署
具有回滾功能的安全部署。

**命令特定旗標**：
- `--env` - 目標環境（dev|staging|prod）
- `--canary` - 金絲雀部署
- `--blue-green` - 藍綠部署
- `--rolling` - 滾動部署
- `--checkpoint` - 建立檢查點
- `--rollback` - 回滾到先前版本
- `--monitor` - 部署後監控

**範例**：
```bash
/部署 --env prod --canary --monitor       # 金絲雀生產部署
/部署 --rollback --env prod               # 緊急回滾
```

#### `/遷移` (`/migrate`) - 資料庫與程式碼遷移
具有回滾功能的安全遷移。

**命令特定旗標**：
- `--database` - 資料庫遷移
- `--code` - 程式碼遷移
- `--config` - 配置遷移
- `--dependencies` - 相依性更新
- `--backup` - 先建立備份
- `--rollback` - 回滾遷移
- `--validate` - 資料完整性檢查

**範例**：
```bash
/遷移 --database --backup --validate      # 安全的資料庫遷移
/遷移 --code --dry-run                    # 預覽程式碼變更
/遷移 --dependencies --brave --latest    # 最新依賴版本遷移
/遷移 --config --graph --preferences     # 帶使用者偏好的遷移
```

#### `/掃描` (`/scan`) - 安全與驗證
完整的安全審計和合規性。

**命令特定旗標**：
- `--owasp` - OWASP Top 10 合規性
- `--secrets` - 密鑰檢測
- `--compliance` - 法規合規性
- `--quality` - 程式碼品質驗證
- `--automated` - 持續監控
- `--fix` - 自動修復檢測到的問題
- `--report` - 生成詳細報告

**範例**：
```bash
/掃描 --security --owasp --fix            # 安全掃描與修復
/掃描 --compliance --report                # 合規性報告
/掃描 --security --brave --latest         # 最新安全漏洞掃描
/掃描 --quality --playwright --e2e        # 帶瀏覽器測試的品質掃描
```

#### `/估算` (`/estimate`) - 專案估算
準確的專案和任務估算。

**命令特定旗標**：
- `--detailed` - 詳細分解
- `--team` - 團隊能力考慮
- `--risk` - 風險評估
- `--buffer` - 包含緩衝時間
- `--sprint` - Sprint 計劃
- `--roadmap` - 長期路線圖
- `--dependencies` - 相依性分析

**範例**：
```bash
/估算 --detailed --risk --buffer          # 完整估算
/估算 --sprint --team                     # Sprint 計劃
/估算 --detailed --graph --historical     # 帶歷史數據的估算
/估算 --risk --brave --market-trends      # 帶最新趨勢的風險分析
```

#### `/清理` (`/cleanup`) - 程式碼與專案清理
移除技術債務和未使用的資源。

**命令特定旗標**：
- `--all` - 完整清理（程式碼 + 相依性 + 資產）
- `--code` - 程式碼清理（死代碼、未使用的導入）
- `--deps` - 相依性清理
- `--assets` - 資產優化
- `--cache` - 快取清理
- `--logs` - 日誌清理
- `--analyze` - 分析潛在清理

**範例**：
```bash
/清理 --all --analyze                     # 分析並清理
/清理 --code --deps --dry-run             # 預覽清理
/清理 --all --graph --preserve-prefs       # 保留偏好的清理
/清理 --deps --brave --security            # 帶最新安全資訊的清理
```

#### `/git` - Git 操作與工作流程
增強的 Git 操作與最佳實踐。

**命令特定旗標**：
- `--commit` - 智慧提交訊息生成
- `--sync` - 同步分支
- `--cleanup` - 清理分支
- `--checkpoint` - 建立檢查點
- `--flow` - Git flow 操作
- `--hooks` - 管理 Git hooks
- `--history` - 歷史分析

**範例**：
```bash
/git --commit --角色-導師                  # 生成提交訊息
/git --sync --cleanup                     # 同步並清理
/git --commit --graph --message-prefs      # 帶訊息偏好的提交
/git --sync --brave --remote-updates       # 帶最新遠端變更的同步
```

### 📋 任務與協調命令（4 個）

#### `/任務` (`/task`) - 任務管理系統
建立、追蹤和管理開發任務。

**子命令**：
- `:建立` (`:create`) - 建立新任務與分解
- `:狀態` (`:status`) - 查看任務狀態和進度
- `:恢復` (`:resume`) - 從檢查點恢復任務
- `:計劃` (`:plan`) - 計劃任務執行
- `:審查` (`:review`) - 審查已完成的任務

**範例**：
```bash
/任務:建立 "實現使用者驗證"                # 建立任務
/任務:狀態 --詳細                         # 詳細狀態
/任務:恢復 --from-checkpoint              # 恢復工作
```

#### `/載入` (`/load`) - 上下文載入
載入專案上下文和配置。

**命令特定旗標**：
- `--context` - 載入專案上下文
- `--history` - 載入會話歷史
- `--config` - 載入配置
- `--state` - 載入保存的狀態
- `--dependencies` - 載入相依性資訊
- `--partial` - 部分載入
- `--merge` - 合併上下文

**範例**：
```bash
/載入 --context --dependencies            # 載入專案資訊
/載入 --state --merge                     # 合併保存的狀態
```

#### `/索引` (`/index`) - 程式碼庫索引
建立和維護程式碼庫索引以便快速存取。

**命令特定旗標**：
- `--build` - 建構新索引
- `--update` - 更新現有索引
- `--search` - 搜尋索引
- `--stats` - 索引統計
- `--optimize` - 優化索引
- `--export` - 匯出索引
- `--query` - 查詢語言支援

**範例**：
```bash
/索引 --build --optimize                  # 建構優化索引
/索引 --search "驗證" --詳細              # 搜尋索引
```

#### `/生成` (`/spawn`) - 任務生成
生成子任務和平行工作流程。

**命令特定旗標**：
- `--task` - 生成任務
- `--workflow` - 生成工作流程
- `--parallel` - 平行執行
- `--sequential` - 順序執行
- `--template` - 使用模板
- `--monitor` - 監控生成的任務
- `--collect` - 收集結果

**範例**：
```bash
/生成 --task --parallel --monitor         # 平行任務
/生成 --workflow --template "CI/CD"       # 工作流程生成
```

### 📚 文檔與設計命令（2 個）

#### `/文檔` (`/document`) - 文檔生成
建立完整的專案文檔。

**命令特定旗標**：
- `--api` - API 文檔
- `--user` - 使用者文檔
- `--technical` - 技術文檔
- `--architecture` - 架構文檔
- `--readme` - README 生成
- `--changelog` - 變更日誌
- `--style` - 文檔風格指南

**範例**：
```bash
/文檔 --api --openapi                     # API 文檔
/文檔 --user --visual                     # 使用者指南
/文檔 --api --brave --latest-standards     # 帶最新標準的文檔
/文檔 --architecture --graph --patterns   # 帶模式記憶的架構文檔
```

#### `/設計` (`/design`) - 系統設計
建立系統設計和架構。

**命令特定旗標**：
- `--api` - API 設計
- `--database` - 資料庫設計
- `--system` - 系統架構
- `--ddd` - 領域驅動設計
- `--patterns` - 設計模式
- `--diagrams` - 生成圖表
- `--review` - 設計審查

**範例**：
```bash
/設計 --api --ddd --patterns              # API 設計與 DDD
/設計 --system --diagrams --c7            # 系統圖表
/設計 --system --graph --patterns          # 帶模式記憶的系統設計
/設計 --api --brave --best-practices       # 帶最新實踐的 API 設計
```

---

## 旗標組合與最佳實踐

### 進階旗標組合
```yaml
高級使用者模式：
  深度分析：/分析 --architecture --seq --think-hard
  UI 開發：/建構 --react --magic --playwright --watch
  生產部署：/掃描 --validate --seq → /部署 --env prod --think-hard
  緊急除錯：/故障排除 --prod --ultrathink --seq
  記憶增強：/建構 --react --graph → /測試 --graph  # 記住偏好設定
  即時搜尋：/解釋 --brave --c7 "最新框架"  # 最新資訊 + 官方文檔
  
研究與學習：
  程式庫研究：/解釋 --c7 --seq --depth 專家 "React hooks"
  架構：/設計 --ddd --seq --think-hard → /文檔 --api
  效能：/分析 --profile --seq → /改善 --iterate --threshold 95%
  
Token 優化：
  壓縮文檔：/文檔 --uc → /解釋 --uc --c7
  高效分析：/分析 --uc --no-mcp → /改善 --uc
  快速工作流程：/建構 --uc → /測試 --uc → /部署 --uc
  
內省與學習：
  透明工作流程：/分析 --code --introspect
  學習開發：/建構 --react --introspect --magic
  除錯理解：/故障排除 --introspect --seq
  流程可見性：/設計 --api --introspect --think-hard
```

### 安全與最佳實踐
```yaml
部署前安全：
  完整關卡：/測試 --coverage → /掃描 --security → /掃描 --validate → /部署
  分階段：/部署 --env staging → /測試 --e2e → /部署 --env prod --plan
  回滾準備：/git --checkpoint → /部署 → (如果有問題) /部署 --rollback
  
開發安全：
  先清理：/清理 --code → /建構 → /測試 → /git --commit
  品質關卡：/分析 → /改善 --quality → /測試 → /git --commit
  安全：/掃描 --security → 修復問題 → /掃描 --validate
  
複雜操作的計劃：
  架構：/設計 --api --ddd --plan --think-hard
  遷移：/遷移 --dry-run → /遷移 --plan → 驗證
  清理：/清理 --all --dry-run → 審查 → /清理 --all
```

## 共享資源（12 個核心檔案）

**模式檔案**：
- `architecture-patterns.yml`：DDD/微服務/事件模式
- `command-architecture-patterns.yml`：命令設計與架構模式
- `compression-performance-patterns.yml`：Token 優化與效能監控
- `docs-patterns.yml`：文檔系統與格式化
- `execution-patterns.yml`：統一工作流程、MCP 協調與生命週期
- `feature-template.yml`：功能開發的任務模板
- `quality-patterns.yml`：驗證、錯誤處理與品質控制
- `research-patterns.yml`：研究流程與證據驗證
- `security-patterns.yml`：安全模式與威脅控制
- `task-management-patterns.yml`：任務與待辦事項管理模式
- `recovery-state-patterns.yml`：恢復與狀態管理模式

**核心系統**：
- `flag-inheritance.yml`：含繼承的整合旗標系統
- `reference-patterns.yml`：含捷徑的優化參考系統
- `universal-constants.yml`：通用常數、符號與共享值

**工具**：
- `validate-references.sh`：參考驗證與完整性檢查

---