---
allowed-tools: [Read, Glob, Grep, TodoWrite, Task, mcp__sequential-thinking__sequentialthinking]
description: "執行複雜任務，具備智慧工作流程管理和跨會話持久性"
wave-enabled: true
complexity-threshold: 0.7
performance-profile: complex
personas: [architect, analyzer, project-manager]
mcp-servers: [sequential, context7]
---

# /sc:task - 增強任務管理

## 目的
執行複雜任務，具備智慧工作流程管理、跨會話持久性、階層式任務組織和進階協調能力。

## 使用方式
```
/sc:task [動作] [目標] [--strategy systematic|agile|enterprise] [--persist] [--hierarchy] [--delegate]
```

## 動作
- `create` - 建立新的專案層級任務階層
- `execute` - 使用智慧協調執行任務
- `status` - 檢視跨會話的任務狀態
- `analytics` - 任務效能和分析儀表板
- `optimize` - 最佳化任務執行策略
- `delegate` - 跨多個代理委派任務
- `validate` - 使用證據驗證任務完成

## 參數
- `目標` - 任務描述、專案範圍或現有任務 ID
- `--strategy` - 執行策略（systematic 系統化、agile 敏捷、enterprise 企業）
- `--persist` - 啟用跨會話任務持久性
- `--hierarchy` - 建立階層式任務分解
- `--delegate` - 啟用多代理任務委派
- `--wave-mode` - 啟用基於波的執行
- `--validate` - 強制執行品質關卡和驗證
- `--mcp-routing` - 啟用智慧 MCP 伺服器路由

## 執行模式

### 系統化策略
1. **探索階段**：全面的專案分析和範圍定義
2. **規劃階段**：具有相依性映射的階層式任務分解
3. **執行階段**：具有驗證關卡的循序執行
4. **驗證階段**：證據收集和品質保證
5. **最佳化階段**：效能分析和改進建議

### 敏捷策略
1. **衝刺規劃**：基於優先級的任務組織
2. **迭代執行**：具有持續回饋的短週期
3. **適應性規劃**：基於結果的動態任務調整
4. **持續整合**：即時驗證和測試
5. **回顧分析**：學習和流程改進

### 企業策略
1. **利害關係人分析**：多領域影響評估
2. **資源分配**：跨任務的最佳資源分配
3. **風險管理**：全面的風險評估和緩解
4. **合規驗證**：法規和政策合規檢查
5. **治理報告**：詳細的進度和合規報告

## 進階功能

### 任務階層管理
- **史詩層級**：大規模專案目標（數週至數月）
- **故事層級**：功能特定實作（數天至數週）
- **任務層級**：特定可執行項目（數小時至數天）
- **子任務層級**：細粒度實作步驟（數分鐘至數小時）

### 智慧任務協調
- **相依性解析**：自動相依性偵測和排序
- **並行執行**：獨立任務並行化
- **資源最佳化**：智慧資源分配和排程
- **脈絡共享**：跨任務脈絡和知識共享

### 跨會話持久性
- **任務狀態管理**：跨會話的持久任務狀態
- **脈絡連續性**：保留的脈絡和進度追蹤
- **歷史分析**：任務執行歷史和學習
- **復原機制**：從中斷自動復原

### 品質關卡和驗證
- **證據收集**：執行期間的系統化證據收集
- **驗證標準**：可自訂的完成標準
- **品質指標**：全面的品質評估
- **合規檢查**：自動化合規驗證

## 整合點

### Wave 系統整合
- **Wave 協調**：多波任務執行策略
- **脈絡累積**：跨波的漸進式脈絡建構
- **效能監控**：即時效能追蹤和最佳化
- **錯誤復原**：優雅的錯誤處理和復原機制

### MCP 伺服器協調
- **Context7**：框架模式和程式庫文件
- **Sequential**：複雜分析和多步驟推理
- **Magic**：UI 元件產生和設計系統
- **Playwright**：端對端測試和效能驗證

### 角色整合
- **Architect**：系統設計和架構決策
- **Analyzer**：程式碼分析和品質評估
- **Project Manager**：資源分配和進度追蹤
- **領域專家**：特定任務類型的專門專業知識

## 效能最佳化

### 執行效率
- **批次操作**：相關任務的分組執行
- **並行處理**：獨立任務並行化
- **脈絡快取**：可重複使用的脈絡和分析結果
- **資源池化**：共享資源利用

### 智慧功能
- **預測性規劃**：AI 驅動的任務估算和規劃
- **適應性執行**：基於進度的動態策略調整
- **學習系統**：從執行模式持續改進
- **最佳化建議**：資料驅動的改進建議

## 使用範例

### 建立專案層級任務階層
```
/sc:task create "實作使用者認證系統" --hierarchy --persist --strategy systematic
```

### 使用多代理委派執行
```
/sc:task execute AUTH-001 --delegate --wave-mode --validate
```

### 分析和最佳化
```
/sc:task analytics --project AUTH --optimization-recommendations
```

### 跨會話任務管理
```
/sc:task status --all-sessions --detailed-breakdown
```

## Claude Code 整合
- **TodoWrite 整合**：無縫的會話層級任務協調
- **Wave 系統**：進階的多階段執行協調
- **Hook 系統**：即時任務監控和最佳化
- **MCP 協調**：智慧伺服器路由和資源利用
- **效能監控**：次 100 毫秒執行目標與全面指標

## 成功標準
- **任務完成率**：>95% 成功任務完成
- **效能目標**：<100ms hook 執行，<5s 任務建立
- **品質指標**：>90% 驗證成功率
- **跨會話連續性**：100% 任務狀態保留
- **智慧有效性**：>80% 準確的預測性規劃