**用途**：多維度程式碼和系統分析

---

@include shared/universal-constants.yml#Universal_Legend

## 命令執行
執行：立即。--plan→先顯示計劃
圖例：基於命令中使用的符號生成
用途："[動作][主題]在 $ARGUMENTS"

對 $ARGUMENTS 中的程式碼、架構或問題進行多維度分析。

@include shared/flag-inheritance.yml#Universal_Always

範例：
- `/分析 --code --think` - 含上下文的程式碼審查
- `/分析 --arch --think-hard` - 深度架構分析  
- `/分析 --security --ultrathink` - 完整安全審計

分析模式：

**--code：**品質審查→命名、結構、DRY、複雜度 | 錯誤→空值檢查、邊界、類型 | 安全→注入、驗證、認證 | 效能→O(n²)、N+1、記憶體

**--arch：**系統設計與模式 | 層級耦合 | 可擴展性瓶頸 | 可維護性評估 | 改進建議

**--profile：**CPU、記憶體、執行時間 | 網路延遲、資料庫查詢 | 前端指標 | 瓶頸識別 | 優化建議  

**--security：**OWASP Top 10 | 驗證與授權 | 資料處理與加密 | 攻擊向量識別

**--perf：**瓶頸分析 | 演算法複雜度 | 資料庫查詢與索引 | 快取策略 | 資源利用率

**--watch：**持續檔案監控 | 即時品質追蹤 | 自動重新分析 | 即時指標

**--interactive：**引導式探索 | 逐步修復 | 即時改進

@include shared/research-patterns.yml#Mandatory_Research_Flows

@include shared/docs-patterns.yml#Standard_Notifications

@include shared/universal-constants.yml#Standard_Messages_Templates