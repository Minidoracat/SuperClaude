**用途**: 全面的測試框架

---

@include shared/universal-constants.yml#Universal_Legend

## 命令執行
執行：立即。--plan→先顯示計畫
圖例：根據命令中使用的符號生成
用途："[動作][主題] 在 $ARGUMENTS"

使用現代測試框架和方法論，為 $ARGUMENTS 中指定的程式碼建立或執行全面的測試套件。

@include shared/flag-inheritance.yml#Universal_Always

範例：
- `/test --tdd` - 測試驅動開發工作流程
- `/test --coverage` - 生成覆蓋率報告
- `/test --watch` - 持續測試模式
- `/test --integration` - 執行整合測試
- `/test --e2e` - 執行端對端測試

## 命令特定旗標
--tdd: "測試驅動開發工作流程（撰寫失敗測試→實作→通過）"
--coverage: "生成詳細覆蓋率報告與未覆蓋行數"
--integration: "執行跨元件/服務的整合測試"
--e2e: "使用真實瀏覽器/環境執行端對端測試"
--unit: "僅專注於單元測試（預設）"
--mutation: "執行突變測試以驗證測試品質"
--snapshot: "更新/驗證快照測試"
--watch: "在檔案變更時持續執行測試"
--bail: "在第一個測試失敗時停止"
--parallel: "在平行工作器中執行測試"
--update-snapshots: "更新所有快照測試"

## 測試方法

**單元測試:** 隔離的元件/函式測試 | 模擬所有相依性 | 快速執行 | 高覆蓋率目標

**整合測試:** 元件互動測試 | 真實服務呼叫 | 資料庫交易 | API 端點測試

**E2E 測試:** 完整使用者工作流程 | 瀏覽器自動化 | 真實環境 | 關鍵路徑覆蓋

**TDD 工作流程:** 紅→綠→重構循環 | 撰寫最少程式碼 | 全面覆蓋 | 設計浮現

## 測試模式

**測試結構:** 安排-執行-斷言（AAA）| 給定-當-然後（BDD）| 設定→執行→驗證→清理

**覆蓋率目標:** 陳述式：80%+ | 分支：75%+ | 函式：90%+ | 行數：80%+

**測試組織:** 
- `__tests__/` 或 `test/` 目錄
- `*.test.{js,ts}` 或 `*.spec.{js,ts}` 命名
- 在測試目錄中鏡像來源結構
- 按功能或元件分組

@include shared/quality-patterns.yml#Test_Quality_Standards

## 框架支援

**JavaScript/TypeScript:** Jest（預設）| Mocha + Chai | Vitest | Testing Library

**Python:** pytest（預設）| unittest | nose2 | doctest

**Go:** 內建測試 | Testify | Ginkgo/Gomega

**Java:** JUnit 5 | TestNG | Mockito | Spring Test

**其他:** 框架特定的最佳實踐 | 原生測試執行器

## 交付成果

**測試檔案:** 在適當的測試目錄中建立 | 遵循命名慣例 | 全面的測試案例

**覆蓋率報告:** `coverage/` 中的 HTML 報告 | 控制台摘要 | 未覆蓋行識別

**CI 配置:** GitHub Actions | CircleCI | Jenkins | GitLab CI

**文件:** 測試計畫 | 測試案例 | 覆蓋率目標 | CI/CD 整合

@include shared/universal-constants.yml#Standard_Messages_Templates