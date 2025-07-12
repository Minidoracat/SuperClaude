**用途**: 安全的應用程式部署與回滾

---

@include shared/universal-constants.yml#Universal_Legend

## 命令執行
執行：立即。--plan→先顯示計畫
圖例：根據命令中使用的符號生成
用途："[動作][主題] 在 $ARGUMENTS"

將應用程式部署到 $ARGUMENTS 中指定的環境。

@include shared/flag-inheritance.yml#Universal_Always

範例：
- `/deploy --env staging --think` - 暫存環境部署與協調分析
- `/deploy --env prod --think-hard` - 生產環境部署與全面規劃
- `/deploy --rollback --ultrathink` - 關鍵回滾與完整影響分析

部署模式：

**--env:** 指定目標環境
- dev：部署→開發環境進行測試
- staging：部署→暫存環境進行生產前驗證
- prod：部署→生產環境與所有安全檢查

**--rollback:** 還原→前一個穩定部署 | 維護部署歷史→稽核軌跡 | 透過健康檢查驗證回滾成功

部署前清理：
- 清理先前的產出物 | 移除僅開發用檔案（.env.local、除錯設定）
- 驗證生產設定（無除錯旗標、正確的 URL）| 清理舊版本→釋放空間

部署工作流程：
1. 驗證→檢查先決條件和設定 2. 建置→建立產出物 3. 測試→執行冒煙測試
4. 部署→執行策略 5. 驗證→確認健康狀態和功能

部署策略：
- 藍綠部署：兩個環境，切換流量→零停機時間 | 金絲雀部署：漸進式推出→百分比使用者
- 滾動部署：依序更新執行個體並進行健康檢查

部署前檢查：
- 驗證測試通過 | 檢查部署設定 | 確保回滾計畫存在
- 驗證環境變數 | 確認資料庫遷移已完成

部署後：
- 執行健康檢查和冒煙測試 | 監控錯誤率和效能
- 檢查關鍵使用者旅程 | 驗證日誌記錄和監控 | 準備→如有問題則回滾

## 安全性與最佳實踐

安全性：
- 始終要有回滾計畫 | 部署前備份
- 部署期間監控關鍵指標 | 漸進式推出→重大變更

@include shared/research-patterns.yml#Mandatory_Research_Flows

@include shared/docs-patterns.yml#Standard_Notifications

@include shared/universal-constants.yml#Standard_Messages_Templates