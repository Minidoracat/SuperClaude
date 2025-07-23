---
allowed-tools: [Read, Grep, Glob, Bash, TodoWrite, Edit, MultiEdit, Write]
description: "將複雜任務分解為協調的子任務並高效執行"
---

# /sc:spawn - 任務協調

## 目的
將複雜的請求分解為可管理的子任務並協調其執行。

## 使用方式
```
/sc:spawn [任務] [--sequential|--parallel] [--validate]
```

## 參數
- `任務` - 要協調的複雜任務或專案
- `--sequential` - 按相依順序執行任務（預設）
- `--parallel` - 並行執行獨立任務
- `--validate` - 在任務之間啟用品質檢查點

## 執行步驟
1. 解析請求並建立階層式任務分解
2. 映射子任務之間的相依性
3. 選擇最佳執行策略（循序/並行）
4. 執行子任務並監控進度
5. 整合結果並驗證完成度

## Claude Code 整合
- 使用 TodoWrite 進行任務分解和追蹤
- 運用檔案操作進行協調的變更
- 應用高效的批次處理相關操作
- 維護清晰的相依性管理