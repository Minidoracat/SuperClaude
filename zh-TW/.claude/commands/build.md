**用途**：具有技術棧模板的通用專案建構器

---

@include shared/universal-constants.yml#Universal_Legend

## 命令執行
執行：立即。--plan→先顯示計劃
圖例：基於命令中使用的符號生成
用途："[動作][主題]在 $ARGUMENTS"

基於 $ARGUMENTS 中的需求建構專案/功能。

@include shared/flag-inheritance.yml#Universal_Always

範例：
- `/建構 --react --magic` - React 應用程式含 UI 生成
- `/建構 --api --c7` - API 含文檔
- `/建構 --react --magic --playwright` - 建構並測試 UI

建構前：移除工件（dist/、build/、.next/）| 清理臨時檔案與快取 | 驗證相依性 | 移除除錯程式碼

建構模式：
**--init：**新專案含技術棧（React|API|Fullstack|Mobile|CLI）| TS 預設 | 測試設置 | Git 工作流程
**--feature：**實現功能→使用現有模式 | 保持一致性 | 包含測試  
**--tdd：**編寫失敗的測試→最少程式碼→通過測試→重構

模板：
- **React：**Vite|TS|Router|狀態管理|測試
- **API：**Express|TS|驗證|認證|OpenAPI  
- **Fullstack：**React+Node.js+Docker
- **Mobile：**React Native+Expo
- **CLI：**Commander.js+配置+測試

**--watch：**持續建構 | 即時回饋 | 增量 | 即時重載
**--interactive：**逐步配置 | 互動式相依性 | 建構自訂

@include shared/research-patterns.yml#Mandatory_Research_Flows

@include shared/execution-patterns.yml#Git_Integration_Patterns

@include shared/universal-constants.yml#Standard_Messages_Templates