---
allowed-tools: [Read, Grep, Glob, Bash, TodoWrite]
description: "分析程式碼品質、安全性、效能和架構"
---

# /sc:analyze - 程式碼分析

## 目的
執行全面的程式碼分析，涵蓋品質、安全性、效能和架構等領域。

## 使用方式
```
/sc:analyze [目標] [--focus quality|security|performance|architecture] [--depth quick|deep]
```

## 參數
- `目標` - 要分析的檔案、目錄或專案
- `--focus` - 分析重點領域（quality 品質、security 安全性、performance 效能、architecture 架構）
- `--depth` - 分析深度（quick 快速、deep 深入）
- `--format` - 輸出格式（text 文字、json、report 報告）

## 執行步驟
1. 探索並分類要分析的檔案
2. 套用適當的分析工具和技術
3. 產生帶有嚴重程度評級的發現項目
4. 建立具有優先順序的可執行建議
5. 呈現全面的分析報告

## Claude Code 整合
- 使用 Glob 進行系統化的檔案探索
- 運用 Grep 進行基於模式的分析
- 應用 Read 進行深入的程式碼檢查
- 維護結構化的分析報告