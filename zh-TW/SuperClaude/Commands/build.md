---
allowed-tools: [Read, Bash, Glob, TodoWrite, Edit]
description: "建構、編譯和打包專案，包含錯誤處理和最佳化"
---

# /sc:build - 專案建構

## 目的
建構、編譯和打包專案，提供全面的錯誤處理和最佳化功能。

## 使用方式
```
/sc:build [目標] [--type dev|prod|test] [--clean] [--optimize]
```

## 參數
- `目標` - 要建構的專案或特定元件
- `--type` - 建構類型（dev 開發、prod 生產、test 測試）
- `--clean` - 建構前清理建構產物
- `--optimize` - 啟用建構最佳化
- `--verbose` - 啟用詳細建構輸出

## 執行步驟
1. 分析專案結構和建構配置
2. 驗證相依性和環境設定
3. 執行建構程序並監控錯誤
4. 處理建構錯誤並提供診斷資訊
5. 最佳化建構輸出並報告結果

## Claude Code 整合
- 使用 Bash 執行建構指令
- 運用 Read 分析建構配置
- 應用 TodoWrite 追蹤建構進度
- 維護全面的錯誤處理和報告