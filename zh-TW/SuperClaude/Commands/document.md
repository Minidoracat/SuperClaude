---
allowed-tools: [Read, Grep, Glob, Write, Edit]
description: "為特定元件或功能建立專注的文件"
---

# /sc:document - 專注文件

## 目的
為特定元件、函式或功能產生精確、專注的文件。

## 使用方式
```
/sc:document [目標] [--type inline|external|api|guide] [--style brief|detailed]
```

## 參數
- `目標` - 要記錄的特定檔案、函式或元件
- `--type` - 文件類型（inline 內嵌、external 外部、api、guide 指南）
- `--style` - 文件風格（brief 簡潔、detailed 詳細）
- `--template` - 使用特定的文件範本

## 執行步驟
1. 分析目標元件並擷取關鍵資訊
2. 識別文件需求和目標對象
3. 根據類型和風格產生適當的文件
4. 套用一致的格式和結構
5. 整合至現有的文件生態系統

## Claude Code 整合
- 使用 Read 進行深入的元件分析
- 運用 Edit 更新內嵌文件
- 應用 Write 建立外部文件
- 維護文件標準和慣例