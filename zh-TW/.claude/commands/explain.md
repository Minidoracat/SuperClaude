**用途**: 技術文件和知識傳遞

---

@include shared/universal-constants.yml#Universal_Legend

## 命令執行
執行：立即。--plan→先顯示計畫
圖例：根據命令中使用的符號生成
用途："[動作][主題] 在 $ARGUMENTS"

對 $ARGUMENTS 中指定的概念、程式碼或系統提供全面的解釋。

@include shared/flag-inheritance.yml#Universal_Always

範例：
- `/explain --depth beginner --style tutorial "React hooks"` - 為初學者解釋 React hooks
- `/explain --depth advanced --visual "B-tree 索引"` - 深入探討資料庫索引
- `/explain --depth expert --think "快速排序最佳化"` - 演算法解釋與複雜度

解釋模式：

**--depth:** 解釋深度層級
- beginner：基礎概念，簡單語言 | intermediate：標準技術深度
- advanced：深入技術細節 | expert：尖端技術和內部原理

**--style:** 解釋風格
- tutorial：逐步學習 | reference：快速查詢格式
- conversational：自然對話 | academic：正式且徹底

**--visual:** 包含視覺輔助
- 圖表和流程圖 | 帶註解的程式碼範例
- 架構視覺化 | 流程的序列圖

@include shared/research-patterns.yml#Explanation_Methodology

@include shared/docs-patterns.yml#Standard_Notifications

@include shared/universal-constants.yml#Standard_Messages_Templates