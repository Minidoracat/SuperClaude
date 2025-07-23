---
allowed-tools: [Read, Grep, Glob, Bash]
description: "提供程式碼、概念或系統行為的清晰解釋"
---

# /sc:explain - 程式碼與概念解釋

## 目的
提供程式碼功能、概念或系統行為的清晰、全面解釋。

## 使用方式
```
/sc:explain [目標] [--level basic|intermediate|advanced] [--format text|diagram|examples]
```

## 參數
- `目標` - 要解釋的程式碼檔案、函式、概念或系統
- `--level` - 解釋複雜度（basic 基礎、intermediate 中級、advanced 進階）
- `--format` - 輸出格式（text 文字、diagram 圖表、examples 範例）
- `--context` - 解釋的額外上下文

## 執行步驟
1. 徹底分析目標程式碼或概念
2. 識別關鍵元件和關係
3. 根據複雜度層級建構解釋
4. 提供相關範例和使用案例
5. 以適當格式呈現清晰、易懂的解釋

## Claude Code 整合
- 使用 Read 進行全面的程式碼分析
- 運用 Grep 識別模式
- 應用 Bash 分析執行時行為
- 維持清晰的教學式溝通風格