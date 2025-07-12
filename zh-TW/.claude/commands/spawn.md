**用途**: 平行專業化代理

---

@include shared/universal-constants.yml#Universal_Legend

## 命令執行
執行：立即。--plan→先顯示計畫
圖例：根據命令中使用的符號生成
用途："[動作][主題] 在 $ARGUMENTS"

為專注任務生成專業化子代理，具有平行執行能力。

@include shared/flag-inheritance.yml#Universal_Always

範例：
- `/spawn --agent researcher "OAuth 2.0 最佳實踐"` - 研究然後實作
- `/spawn --mode parallel --agent builder "使用者驗證, 個人資料 API"` - 平行開發
- `/spawn --mode sequential "研究 → 建置 → 審查付款"` - 完整週期工作流程
- `/spawn --mode collaborative --ultrathink "設計微服務"` - 協作設計

## 代理類型

研究員代理：
- 深入探討主題
- 比較解決方案
- 分析權衡
- 尋找最佳實踐
- 記錄發現

建造者代理：
- 生成程式碼
- 實作功能
- 建立測試
- 建立原型
- 整合系統

審查員代理：
- 程式碼品質檢查
- 安全分析
- 效能審查
- 最佳實踐驗證
- 建議改善

最佳化代理：
- 效能分析
- 資源最佳化
- 演算法改善
- 資料庫調校
- 快取策略

文件撰寫代理：
- API 文件
- 使用者指南
- 程式碼註解
- 架構文件
- README 檔案

## 執行模式

循序模式：
```yaml
流程: 代理1 → 代理2 → 代理3
使用: 當任務相互依賴時
範例: 研究 → 建置 → 審查
```

平行模式：
```yaml
流程: 代理1 | 代理2 | 代理3
使用: 用於獨立任務
範例: 多個功能建置
```

協作模式：
```yaml
流程: 代理們一起工作
使用: 複雜問題
範例: 系統設計會議
```

## 最佳實踐

任務定義：
- 明確目標
- 具體交付成果
- 成功標準
- 資源限制
- 時間限制

代理選擇：
- 匹配專業知識與任務
- 考慮相依性
- 規劃協調
- 設定邊界
- 定義交接

協調：
- 清晰溝通
- 共享上下文
- 進度追蹤
- 結果整合
- 品質控制

## 範例

```bash
# 研究然後實作
/spawn --agent researcher "OAuth 2.0 最佳實踐"
/spawn --agent builder "基於研究實作 OAuth"

# 平行功能開發
/spawn --mode parallel --agent builder "使用者驗證, 個人資料 API, 設定 UI"

# 完整週期與審查
/spawn --mode sequential "研究 → 建置 → 審查付款整合"

# 協作系統設計
/spawn --mode collaborative --ultrathink "設計微服務架構"
```

## 整合

配合使用：
- 所有命令旗標都會傳遞
- 繼承角色偏好
- 共享專案上下文
- 累積發現
- 協調輸出

## 交付成果

- 代理執行日誌
- 任務完成報告
- 整合結果
- 效能指標
- 學到的經驗
- 交接文件

@include shared/universal-constants.yml#Standard_Messages_Templates