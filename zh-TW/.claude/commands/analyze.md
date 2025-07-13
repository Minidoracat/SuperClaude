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

## 圖譜整合（--graph 旗標）

當使用 --graph 旗標時，將分析結果儲存至 Graphiti Memory：

```yaml
圖譜儲存行為:
  群組ID: "project_[工作目錄名稱]"
  
  架構分析 (--arch):
    要儲存的實體:
      - 類型: "元件"
        範例: ["API閘道", "認證服務", "資料庫層"]
      - 類型: "模組" 
        範例: ["使用者模組", "支付模組", "通知模組"]
      - 類型: "模式"
        範例: ["MVC", "儲存庫模式", "觀察者模式"]
    
    要建立的關係:
      - "依賴於" (模組 → 模組相依性)
      - "實作" (元件 → 模式關係)
      - "通訊" (服務 → 服務互動)
    
    要記錄的事實:
      - 架構決策和理由
      - 技術棧選擇
      - 可擴展性考量
  
  程式碼分析 (--code):
    要儲存的實體:
      - 類型: "程式碼問題"
        屬性: ["嚴重性", "位置", "建議"]
      - 類型: "程式碼模式"
        屬性: ["名稱", "使用次數", "品質分數"]
      - 類型: "技術債"
        屬性: ["類型", "影響", "修復努力"]
    
    要記錄的事實:
      - 程式碼品質指標和趨勢
      - 重構建議
      - 識別的效能瓶頸
  
  安全分析 (--security):
    要儲存的實體:
      - 類型: "漏洞"
        屬性: ["嚴重性", "OWASP類別", "修復方法"]
      - 類型: "安全控制"
        屬性: ["類型", "有效性", "覆蓋範圍"]
    
    要記錄的事實:
      - 安全態勢評估
      - 合規狀態
      - 風險緩解策略
  
  效能分析 (--perf):
    要儲存的實體:
      - 類型: "瓶頸"
        屬性: ["位置", "影響", "優化建議"]
      - 類型: "資源"
        屬性: ["類型", "使用量", "限制"]
    
    要記錄的事實:
      - 效能基準
      - 優化機會
      - 資源使用模式

儲存範例:
  # 架構分析的儲存範例
  - 實體: "使用者服務"
    類型: "元件"
    屬性:
      技術: "Node.js"
      職責: "使用者認證和管理"
  
  - 關係:
      從: "使用者服務"
      到: "認證模組"
      類型: "依賴於"
      屬性:
        關鍵: true
        
  - 事實: "系統使用微服務架構，包含5個獨立服務"
```

@include shared/graph-integration.yml#Graph_Integration_Standards