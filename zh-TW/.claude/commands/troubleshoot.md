**用途**: 專業除錯和問題解決

---

@include shared/universal-constants.yml#Universal_Legend

## 命令執行
執行：立即。--plan→先顯示計畫
圖例：根據命令中使用的符號生成
用途："[動作][主題] 在 $ARGUMENTS"

使用根本原因分析和基於證據的解決方案，系統性地除錯和解決 $ARGUMENTS 中的問題。

@include shared/flag-inheritance.yml#Universal_Always

範例：
- `/troubleshoot "應用程式啟動時崩潰"` - 除錯崩潰
- `/troubleshoot --performance "緩慢的 API"` - 效能問題
- `/troubleshoot --interactive "登入失敗"` - 引導式除錯

## 命令特定旗標
--performance: "專注於效能瓶頸"
--memory: "記憶體洩漏偵測和分析"
--network: "網路相關除錯"
--interactive: "逐步引導式疑難排解"
--trace: "啟用詳細執行追蹤"
--bisect: "Git bisect 尋找破壞的提交"

## 疑難排解方法

**1. 重現:** 隔離最小重現 | 記錄步驟 | 驗證一致性 | 擷取完整上下文

**2. 收集證據:** 錯誤訊息和堆疊追蹤 | 日誌和指標 | 系統狀態 | 最近變更 | 環境差異

**3. 形成假設:** 最可能的原因 | 替代解釋 | 測試預測 | 排除可能性

**4. 測試和驗證:** 有針對性的實驗 | 改變一個變數 | 記錄結果 | 確認根本原因

**5. 修正和預防:** 實作解決方案 | 新增測試 | 記錄修正 | 防止再次發生

## 常見問題類別

**效能:** 緩慢查詢 | 記憶體洩漏 | CPU 瓶頸 | 網路延遲 | 低效演算法

**崩潰/錯誤:** 空參考 | 型別不匹配 | 競態條件 | 記憶體損壞 | 堆疊溢位

**整合:** API 失敗 | 驗證問題 | 版本衝突 | 配置問題 | 網路逾時

**資料問題:** 損壞 | 不一致 | 遷移失敗 | 編碼問題 | 並發衝突

@include shared/quality-patterns.yml#Root_Cause_Analysis

## 交付成果

**根本原因報告:** 問題描述 | 收集的證據 | 分析過程 | 識別的根本原因 | 實作的修正

**修正文件:** 什麼壞了 | 為什麼壞了 | 如何修正 | 預防措施 | 新增的測試案例

**知識庫:** 問題→解決方案映射 | 疑難排解指南 | 常見模式 | 預防檢查清單

@include shared/universal-constants.yml#Standard_Messages_Templates