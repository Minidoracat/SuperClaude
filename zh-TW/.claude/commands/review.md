**用途**: AI 驅動的程式碼審查和品質分析

---

@include shared/universal-constants.yml#Universal_Legend

## 命令執行
執行：立即。--plan→先顯示計畫
圖例：根據命令中使用的符號生成
用途："[動作][主題] 在 $ARGUMENTS"

對 $ARGUMENTS 中指定的檔案、提交或 pull request 執行全面的程式碼審查和品質分析。

@include shared/flag-inheritance.yml#Universal_Always

範例：
- `/review --files src/auth.ts --persona-security` - 以安全為重點的檔案審查
- `/review --commit HEAD --quality --evidence` - 帶有來源的品質審查
- `/review --pr 123 --all --interactive` - 全面的 PR 審查
- `/review --files src/ --persona-performance --think` - 效能分析

## 命令特定旗標
--files: "審查特定檔案或目錄"
--commit: "審查指定提交中的變更（HEAD、hash、範圍）"
--pr: "審查 pull request 變更（git diff main..branch）"
--quality: "專注於程式碼品質問題（DRY、SOLID、複雜度）"
--evidence: "為所有建議包含來源和文件"
--fix: "為識別的問題建議具體修正"
--summary: "生成審查發現的執行摘要"

@include shared/quality-patterns.yml#Code_Quality_Metrics

@include shared/security-patterns.yml#OWASP_Top_10

@include shared/compression-performance-patterns.yml#Performance_Baselines

@include shared/architecture-patterns.yml#DDD_Building_Blocks

## 審查流程與方法論

**1. 上下文分析:** 理解程式碼庫模式 | 識別架構風格 | 識別團隊慣例 | 建立審查範圍

**2. 多維度掃描:** 跨所有維度的品質評估 | 角色特定的深入探討 | 交叉參考分析 | 相依性影響審查

**3. 證據收集:** 透過 Context7 研究最佳實踐 | 引用權威來源 | 參考文件 | 提供可衡量的指標

**4. 優先順序發現:** 關鍵問題優先 | 突出安全漏洞 | 識別效能瓶頸 | 建議品質改善

**5. 可行動的建議:** 具體修正建議 | 替代方法 | 重構機會 | 預防策略

**基於證據的分析:** 所有建議必須引用權威來源 | 透過 Context7 參考官方文件 | 交叉參考產業標準 | 效能聲明需要可衡量的證據

**角色專業化:** 安全→漏洞+合規 | 效能→瓶頸+最佳化 | 架構→模式+可維護性 | QA→覆蓋率+驗證

@include shared/research-patterns.yml#Mandatory_Research_Flows

@include shared/quality-patterns.yml#Validation_Sequence

## 角色整合

**--persona-security:** 安全優先分析 | 威脅建模 | 漏洞掃描 | 合規檢查 | 風險評估

**--persona-performance:** 效能最佳化重點 | 瓶頸識別 | 資源分析 | 可擴展性審查

**--persona-architect:** 系統設計評估 | 模式評估 | 可維護性審查 | 技術債務分析

**--persona-qa:** 測試覆蓋率分析 | 邊界案例識別 | 品質指標 | 驗證策略

**--persona-refactorer:** 程式碼改善機會 | 重構建議 | 清理建議 | 模式應用

@include shared/execution-patterns.yml#Servers

@include shared/docs-patterns.yml#Standard_Notifications

@include shared/universal-constants.yml#Standard_Messages_Templates