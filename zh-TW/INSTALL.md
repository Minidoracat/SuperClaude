# SuperClaude 繁體中文版安裝指南

## 概述
SuperClaude 現在支援繁體中文版指令！您可以使用中文指令名稱來執行所有功能。

## 安裝步驟

### 1. 安裝繁體中文版指令
```bash
# 使用語言參數安裝中文版
SuperClaude install --language zh-TW

# 或設定環境變數
export SUPERCLAUDE_LANG=zh-TW
SuperClaude install
```

### 2. 選擇安裝模式
- **快速安裝**：推薦的元件組合
- **最小安裝**：僅安裝核心元件
- **自訂安裝**：選擇特定元件

### 3. 中文指令使用方式

安裝完成後，您可以使用中文指令：

```
/sc:分析 [目標] [--focus quality|security|performance|architecture]
/sc:建構 [目標] [--type dev|prod|test]
/sc:測試 [目標] [--type unit|integration|e2e|all]
/sc:實作 [功能描述] [--type component|api|service|feature]
```

## 指令對照表

| 中文指令 | 英文指令 | 說明 |
|---------|---------|------|
| /sc:分析 | /sc:analyze | 分析程式碼品質、安全性、效能和架構 |
| /sc:建構 | /sc:build | 建構、編譯和打包專案 |
| /sc:測試 | /sc:test | 執行測試並產生報告 |
| /sc:解釋 | /sc:explain | 解釋程式碼功能和概念 |
| /sc:清理 | /sc:cleanup | 清理程式碼和專案結構 |
| /sc:實作 | /sc:implement | 實作功能和程式碼 |
| /sc:疑難排解 | /sc:troubleshoot | 診斷並解決問題 |
| /sc:文件 | /sc:document | 建立專注的文件 |
| /sc:改善 | /sc:improve | 改善程式碼品質 |
| /sc:設計 | /sc:design | 設計系統架構 |
| /sc:工作流程 | /sc:workflow | 產生實作工作流程 |
| /sc:估算 | /sc:estimate | 開發時程估算 |
| /sc:任務 | /sc:task | 管理複雜任務 |
| /sc:索引 | /sc:index | 產生專案文件 |
| /sc:載入 | /sc:load | 載入專案脈絡 |
| /sc:協調 | /sc:spawn | 協調子任務執行 |

## 環境變數

您可以設定以下環境變數來控制預設行為：

```bash
# 設定預設語言為繁體中文
export SUPERCLAUDE_LANG=zh-TW

# 設定安裝目錄（預設為 ~/.claude）
export SUPERCLAUDE_INSTALL_DIR=~/.claude
```

## 並行使用

您可以同時安裝英文和中文版本：

1. 先安裝英文版（預設）
   ```bash
   SuperClaude install
   ```

2. 再安裝中文版
   ```bash
   SuperClaude install --language zh-TW
   ```

這樣您就可以同時使用：
- 英文指令：`/sc:analyze`、`/sc:build` 等
- 中文指令：`/sc:分析`、`/sc:建構` 等

## 注意事項

1. 中文指令會安裝到 `~/.claude/commands/sc-zh/` 目錄
2. 英文指令會安裝到 `~/.claude/commands/sc/` 目錄
3. 兩個版本可以同時存在，不會互相衝突
4. 指令的參數和選項保持英文（例如 `--type`、`--focus`）

## 更多資訊

如需更多資訊，請參考：
- [SuperClaude 使用指南](../README_zh-TW.md)
- [指令詳細說明](SuperClaude/Commands/)
- [專案 GitHub](https://github.com/Shafayat/SuperClaude)