**用途**: 專業開發環境設定

---

@include shared/universal-constants.yml#Universal_Legend

## 命令執行
執行：立即。--plan→先顯示計畫
圖例：根據命令中使用的符號生成
用途："[動作][主題] 在 $ARGUMENTS"

為 $ARGUMENTS 配置完整的開發環境和 CI/CD 管道。

@include shared/flag-inheritance.yml#Universal_Always

範例：
- `/dev-setup --type node --ci github --tools` - 使用 GitHub Actions 的 Node.js 專案
- `/dev-setup --type python --tools --think` - 具有完整工具的 Python 專案
- `/dev-setup --type monorepo --ci gitlab --think-hard` - 使用 GitLab CI 的全端 monorepo
- `/dev-setup --type react --tools --ci github` - 具有品質工具的 React 專案

## 設定類型

--type 旗標：
- node：Node.js/TypeScript 專案設定
- python：Python 虛擬環境和工具
- react：React + Vite/Next.js 配置
- fullstack：完整的全端環境
- monorepo：多套件 monorepo 設定

--ci 旗標：
- github：GitHub Actions 工作流程
- gitlab：GitLab CI/CD 管道
- jenkins：Jenkins 管道配置
- circleci：CircleCI 配置
- custom：自訂 CI/CD 解決方案

--tools 旗標：
- 包含開發工具：linter、formatter、pre-commit hooks
- 配置 VS Code 設定和擴充功能
- 設定除錯配置
- 安裝推薦的工具

## 設定元件

環境配置：
- 套件管理器設定（npm/yarn/pnpm）
- 版本管理（.nvmrc、.python-version）
- 環境變數和 .env 結構
- 如需要的 Docker 配置

程式碼品質：
- ESLint/Prettier 配置
- Pre-commit hooks（husky、lint-staged）
- 測試框架設定（Jest、Pytest 等）
- 程式碼覆蓋率配置

CI/CD 管道：
- 建置和測試工作流程
- 部署配置
- 安全掃描（SAST/DAST）
- 相依性漏洞檢查
- 發布自動化

開發工具：
- VS Code 工作區設定
- 除錯配置
- 任務執行器和腳本
- 文件生成

## 最佳實踐

安全性：
- 永不提交密碼或憑證
- 使用環境變數儲存敏感資料
- 在 CI 中配置安全掃描
- 實作相依性漏洞檢查

效能：
- 在 CI 中快取相依性
- 平行化測試執行
- 最佳化建置流程
- 使用適當的資源限制

可維護性：
- 團隊內一致的工具
- 清晰的文件
- 自動化品質檢查
- 可重現的環境

## 範例

```bash
# 使用 GitHub Actions 的 Node.js 專案
/dev-setup --type node --ci github --tools

# 具有完整工具的 Python 專案
/dev-setup --type python --tools --think

# 使用 GitLab CI 的全端 monorepo
/dev-setup --type monorepo --ci gitlab --think-hard

# 具有所有品質工具的 React 專案
/dev-setup --type react --tools --ci github
```

## 交付成果

- 完整的環境配置檔案
- CI/CD 管道定義
- 開發工具配置
- 設定文件和 README 更新
- 常見開發任務的腳本

@include shared/universal-constants.yml#Standard_Messages_Templates