**用途**: SuperClaude 命令參考

@include shared/universal-constants.yml#Universal_Legend

## 超壓縮參考
命令：`/cmd --flags` | 總共 19 個 | 通用旗標可用

@include shared/flag-inheritance.yml#Universal_Always

## 命令類別
**分析**: `/analyze` `/scan` `/explain` `/review`
**建置**: `/build` `/deploy` `/migrate` 
**管理**: `/task` `/load` `/cleanup`
**開發**: `/test` `/troubleshoot` `/improve`
**工具**: `/design` `/document` `/estimate` `/dev-setup` `/git` `/spawn`

## 命令與主要旗標
**開發**: `/build` --init|feature|react | `/dev-setup` --install|ci | `/test` --coverage|e2e
**分析**: `/analyze` --code|arch | `/review` --files|commit|pr | `/troubleshoot` --fix|prod | `/improve` --perf|quality | `/explain` --depth
**運維**: `/deploy` --env|rollback | `/migrate` --dry-run | `/scan` --security | `/estimate` --detailed | `/cleanup` --all | `/git` --commit|sync
**設計**: `/design` --api|ddd | `/document` --api|user | `/spawn` --task
**管理**: `/task` :create|:status|:resume | `/load` --context

## 工作流程模式
**設定**: `/load` → `/dev-setup --install` → `/build --init` → `/test`
**功能**: `/analyze` → `/design --api` → `/build --tdd` → `/test --e2e` → `/deploy`
**除錯**: `/troubleshoot --fix` → `/test` → `/git --commit`
**品質**: `/review --quality --evidence` → `/improve --quality` → `/scan --validate`
**安全**: `/scan --security --owasp` → `/improve` → `/scan --validate`

### 進階旗標組合
```yaml
進階使用者模式:
  深度分析: /analyze --architecture --seq --think-hard
  UI 開發: /build --react --magic --pup --watch
  生產部署: /scan --validate --seq → /deploy --env prod --think-hard
  緊急除錯: /troubleshoot --prod --ultrathink --seq
  
研究與學習:
  程式庫研究: /explain --c7 --seq --depth expert "React hooks"
  架構: /design --ddd --seq --think-hard → /document --api
  效能: /analyze --profile --seq → /improve --iterate --threshold 95%
  
權杖最佳化:
  壓縮文件: /document --uc → /explain --uc --c7
  高效分析: /analyze --uc --no-mcp → /improve --uc
  快速工作流程: /build --uc → /test --uc → /deploy --uc
  
內省與學習:
  透明工作流程: /analyze --code --introspect
  學習開發: /build --react --introspect --magic
  除錯理解: /troubleshoot --introspect --seq
  流程可見性: /design --api --introspect --think-hard
```

### 安全性與最佳實踐
```yaml
部署前安全性:
  完整閘門: /test --coverage → /scan --security → /scan --validate → /deploy
  分階段: /deploy --env staging → /test --e2e → /deploy --env prod --plan
  回滾就緒: /git --checkpoint → /deploy → (如有問題) /deploy --rollback
  
開發安全性:
  先清理: /cleanup --code → /build → /test → /git --commit
  品質閘門: /analyze → /improve --quality → /test → /git --commit
  安全: /scan --security → 修正問題 → /scan --validate
  
複雜操作規劃:
  架構: /design --api --ddd --plan --think-hard
  遷移: /migrate --dry-run → /migrate --plan → 驗證
  清理: /cleanup --all --dry-run → 檢閱 → /cleanup --all
```

## 共享資源（12 個核心檔案）

**模式檔案:**
- `architecture-patterns.yml`: DDD/微服務/事件模式
- `command-architecture-patterns.yml`: 命令設計和架構模式
- `compression-performance-patterns.yml`: 權杖最佳化和效能監控
- `docs-patterns.yml`: 文件系統和格式化
- `execution-patterns.yml`: 統一工作流程、MCP 協調和生命週期
- `feature-template.yml`: 功能開發的任務範本
- `quality-patterns.yml`: 驗證、錯誤處理和品質控制
- `research-patterns.yml`: 研究流程和證據驗證
- `security-patterns.yml`: 安全模式和威脅控制
- `task-management-patterns.yml`: 任務和待辦事項管理模式
- `recovery-state-patterns.yml`: 恢復和狀態管理模式

**核心系統:**
- `flag-inheritance.yml`: 具有繼承的統一旗標系統
- `reference-patterns.yml`: 具有捷徑的最佳化參考系統
- `universal-constants.yml`: 通用常數、符號和共享值

**工具:**
- `validate-references.sh`: 參考驗證和完整性檢查

---