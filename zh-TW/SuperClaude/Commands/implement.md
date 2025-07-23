---
allowed-tools: [Read, Write, Edit, MultiEdit, Bash, Glob, TodoWrite, Task]
description: "功能和程式碼實作，具備智慧角色啟用和 MCP 整合"
---

# /sc:implement - 功能實作

## 目的
實作功能、元件和程式碼功能，具備智慧專家啟用和全面的開發支援。

## 使用方式
```
/sc:implement [功能描述] [--type component|api|service|feature] [--framework react|vue|express|etc] [--safe]
```

## 參數
- `功能描述` - 要實作的功能描述
- `--type` - 實作類型（component 元件、api、service 服務、feature 功能、module 模組）
- `--framework` - 目標框架或技術堆疊
- `--safe` - 使用保守的實作方法
- `--iterative` - 啟用包含驗證步驟的迭代開發
- `--with-tests` - 包含測試實作
- `--documentation` - 在實作時一併產生文件

## 執行步驟
1. 分析實作需求並偵測技術脈絡
2. 自動啟用相關角色（前端、後端、安全性等）
3. 協調 MCP 伺服器（Magic 用於 UI、Context7 用於模式、Sequential 用於複雜邏輯）
4. 使用最佳實踐產生實作程式碼
5. 套用安全性和品質驗證
6. 提供測試建議和後續步驟

## Claude Code 整合
- 使用 Write/Edit/MultiEdit 進行程式碼產生和修改
- 運用 Read 和 Glob 分析程式碼庫和理解脈絡
- 應用 TodoWrite 追蹤實作進度
- 整合 Task 工具處理複雜的多步驟實作
- 協調 MCP 伺服器以提供專門功能
- 根據實作類型自動啟用適當的角色

## 自動啟用模式
- **Frontend 前端**：UI 元件、React/Vue/Angular 開發
- **Backend 後端**：API、服務、資料庫整合
- **Security 安全性**：身份驗證、授權、資料保護
- **Architecture 架構**：系統設計、模組結構
- **Performance 效能**：最佳化、可擴展性考量

## 範例
```
/sc:implement 使用者認證系統 --type feature --with-tests
/sc:implement 儀表板元件 --type component --framework react
/sc:implement 使用者管理 REST API --type api --safe
/sc:implement 付款處理服務 --type service --iterative
```