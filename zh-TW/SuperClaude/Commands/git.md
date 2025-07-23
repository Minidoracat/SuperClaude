---
allowed-tools: [Bash, Read, Glob, TodoWrite, Edit]
description: "Git 操作，具備智慧提交訊息和分支管理"
---

# /sc:git - Git 操作

## 目的
執行 Git 操作，具備智慧提交訊息、分支管理和工作流程最佳化。

## 使用方式
```
/sc:git [操作] [參數] [--smart-commit] [--branch-strategy]
```

## 參數
- `操作` - Git 操作（add、commit、push、pull、merge、branch、status）
- `參數` - 操作特定的參數
- `--smart-commit` - 產生智慧提交訊息
- `--branch-strategy` - 套用分支命名慣例
- `--interactive` - 複雜操作的互動模式

## 執行步驟
1. 分析當前 Git 狀態和儲存庫脈絡
2. 執行要求的 Git 操作並進行驗證
3. 套用智慧提交訊息產生
4. 處理合併衝突和分支管理
5. 提供清晰的回饋和後續步驟

## Claude Code 整合
- 使用 Bash 執行 Git 指令
- 運用 Read 分析儲存庫
- 應用 TodoWrite 追蹤操作
- 維護 Git 最佳實踐和慣例