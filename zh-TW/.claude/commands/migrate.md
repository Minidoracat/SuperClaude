**用途**: 資料庫和程式碼遷移管理

---

@include shared/universal-constants.yml#Universal_Legend

## 命令執行
執行：立即。--plan→先顯示計畫
圖例：根據命令中使用的符號生成
用途："[動作][主題] 在 $ARGUMENTS"

為 $ARGUMENTS 執行資料庫和程式碼遷移。

## 用途
根據 $ARGUMENTS 中的規格執行全面的資料庫或程式碼遷移，包含安全檢查和回滾功能。

## 語法
`/migrate [flags] [migration-spec]`

@include shared/flag-inheritance.yml#Universal_Always

## 核心旗標

--type 旗標：
- database：SQL schema 遷移
- code：程式碼庫重構
- api：API 版本遷移
- data：資料轉換
- full：完整系統遷移

--direction 旗標：
- up：向前套用遷移
- down：回滾遷移
- status：檢查遷移狀態
- validate：測試但不套用

--target 旗標：
- latest：所有待處理的遷移
- version：特定版本
- step：遷移數量
- timestamp：直到日期/時間

## 遷移類型

資料庫遷移：
- Schema 變更（新增/刪除表格）
- 欄位修改
- 索引最佳化
- 約束更新
- 資料轉換

程式碼遷移：
- API 版本更新
- 框架升級
- 相依性更新
- 結構重構
- 模式現代化

資料遷移：
- 格式轉換
- 批量轉換
- ETL 操作
- 清理操作
- 正規化

## 安全功能

遷移前：
- 備份當前狀態
- 驗證遷移檔案
- 檢查相依性
- 在交易中測試
- 估計影響

遷移期間：
- 交易包裝
- 進度追蹤
- 錯誤處理
- 部分回滾
- 健康檢查

遷移後：
- 驗證完整性
- 更新文件
- 清除快取
- 執行測試
- 監控效能

## 遷移工作流程

1. 分析階段：
   - 掃描當前狀態
   - 識別所需變更
   - 生成遷移計畫
   - 估計風險

2. 準備階段：
   - 建立備份
   - 準備回滾計畫
   - 設定監控
   - 通知利害關係人

3. 執行階段：
   - 執行遷移
   - 追蹤進度
   - 處理錯誤
   - 套用修正

4. 驗證階段：
   - 驗證成功
   - 執行測試套件
   - 檢查效能
   - 更新文件

## 最佳實踐

安全性：
- 始終先備份
- 在暫存環境測試
- 使用交易
- 規劃回滾
- 密切監控

效能：
- 批次操作
- 離峰執行
- 索引管理
- 查詢最佳化
- 資源限制

## 範例

```bash
# 資料庫遷移到最新版本
/migrate --type database --direction up

# 回滾最後 2 個遷移
/migrate --type database --direction down --step 2

# 帶驗證的程式碼遷移
/migrate --type code --validate --think

# 完整系統遷移計畫
/migrate --type full --plan --ultrathink
```

## 交付成果

- 遷移腳本
- 回滾程序
- 執行日誌
- 驗證報告
- 更新的文件
- 效能指標