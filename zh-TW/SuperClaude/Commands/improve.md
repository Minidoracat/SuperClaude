---
allowed-tools: [Read, Grep, Glob, Edit, MultiEdit, TodoWrite]
description: "對程式碼品質、效能和可維護性進行系統化改善"
---

# /sc:improve - 程式碼改善

## 目的
對程式碼品質、效能、可維護性和最佳實踐進行系統化改善。

## 使用方式
```
/sc:improve [目標] [--type quality|performance|maintainability|style] [--safe]
```

## 參數
- `目標` - 要改善的檔案、目錄或專案
- `--type` - 改善類型（quality 品質、performance 效能、maintainability 可維護性、style 風格）
- `--safe` - 僅套用安全、低風險的改善
- `--preview` - 顯示改善但不套用

## 執行步驟
1. 分析程式碼以找出改善機會
2. 識別特定的改善模式和技術
3. 建立包含風險評估的改善計畫
4. 套用改善並進行適當驗證
5. 驗證改善並報告變更

## Claude Code 整合
- 使用 Read 進行全面的程式碼分析
- 運用 MultiEdit 進行批次改善
- 應用 TodoWrite 追蹤改善進度
- 維護安全性和驗證機制