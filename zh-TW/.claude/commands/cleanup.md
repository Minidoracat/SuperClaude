**用途**: 專案清理與維護

---

@include shared/universal-constants.yml#Universal_Legend

## 命令執行
執行：立即。--plan→先顯示計畫
圖例：根據命令中使用的符號生成
用途："[動作][主題] 在 $ARGUMENTS"

清理 $ARGUMENTS 中的專案檔案、相依性和產出物。

@include shared/flag-inheritance.yml#Universal_Always

範例：
- `/cleanup --code --dry-run` - 預覽程式碼清理變更
- `/cleanup --deps --all` - 移除未使用的相依性
- `/cleanup --files --watch` - 持續檔案清理

清理模式：

**--code:** 移除未使用的匯入和無效程式碼 | 清理 console.log 和除錯程式碼 | 移除註解區塊 | 修正樣式不一致 | 移除超過 30 天的 TODO

**--files:** 移除建置產出物和暫存檔案 | 若損壞則清理 node_modules | 移除日誌和快取目錄 | 清理測試輸出 | 移除作業系統檔案（.DS_Store、thumbs.db）

**--deps:** 從 package.json 移除未使用的相依性 | 更新有漏洞的相依性 | 清理重複的相依性 | 最佳化相依性樹 | 檢查過時的套件

**--git:** 移除未追蹤的檔案（需確認）| 清理已合併的分支 | 從歷史記錄中移除大型/不需要的檔案 | 最佳化 git（.git/objects 清理）| 清理過時的參考

**--cfg:** 移除已棄用的設定 | 清理未使用的環境變數 | 更新過時的設定格式 | 驗證設定一致性 | 移除重複項目

**--all:** 全面清理所有區域 | 生成詳細報告 | 建議維護排程 | 提供效能影響分析

**--dry-run:** 顯示將被清理的內容但不做變更 | 估計空間節省和效能影響 | 在清理前識別風險

**--watch:** 監控並自動清理新產出物 | 開發期間持續清理 | 防止暫存檔案累積 | 即時維護

## 整合與最佳實踐

@include shared/research-patterns.yml#Mandatory_Research_Flows

@include shared/docs-patterns.yml#Standard_Notifications

@include shared/universal-constants.yml#Standard_Messages_Templates