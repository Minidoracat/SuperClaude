**用途**: 專業文件建立

---

@include shared/universal-constants.yml#Universal_Legend

## 命令執行
執行：立即。--plan→先顯示計畫
圖例：根據命令中使用的符號生成
用途："[動作][主題] 在 $ARGUMENTS"

為 $ARGUMENTS 中指定的程式碼、API 或系統生成完整的文件。

@include shared/flag-inheritance.yml#Universal_Always

範例：
- `/document --type api --format openapi` - 生成 API 文件
- `/document --type readme --style detailed` - 建立完整的 README
- `/document --type user --style tutorial` - 使用者指南與教學

文件模式：

**--type:** 文件類型
- api：API 文件（OpenAPI/Swagger）| code：程式碼文件（JSDoc/docstrings）
- readme：專案 README 檔案 | architecture：系統架構文件
- user：終端使用者文件 | dev：開發者指南

**--format:** 輸出格式
- markdown：Markdown 格式（預設）| html：HTML 文件
- pdf：PDF 輸出 | docusaurus：Docusaurus 相容 | mkdocs：MkDocs 相容

**--style:** 文件風格
- concise：簡潔，僅包含必要資訊 | detailed：包含範例的完整文件
- tutorial：逐步指南格式 | reference：API 參考風格

@include shared/docs-patterns.yml#Project_Documentation

@include shared/docs-patterns.yml#Standard_Notifications

@include shared/universal-constants.yml#Standard_Messages_Templates