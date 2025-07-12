**用途**: 專案上下文載入與分析

---

@include shared/universal-constants.yml#Universal_Legend

## 命令執行
執行：立即。--plan→先顯示計畫
圖例：根據命令中使用的符號生成
用途："[動作][主題] 在 $ARGUMENTS"

載入並分析 $ARGUMENTS 中的專案上下文。

## 用途
載入並分析 $ARGUMENTS 中的專案上下文，以建立對程式碼庫結構、架構和模式的全面理解。

## 語法
`/load [flags] [path]`

@include shared/flag-inheritance.yml#Universal_Always

## 核心旗標

--scope 旗標：
- minimal：僅核心檔案
- standard：主要來源和配置
- comprehensive：所有相關檔案
- full：完整專案分析

--focus 旗標：
- architecture：系統設計
- api：API 端點和契約
- database：Schema 和查詢
- frontend：UI 元件
- testing：測試覆蓋率

--format 旗標：
- summary：高層次概覽
- detailed：全面分析
- visual：包含圖表
- structured：YAML/JSON 輸出

## 載入策略

漸進式載入：
1. 核心檔案（package.json、配置）
2. 進入點（main、index）
3. 關鍵模組和元件
4. 測試和文件
5. 支援檔案

智慧選擇：
- 按重要性排序優先順序
- 跳過生成的檔案
- 專注於活躍的程式碼
- 包含關鍵配置
- 遵守 .gitignore

## 分析元件

結構分析：
- 目錄組織
- 模組相依性
- 元件層次結構
- API 表面積
- 資料庫 schema

模式偵測：
- 使用的設計模式
- 編碼慣例
- 架構風格
- 技術堆疊
- 最佳實踐

品質指標：
- 程式碼複雜度
- 測試覆蓋率
- 文件層級
- 技術債務
- 安全性考量

## 輸出格式

標準報告：
```yaml
專案: [名稱]
類型: [Web 應用程式/API/程式庫]
技術堆疊:
  前端: [技術]
  後端: [技術]
  資料庫: [類型]
架構:
  風格: [單體/微服務]
  模式: [清單]
關鍵元件:
  - [元件]: [用途]
品質:
  測試覆蓋率: X%
  文件: [層級]
  複雜度: [分數]
```

## 最佳實踐

效率：
- 增量載入
- 快取分析結果
- 專注於變更
- 跳過多餘的檔案
- 最佳化記憶體使用

準確性：
- 驗證假設
- 交叉參考檔案
- 檢查文件
- 驗證模式
- 定期更新

## 範例

```bash
# 快速專案概覽
/load --scope minimal

# 完整架構分析
/load --scope comprehensive --focus architecture

# API 文件生成
/load --focus api --format detailed

# 完整專案理解
/load --scope full --think-hard
```

## 整合

@include shared/loading-config.yml#Loading_Strategies

配合使用：
- /analyze 進行深入檢查
- /document 生成文件
- /improve 進行增強
- /estimate 進行規劃

## 交付成果

- 專案結構圖
- 架構圖表
- 元件清單
- 相依性圖
- 品質指標報告
- 模式分析