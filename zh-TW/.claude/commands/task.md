**用途**: 跨會話的複雜功能管理

---

@include shared/universal-constants.yml#Universal_Legend

## 命令執行
執行：立即。--plan→先顯示計畫
圖例：根據命令中使用的符號生成
用途："[動作][主題] 在 $ARGUMENTS"

管理複雜功能和需求，跨會話具有自動分解、上下文保留和恢復能力。

@include shared/flag-inheritance.yml#Universal_Always

範例：
- `/task:create "實作 OAuth 2.0 驗證系統"` - 建立複雜功能任務
- `/task:status oauth-task-id` - 檢查任務狀態
- `/task:resume oauth-task-id` - 休息後恢復工作
- `/task:update oauth-task-id "發現程式庫衝突"` - 更新發現

## 操作

/task:create [描述]：
- 建立具有自動分解的新任務
- 生成子任務和里程碑
- 設定追蹤結構
- 初始化上下文保留

/task:update [task-id] [更新]：
- 更新任務進度
- 修改需求
- 調整時程
- 新增發現

/task:status [task-id]：
- 顯示當前進度
- 列出已完成的子任務
- 顯示阻礙
- 估計剩餘工作

/task:resume [task-id]：
- 載入任務上下文
- 從最後點繼續
- 恢復工作狀態
- 更新進度

/task:complete [task-id]：
- 標記任務為完成
- 生成摘要
- 歸檔產出物
- 建立文件

## 任務結構

@include shared/task-management-patterns.yml#Task_Management_Hierarchy

任務元件：
- 標題和描述
- 驗收標準
- 技術需求
- 子任務分解
- 進度追蹤
- 上下文保留

## 自動功能

智慧分解：
- 分析複雜度
- 建立子任務
- 識別相依性
- 估計工作量
- 設定里程碑

上下文保留：
- 儲存工作狀態
- 追蹤決策
- 儲存程式碼變更
- 維護歷史
- 啟用恢復

進度追蹤：
- 自動更新
- 追蹤阻礙
- 監控速度
- 調整估計
- 報告狀態

## 恢復系統

@include shared/session-recovery.yml#Recovery_Patterns

會話恢復：
- 自動偵測未完成的任務
- 載入先前的上下文
- 從檢查點恢復
- 維持連續性
- 保持動力

## 最佳實踐

任務建立：
- 明確需求
- 可衡量的成果
- 實際範圍
- 定義邊界
- 成功標準

任務管理：
- 定期更新
- 及早追蹤阻礙
- 記錄決策
- 增量測試
- 溝通進度

## 範例

```bash
# 建立複雜功能任務
/task:create "實作 OAuth 2.0 驗證系統"

# 檢查任務狀態
/task:status oauth-task-id

# 休息後恢復工作
/task:resume oauth-task-id

# 更新發現
/task:update oauth-task-id "發現程式庫衝突，切換方法"

# 完成並生成摘要
/task:complete oauth-task-id
```

## 整合

配合使用：
- TodoWrite 用於子任務
- Git 用於版本控制
- Test 用於驗證
- Document 用於產出物
- 所有開發命令

## 交付成果

- 任務分解文件
- 進度追蹤報告
- 技術決策日誌
- 實作產出物
- 完成摘要
- 學到的經驗

@include shared/universal-constants.yml#Standard_Messages_Templates