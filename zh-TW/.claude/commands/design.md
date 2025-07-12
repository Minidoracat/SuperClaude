**用途**: 系統架構與 API 設計

---

@include shared/universal-constants.yml#Universal_Legend

## 命令執行
執行：立即。--plan→先顯示計畫
圖例：根據命令中使用的符號生成
用途："[動作][主題] 在 $ARGUMENTS"

為 $ARGUMENTS 設計系統架構和 API。

@include shared/flag-inheritance.yml#Universal_Always

範例：
- `/design --api --think` - REST API 設計與模式
- `/design --ddd --think-hard` - 深度領域建模
- `/design --api --ddd --ultrathink` - 完整系統架構

設計模式：

**--api:** 設計 REST 或 GraphQL API
- 搭配 --openapi：生成 OpenAPI 3.0 規格 | 搭配 --graphql：建立 GraphQL schema 和解析器
- 包含驗證、速率限制和錯誤處理 | 設計→可擴展性和可維護性

**--ddd:** 應用 DDD 原則
- 搭配 --bounded-context：定義上下文邊界和映射
- 設計實體、值物件和聚合 | 建立領域服務和事件 | 實作儲存庫模式

**--prd:** 建立 PRD
- 搭配 --template：使用範本（功能/API/整合/遷移）
- 包含使用者故事與驗收標準 | 定義成功指標和時程 | 記錄技術需求

## 設計模式

@include shared/architecture-patterns.yml#API_Design_Patterns

@include shared/architecture-patterns.yml#DDD_Patterns

@include shared/architecture-patterns.yml#PRD_Templates

## 整合與最佳實踐

組合模式：API+DDD：設計領域驅動的 API | API+PRD：建立 API 產品需求 | DDD+PRD：記錄領域驅動架構 | 三者結合：完整系統設計

最佳實踐：從使用者需求和業務目標開始 | 設計→變更和演進 | 及早考慮非功能性需求 | 記錄決策和理由 | 包含範例和圖表 | 規劃→測試和監控

@include shared/research-patterns.yml#Mandatory_Research_Flows

@include shared/docs-patterns.yml#Standard_Notifications

@include shared/universal-constants.yml#Standard_Messages_Templates