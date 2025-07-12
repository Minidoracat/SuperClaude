**用途**: 專案複雜度和時間估算

---

@include shared/universal-constants.yml#Universal_Legend

## 命令執行
執行：立即。--plan→先顯示計畫
圖例：根據命令中使用的符號生成
用途："[動作][主題] 在 $ARGUMENTS"

為 $ARGUMENTS 中指定的任務提供完整的時間、複雜度和資源估算。

@include shared/flag-inheritance.yml#Universal_Always

範例：
- `/estimate "新增使用者驗證"` - 快速功能估算
- `/estimate --scope project --detail high --team medium` - 詳細專案估算
- `/estimate --scope migration --team large --ultrathink` - 遷移專案估算

估算模式：

**--scope:** 估算範圍
- feature：單一功能估算 | epic：多功能史詩
- project：完整專案範圍 | refactor：程式碼重構工作 | migration：資料/系統遷移

**--team:** 團隊規模
- solo：單一開發者 | small：2-3 位開發者
- medium：4-8 位開發者 | large：9 位以上開發者

**--detail:** 估算詳細程度
- high：詳細分解 | medium：標準估算 | low：快速粗略估算

## 估算框架

@include shared/execution-patterns.yml#Estimation_Methodology

@include shared/docs-patterns.yml#Standard_Notifications

@include shared/universal-constants.yml#Standard_Messages_Templates