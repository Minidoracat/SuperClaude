# SuperClaude v3 🚀

[English](README.md) | [繁體中文](README_zh-TW.md)

[![網站預覽](https://img.shields.io/badge/訪問-網站-blue?logo=google-chrome)](https://superclaude-org.github.io/SuperClaude_Website/)
[![授權: MIT](https://img.shields.io/badge/授權-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PyPI 版本](https://img.shields.io/pypi/v/SuperClaude.svg)](https://pypi.org/project/SuperClaude/)
[![版本](https://img.shields.io/badge/版本-3.0.0-blue.svg)](https://github.com/NomenAK/SuperClaude)
[![GitHub 議題](https://img.shields.io/github/issues/NomenAK/SuperClaude)](https://github.com/NomenAK/SuperClaude/issues)
[![歡迎 PR](https://img.shields.io/badge/PR-歡迎-brightgreen.svg)](https://github.com/NomenAK/SuperClaude/blob/master/CONTRIBUTING.md)
[![貢獻者](https://img.shields.io/github/contributors/NomenAK/SuperClaude)](https://github.com/NomenAK/SuperClaude/graphs/contributors)
[![網站](https://img.shields.io/website?url=https://superclaude-org.github.io/SuperClaude_Website/)](https://superclaude-org.github.io/SuperClaude_Website/)

一個透過專業指令、角色人格和 MCP 伺服器整合來擴展 Claude Code 功能的框架。

**📢 狀態**: 初始版本，剛脫離測試階段！在我們持續改進的過程中可能會出現錯誤。

## 什麼是 SuperClaude？ 🤔

SuperClaude 嘗試透過以下功能讓 Claude Code 在開發工作中更有幫助：
- 🛠️ **16 個專業指令** 用於常見的開發任務（有些效果比其他更好！）
- 🎭 **智慧角色人格** 通常能為不同領域選擇正確的專家
- 🔧 **MCP 伺服器整合** 用於文檔、UI 元件和瀏覽器自動化
- 📋 **任務管理** 嘗試追蹤進度
- ⚡ **Token 優化** 幫助進行更長的對話

這是我們為使開發工作流程更順暢而建構的。仍有些粗糙，但正在變得更好！😊

## 目前狀態 📊

✅ **運作良好的功能：**
- 安裝套件（從頭重寫）
- 包含 9 個文檔檔案的核心框架
- 用於各種開發任務的 16 個斜線指令
- MCP 伺服器整合（Context7、Sequential、Magic、Playwright）
- 統一的 CLI 安裝器，便於設定

⚠️ **已知問題：**
- 這是初始版本 - 預期會有錯誤
- 某些功能可能尚未完美運作
- 文檔仍在改進中
- Hooks 系統已被移除（將在 v4 回歸）

## 主要功能 ✨

### 指令 🛠️
我們專注於最常見任務的 16 個基本指令：

**開發**: `/sc:implement`、`/sc:build`、`/sc:design`  
**分析**: `/sc:analyze`、`/sc:troubleshoot`、`/sc:explain`  
**品質**: `/sc:improve`、`/sc:test`、`/sc:cleanup`  
**其他**: `/sc:document`、`/sc:git`、`/sc:estimate`、`/sc:task`、`/sc:index`、`/sc:load`、`/sc:spawn`

### 智慧角色人格 🎭
當它們看起來相關時嘗試介入的 AI 專家：
- 🏗️ **架構師** - 系統設計和架構相關
- 🎨 **前端** - UI/UX 和無障礙功能
- ⚙️ **後端** - API 和基礎設施
- 🔍 **分析師** - 除錯和釐清問題
- 🛡️ **安全** - 安全考量和漏洞
- ✍️ **文書** - 文檔和寫作
- *...還有 5 個其他專家*

*（它們並不總是選擇得很完美，但通常都做對了！）*

### MCP 整合 🔧
在有用時連接的外部工具：
- **Context7** - 獲取官方程式庫文檔和模式
- **Sequential** - 幫助處理複雜的多步驟思考
- **Magic** - 生成現代 UI 元件
- **Playwright** - 瀏覽器自動化和測試相關

*（當它們正確連接時運作得相當好！🤞）*

## ⚠️ 從 v2 升級？重要提醒！

如果您從 SuperClaude v2 升級，需要先清理：

1. **解除安裝 v2** 如果有可用的解除安裝程式
2. **手動清理** - 刪除這些（如果存在）：
   - `SuperClaude/`
   - `~/.claude/shared/`
   - `~/.claude/commands/` 
   - `~/.claude/CLAUDE.md`
4. **然後繼續** 下面的 v3 安裝

這是因為 v3 有不同的結構，舊檔案可能會造成衝突。

### 🔄 **v2 使用者的重要變更**
**`/build` 指令改變了！** 在 v2 中，`/build` 用於功能實作。在 v3 中：
- `/sc:build` = 僅編譯/打包
- `/sc:implement` = 功能實作（新增！）

**遷移**: 將 `v2 /build myFeature` 替換為 `v3 /sc:implement myFeature`

## 安裝 📦

SuperClaude 安裝是一個**兩步驟過程**：
1. 首先安裝 Python 套件
2. 然後執行安裝器設定 Claude Code 整合

### 步驟 1：安裝套件

**選項 A：從 PyPI（推薦）**
```bash
uv add SuperClaude
```

**選項 B：從原始碼**
```bash
git clone https://github.com/NomenAK/SuperClaude.git
cd SuperClaude
uv sync
```
### 🔧 UV / UVX 設定指南

SuperClaude v3 也支援透過 [`uv`](https://github.com/astral-sh/uv)（一個更快、更現代的 Python 套件管理器）或 `uvx` 進行跨平台使用的安裝。

### 🌀 使用 `uv` 安裝

確保已安裝 `uv`：

```bash
curl -Ls https://astral.sh/uv/install.sh | sh
```

> 或遵循來自：[https://github.com/astral-sh/uv](https://github.com/astral-sh/uv) 的說明

一旦 `uv` 可用，您可以像這樣安裝 SuperClaude：

```bash
uv venv
source .venv/bin/activate
uv pip install SuperClaude
```

### ⚡ 使用 `uvx` 安裝（跨平台 CLI）

如果您使用 `uvx`，只需執行：

```bash
uvx pip install SuperClaude
```

### ✅ 完成安裝

安裝後，繼續執行常規的安裝器步驟：

```bash
python3 -m SuperClaude install
```

或使用 bash 風格的 CLI：

```bash
SuperClaude install
```

### 🧠 注意：

* `uv` 提供更好的快取和效能。
* 相容於 Python 3.8+ 並與 SuperClaude 順暢運作。

---
**缺少 Python？** 請先安裝 Python 3.7+：
```bash
# Linux (Ubuntu/Debian)
sudo apt update && sudo apt install python3 python3-pip

# macOS  
brew install python3

# Windows
# 從 https://python.org/downloads/ 下載
```

### 步驟 2：執行安裝器

安裝套件後，執行 SuperClaude 安裝器來配置 Claude Code（您可以使用任何方法）：
### ⚠️ 重要提醒
**安裝 SuperClaude 後。**
**您可以使用 `SuperClaude commands`、`python3 -m SuperClaude commands` 或 `python3 SuperClaude commands`**
```bash
# 快速設定（建議大多數使用者使用）
python3 SuperClaude install

# 互動式選擇（選擇元件）
python3 SuperClaude install --interactive

# 最小安裝（僅核心框架）
python3 SuperClaude install --minimal

# 開發者設定（包含所有內容）
python3 SuperClaude install --profile developer

# 查看所有可用選項
python3 SuperClaude install --help
```
### 或 Python 模組化使用
```bash
# 快速設定（建議大多數使用者使用）
python3 -m SuperClaude install

# 互動式選擇（選擇元件）
python3 -m SuperClaude install --interactive

# 最小安裝（僅核心框架）
python3 -m SuperClaude install --minimal

# 開發者設定（包含所有內容）
python3 -m SuperClaude install --profile developer

# 查看所有可用選項
python3 -m SuperClaude install --help
```
### 簡單的 bash 指令使用
```bash
# 快速設定（建議大多數使用者使用）
SuperClaude install

# 互動式選擇（選擇元件）
SuperClaude install --interactive

# 最小安裝（僅核心框架）
SuperClaude install --minimal

# 開發者設定（包含所有內容）
SuperClaude install --profile developer

# 查看所有可用選項
SuperClaude install --help
```

**就是這樣！🎉** 安裝器會處理所有事情：框架檔案、MCP 伺服器和 Claude Code 配置。

## 它如何運作 🔄

SuperClaude 嘗試透過以下方式增強 Claude Code：

1. **框架檔案** - 安裝到 `~/.claude/` 的文檔，指導 Claude 如何回應
2. **斜線指令** - 用於不同開發任務的 16 個專業指令
3. **MCP 伺服器** - 添加額外功能的外部服務（當它們運作時！）
4. **智慧路由** - 嘗試根據您正在做的事情選擇正確的工具和專家

大多數時候它與 Claude Code 現有的功能配合得很好。🤝

## v4 即將推出的功能 🔮

我們希望在下一個版本中處理這些事情：
- **Hooks 系統** - 事件驅動的功能（從 v3 移除，嘗試正確地重新設計）
- **MCP 套件** - 更多外部工具整合
- **更好的效能** - 嘗試讓事情更快、更少錯誤
- **更多角色人格** - 可能再添加幾個領域專家
- **跨 CLI 支援** - 可能與其他 AI 編碼助手配合使用

*（雖然沒有承諾時間表 - 我們仍在摸索 v3！😅）*

## 配置 ⚙️

安裝後，您可以透過編輯以下檔案來自訂 SuperClaude：
- `~/.claude/settings.json` - 主要配置
- `~/.claude/*.md` - 框架行為檔案

大多數使用者可能不需要更改任何東西 - 它通常開箱即用就運作得不錯。🎛️

## 文檔 📖

想了解更多？查看我們的指南：

- 📚 [**使用者指南**](https://github.com/NomenAK/SuperClaude/blob/master/Docs/superclaude-user-guide.md) - 完整概述和入門
- 🛠️ [**指令指南**](https://github.com/NomenAK/SuperClaude/blob/master/Docs/commands-guide.md) - 解釋所有 16 個斜線指令
- 🏳️ [**旗標指南**](https://github.com/NomenAK/SuperClaude/blob/master/Docs/flags-guide.md) - 指令旗標和選項
- 🎭 [**角色人格指南**](https://github.com/NomenAK/SuperClaude/blob/master/Docs/personas-guide.md) - 了解角色人格系統
- 📦 [**安裝指南**](https://github.com/NomenAK/SuperClaude/blob/master/Docs/installation-guide.md) - 詳細的安裝說明

這些指南比此 README 有更多細節，並保持更新。

## 貢獻 🤝

我們歡迎貢獻！需要幫助的領域：
- 🐛 **錯誤報告** - 讓我們知道什麼壞了
- 📝 **文檔** - 幫助我們更好地解釋事情
- 🧪 **測試** - 為不同設定提供更多測試覆蓋
- 💡 **想法** - 新功能或改進的建議

程式碼庫是相當直接的 Python + 文檔檔案。

## 專案結構 📁

```
SuperClaude/
├── setup.py               # pypi 設定檔
├── SuperClaude/           # 框架檔案  
│   ├── Core/              # 行為文檔（COMMANDS.md、FLAGS.md 等）
│   ├── Commands/          # 16 個斜線指令定義
│   └── Settings/          # 配置檔案
├── setup/                 # 安裝系統
└── profiles/              # 安裝設定檔（快速、最小、開發者）
```

## 架構筆記 🏗️

v3 架構專注於：
- **簡潔性** - 移除沒有增加價值的複雜性
- **可靠性** - 更好的安裝和更少的破壞性變更
- **模組化** - 只選擇您想要的元件
- **效能** - 透過更智慧的快取實現更快的操作

我們從 v2 學到了很多，並嘗試解決主要的痛點。

## 常見問題 🙋

**問：為什麼移除了 hooks 系統？**  
答：它變得複雜且有錯誤。我們正在為 v4 正確地重新設計它。

**問：這適用於其他 AI 助手嗎？**  
答：目前僅限 Claude Code，但 v4 將有更廣泛的相容性。

**問：這對日常使用足夠穩定嗎？**  
答：基本功能運作得相當好，但由於這是新版本，肯定會有一些粗糙的地方。可能適合實驗！🧪

## SuperClaude 貢獻者

[![貢獻者](https://contrib.rocks/image?repo=NomenAk/SuperClaude)](https://github.com/NomenAK/SuperClaude/graphs/contributors)

## 授權

MIT - [查看 LICENSE 檔案了解詳情](https://opensource.org/licenses/MIT)

## Star 歷史

<a href="https://www.star-history.com/#NomenAK/SuperClaude&Date">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=NomenAK/SuperClaude&type=Date&theme=dark" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=NomenAK/SuperClaude&type=Date" />
   <img alt="Star 歷史圖表" src="https://api.star-history.com/svg?repos=NomenAK/SuperClaude&type=Date" />
 </picture>
</a>
---

*由厭倦了通用回應的開發者建構。希望您覺得有用！🙂*

---