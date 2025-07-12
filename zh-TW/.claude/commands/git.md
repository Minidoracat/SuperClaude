**用途**: Git 工作流程與檢查點管理

---

@include shared/universal-constants.yml#Universal_Legend

## 命令執行
執行：立即。--plan→先顯示計畫
圖例：根據命令中使用的符號生成
用途："[動作][主題] 在 $ARGUMENTS"

為 $ARGUMENTS 中指定的儲存庫管理完整的 git 工作流程。

@include shared/flag-inheritance.yml#Universal_Always

範例：
- `/git --commit "新增使用者設定檔 API 端點"` - 標準提交與訊息
- `/git --pr --reviewers alice,bob --labels api,feature` - 建立帶有審查者的 PR
- `/git --flow feature "付款整合" --think` - 完整功能工作流程
- `/git --pre-commit` - 設定 pre-commit 框架和基本 hooks
- `/git --commit "修正驗證邏輯" --pre-commit` - 提交並執行 pre-commit 驗證
- `/git --pre-commit --security` - 設定包含安全性 hooks

Git 操作：

**--commit:** 暫存適當的檔案 | 生成有意義的提交訊息 | 包含共同作者歸屬 | 遵循慣例式提交

**--pr:** 建立 pull request | 生成 PR 描述 | 設定審查者和標籤 | 連結相關議題

**--flow:** Git 工作流程模式
- feature：功能分支工作流程 | hotfix：緊急修復工作流程
- release：發布分支工作流程 | gitflow：完整 GitFlow 模型

**--pre-commit:** 設定和管理 pre-commit hooks | 自動安裝框架 | 配置品質檢查 | 在提交前執行 hooks

@include shared/execution-patterns.yml#Git_Integration_Patterns

@include shared/pre-commit-patterns.yml#Pre_Commit_Setup

@include shared/docs-patterns.yml#Standard_Notifications

@include shared/universal-constants.yml#Standard_Messages_Templates