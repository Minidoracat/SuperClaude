---
allowed-tools: [Read, Grep, Glob, Write, Edit, TodoWrite]
description: "設計系統架構、API 和元件介面"
---

# /sc:design - 系統與元件設計

## 目的
設計系統架構、API、元件介面和技術規格。

## 使用方式
```
/sc:design [目標] [--type architecture|api|component|database] [--format diagram|spec|code]
```

## 參數
- `目標` - 要設計的系統、元件或功能
- `--type` - 設計類型（architecture 架構、api、component 元件、database 資料庫）
- `--format` - 輸出格式（diagram 圖表、spec 規格、code 程式碼）
- `--iterative` - 啟用迭代設計精進

## 執行步驟
1. 分析需求和設計限制
2. 建立初始設計概念和替代方案
3. 開發詳細的設計規格
4. 根據需求和最佳實踐驗證設計
5. 產生設計文件和實作指南

## Claude Code 整合
- 使用 Read 進行需求分析
- 運用 Write 撰寫設計文件
- 應用 TodoWrite 追蹤設計任務
- 維持架構模式的一致性