---
allowed-tools: [Read, Grep, Glob, Bash]
description: "為任務、功能或專案提供開發估算"
---

# /sc:estimate - 開發估算

## 目的
根據複雜度分析，為任務、功能或專案產生準確的開發估算。

## 使用方式
```
/sc:estimate [目標] [--type time|effort|complexity|cost] [--unit hours|days|weeks]
```

## 參數
- `目標` - 要估算的任務、功能或專案
- `--type` - 估算類型（time 時間、effort 工作量、complexity 複雜度、cost 成本）
- `--unit` - 時間單位（hours 小時、days 天、weeks 週）
- `--breakdown` - 提供詳細的估算細分

## 執行步驟
1. 分析目標的範圍和需求
2. 識別複雜度因素和相依性
3. 套用估算方法和歷史資料
4. 產生包含信心區間的估算
5. 呈現包含風險因素的詳細細分

## Claude Code 整合
- 使用 Read 進行需求分析
- 運用 Glob 評估程式碼庫複雜度
- 應用 Grep 進行基於模式的估算
- 維護結構化的估算文件