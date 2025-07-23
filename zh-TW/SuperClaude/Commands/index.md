---
allowed-tools: [Read, Grep, Glob, Bash, Write]
description: "產生全面的專案文件和知識庫"
---

# /sc:index - 專案文件

## 目的
建立和維護全面的專案文件、索引和知識庫。

## 使用方式
```
/sc:index [目標] [--type docs|api|structure|readme] [--format md|json|yaml]
```

## 參數
- `目標` - 要記錄的專案目錄或特定元件
- `--type` - 文件類型（docs 文件、api、structure 結構、readme）
- `--format` - 輸出格式（md、json、yaml）
- `--update` - 更新現有文件

## 執行步驟
1. 分析專案結構並識別關鍵元件
2. 從程式碼註解和 README 檔案擷取文件
3. 根據類型產生全面的文件
4. 建立導覽結構和交叉參考
5. 輸出具有適當組織的格式化文件

## Claude Code 整合
- 使用 Glob 進行系統化的檔案探索
- 運用 Grep 擷取文件模式
- 應用 Write 建立結構化文件
- 維持專案慣例的一致性