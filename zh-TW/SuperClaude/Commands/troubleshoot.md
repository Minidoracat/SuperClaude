---
allowed-tools: [Read, Grep, Glob, Bash, TodoWrite]
description: "診斷並解決程式碼、建構或系統行為中的問題"
---

# /sc:troubleshoot - 問題診斷與解決

## 目的
系統化地診斷並解決程式碼、建構、部署或系統行為中的問題。

## 使用方式
```
/sc:troubleshoot [問題] [--type bug|build|performance|deployment] [--trace]
```

## 參數
- `問題` - 問題描述或錯誤訊息
- `--type` - 問題類別（bug 錯誤、build 建構、performance 效能、deployment 部署）
- `--trace` - 啟用詳細追蹤和記錄
- `--fix` - 在安全的情況下自動套用修復

## 執行步驟
1. 分析問題描述並收集初始脈絡
2. 識別潛在的根本原因和調查路徑
3. 執行系統化的除錯和診斷
4. 提出並驗證解決方案
5. 套用修復並驗證解決成效

## Claude Code 整合
- 使用 Read 分析錯誤記錄
- 運用 Bash 進行執行時診斷
- 應用 Grep 進行基於模式的問題偵測
- 維護結構化的疑難排解文件