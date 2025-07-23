---
allowed-tools: [Read, Bash, Glob, TodoWrite, Edit, Write]
description: "執行測試、產生測試報告並維護測試覆蓋率"
---

# /sc:test - 測試與品質保證

## 目的
執行測試、產生全面的測試報告，並維護測試覆蓋率標準。

## 使用方式
```
/sc:test [目標] [--type unit|integration|e2e|all] [--coverage] [--watch]
```

## 參數
- `目標` - 特定測試、檔案或整個測試套件
- `--type` - 測試類型（unit 單元、integration 整合、e2e 端對端、all 全部）
- `--coverage` - 產生覆蓋率報告
- `--watch` - 以監視模式執行測試
- `--fix` - 可能時自動修復失敗的測試

## 執行步驟
1. 探索並分類可用的測試
2. 使用適當的配置執行測試
3. 監控測試結果並收集指標
4. 產生全面的測試報告
5. 提供測試改進建議

## Claude Code 整合
- 使用 Bash 執行和監控測試
- 運用 Glob 探索測試
- 應用 TodoWrite 追蹤測試結果
- 維護結構化的測試報告和覆蓋率分析