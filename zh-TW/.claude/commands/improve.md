**用途**: 基於證據的增強和最佳化

---

@include shared/universal-constants.yml#Universal_Legend

## 命令執行
執行：立即。--plan→先顯示計畫
圖例：根據命令中使用的符號生成
用途："[動作][主題] 在 $ARGUMENTS"

使用最佳實踐和最佳化技術，系統性地改善 $ARGUMENTS 中的程式碼品質、效能和架構。

@include shared/flag-inheritance.yml#Universal_Always

範例：
- `/improve --quality` - 程式碼品質改善
- `/improve --perf --iterate` - 效能最佳化
- `/improve --arch --think-hard` - 架構重構

## 命令特定旗標
--quality: "程式碼品質改善（可讀性、可維護性、DRY）"
--perf: "效能最佳化（演算法、快取、查詢）"
--arch: "架構改善（模式、耦合、可擴展性）"
--refactor: "保持行為的安全重構"
--iterate: "迭代改善直到達到閾值"
--threshold: "品質閾值（low|medium|high|perfect）"
--metrics: "顯示改善前後的指標"
--safe: "保守模式 - 僅進行安全變更"

## 改善類別

**程式碼品質:** 命名清晰度 | 函式提取 | 重複移除 | 複雜度降低 | 錯誤處理 | 型別安全

**效能:** 演算法最佳化 | 查詢最佳化 | 快取策略 | 延遲載入 | 記憶體效率 | 平行處理

**架構:** 設計模式 | 相依性注入 | 層級分離 | 模組邊界 | API 設計 | 可擴展性模式

**可維護性:** 文件 | 測試覆蓋率 | 配置提取 | 魔術數字移除 | 無效程式碼消除

## 改善流程

**1. 分析:** 當前狀態評估 | 識別改善區域 | 依影響排序優先順序 | 設定可衡量的目標

**2. 規劃:** 安全重構路徑 | 保留功能性 | 增量變更 | 回滾策略

**3. 實作:** 小型原子變更 | 持續測試 | 效能監控 | 程式碼審查就緒

**4. 驗證:** 行為保留 | 效能提升 | 品質指標 | 迴歸測試

@include shared/quality-patterns.yml#Code_Quality_Metrics

## 交付成果

**改善的程式碼:** 重構的檔案 | 保留的功能 | 增強的品質 | 更好的效能

**改善報告:** 改善前後的指標 | 變更摘要 | 效能提升 | 品質改善

**文件:** 重構決策 | 架構變更 | 效能最佳化 | 未來建議

@include shared/universal-constants.yml#Standard_Messages_Templates