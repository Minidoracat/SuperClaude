**用途**: 安全稽核和驗證

---

@include shared/universal-constants.yml#Universal_Legend

## 命令執行
執行：立即。--plan→先顯示計畫
圖例：根據命令中使用的符號生成
用途："[動作][主題] 在 $ARGUMENTS"

對 $ARGUMENTS 中指定的程式碼執行全面的安全、品質和相依性掃描。

@include shared/flag-inheritance.yml#Universal_Always

範例：
- `/scan --security` - 安全漏洞掃描
- `/scan --deps` - 相依性稽核
- `/scan --validate` - 完整驗證掃描
- `/scan --quick` - 快速掃描關鍵問題

## 命令特定旗標
--security: "深度安全漏洞掃描（OWASP、CVE、密碼）"
--deps: "相依性漏洞稽核與修正建議"
--validate: "全面驗證（語法、型別、邏輯、安全）"
--quick: "快速掃描僅關注關鍵問題"
--fix: "自動修正安全問題"
--strict: "零容忍模式（任何問題都失敗）"
--report: "生成詳細報告"
--ci: "CI 友好的輸出格式"

## 掃描類型

**安全掃描:** OWASP Top 10 | 注入漏洞 | 驗證缺陷 | 敏感資料暴露 | 硬編碼密碼 | CVE 資料庫檢查

**相依性掃描:** 已知漏洞 | 過時套件 | 授權合規 | 供應鏈風險 | 傳遞相依性

**程式碼品質:** 複雜度指標 | 重複 | 無效程式碼 | 型別安全 | 最佳實踐 | 效能反模式

**配置:** 配置錯誤的服務 | 不安全的預設值 | 缺少安全標頭 | 暴露的端點 | 弱加密

## 驗證層級

**快速（--quick）:** 僅關鍵安全性 | 已知 CVE | 硬編碼密碼 | SQL 注入 | XSS 漏洞

**標準（預設）:** 所有安全檢查 | 主要品質問題 | 相依性漏洞 | 配置問題

**嚴格（--strict）:** 所有內容 + 次要問題 | 樣式違規 | 文件缺口 | 測試覆蓋率 | 效能警告

@include shared/security-patterns.yml#OWASP_Top_10

## 交付成果

**報告:** `.claudedocs/scans/security-{timestamp}.md` | 嚴重性分類 | 修正建議 | 風險評估

**修正腳本:** 自動生成的修補程式 | 安全的自動修正 | 手動修正說明 | 回滾程序

**CI 整合:** 退出碼 | JSON 輸出 | SARIF 格式 | GitHub/GitLab 整合

@include shared/universal-constants.yml#Standard_Messages_Templates