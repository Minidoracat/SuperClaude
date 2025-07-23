---
allowed-tools: [Read, Grep, Glob, Bash, Write]
description: "載入並分析專案脈絡、配置和相依性"
---

# /sc:load - 專案脈絡載入

## 目的
載入並分析專案脈絡、配置、相依性和環境設定。

## 使用方式
```
/sc:load [目標] [--type project|config|deps|env] [--cache]
```

## 參數
- `目標` - 要載入的專案目錄或特定配置
- `--type` - 載入類型（project 專案、config 配置、deps 相依性、env 環境）
- `--cache` - 快取載入的脈絡以加快後續存取
- `--refresh` - 強制重新整理快取的脈絡

## 執行步驟
1. 探索並分析專案結構和配置檔案
2. 載入相依性、環境變數和設定
3. 解析並驗證配置一致性
4. 建立全面的專案脈絡地圖
5. 快取脈絡以提高未來存取效率

## Claude Code 整合
- 使用 Glob 進行全面的專案探索
- 運用 Read 分析配置
- 應用 Bash 驗證環境
- 維護高效的脈絡快取機制