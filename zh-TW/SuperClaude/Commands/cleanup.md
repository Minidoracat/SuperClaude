---
allowed-tools: [Read, Grep, Glob, Bash, Edit, MultiEdit]
description: "清理程式碼、移除無用程式碼並最佳化專案結構"
---

# /sc:cleanup - 程式碼與專案清理

## 目的
系統化地清理程式碼、移除無用程式碼、最佳化匯入並改善專案結構。

## 使用方式
```
/sc:cleanup [目標] [--type code|imports|files|all] [--safe|--aggressive]
```

## 參數
- `目標` - 要清理的檔案、目錄或整個專案
- `--type` - 清理類型（code 程式碼、imports 匯入、files 檔案、all 全部）
- `--safe` - 保守清理（預設）
- `--aggressive` - 更徹底的清理但風險較高
- `--dry-run` - 預覽變更而不實際套用

## 執行步驟
1. 分析目標以找出清理機會
2. 識別無用程式碼、未使用的匯入和冗餘檔案
3. 建立包含風險評估的清理計畫
4. 使用適當的安全措施執行清理操作
5. 驗證變更並報告清理結果

## Claude Code 整合
- 使用 Glob 進行系統化的檔案探索
- 運用 Grep 偵測無用程式碼
- 應用 MultiEdit 進行批次清理操作
- 維護備份和復原功能