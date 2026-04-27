<h1 align="center">cmux Neovim 檔案編輯設定</h1>
<p align="center">給 cmux 使用者的 VSCode 風格 Neovim 設定</p>

<p align="center">
  <a href="README.ko.md">한국어</a> | <a href="README.md">English</a> | <a href="README.ja.md">日本語</a> | <a href="README.zh-CN.md">简体中文</a> | 繁體中文 | <a href="README.vi.md">Tiếng Việt</a>
</p>

<p align="center">
  <a href="https://github.com/baryonlabs/cmux_setting_vscode_style_nvim"><img src="https://img.shields.io/badge/GitHub-baryonlabs%2Fcmux__setting__vscode__style__nvim-555?logo=github" alt="GitHub repository" /></a>
  <img src="https://img.shields.io/badge/Neovim-0.12+-57A143?logo=neovim&logoColor=white" alt="Neovim 0.12+" />
  <img src="https://img.shields.io/badge/macOS-ready-000?logo=apple" alt="macOS ready" />
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="MIT License" /></a>
</p>

<p align="center">
  <img src="screenshots/preview-and-file-explorer.png" alt="Markdown preview and Neo-tree file explorer" width="900" />
</p>

<a href="https://cmux.com/">cmux</a> 是用來執行並協調多個 AI 程式碼代理的多代理編碼工作區。

這是一套為 cmux 工作流程準備的 Neovim 設定，讓檔案編輯與專案管理可以集中在同一個工具中完成。它偏向 VSCode 使用者的習慣，包含檔案總管、快速搜尋、Markdown 預覽、LSP、格式化、Git 狀態與滑鼠調整視窗大小。

## 交給 LLM 安裝

```text
請閱讀下面的 GitHub 儲存庫，並在我的 macOS 上安裝這套 Neovim 設定。
套用前請先摘要 README.md 與 NVIM_CORE_SETTINGS.md。
如果 ~/.config/nvim/init.lua 已存在，請先備份。

https://github.com/baryonlabs/cmux_setting_vscode_style_nvim/
```

## 手動安裝

```bash
git clone https://github.com/baryonlabs/cmux_setting_vscode_style_nvim.git
cd cmux_setting_vscode_style_nvim
mkdir -p ~/.config/nvim
cp init.lua ~/.config/nvim/cmux-base.lua
cp init.zh-TW.lua ~/.config/nvim/init.lua
nvim
```

## 功能

<table>
<tr>
<td width="40%" valign="middle">
<h3>VSCode 風格檔案總管</h3>
使用 <code>Ctrl+b</code> 開啟與關閉 Neo-tree。在 Neo-tree 裡也能用同一個鍵關閉。
</td>
<td width="60%">
<img src="screenshots/file-explorer.png" alt="Neo-tree file explorer" width="100%" />
</td>
</tr>
<tr>
<td width="40%" valign="middle">
<h3>Markdown 預覽</h3>
使用 <code>Space mp</code> 或右鍵選單開啟瀏覽器預覽。預覽連接埠固定為 <code>8755</code>。
</td>
<td width="60%">
<img src="screenshots/preview-and-file-explorer.png" alt="Markdown preview" width="100%" />
</td>
</tr>
<tr>
<td width="40%" valign="middle">
<h3>用滑鼠調整視窗大小</h3>
在終端機 Neovim 中可以用滑鼠選擇窗格，並調整分割視窗大小。
</td>
<td width="60%">
<img src="screenshots/mouse-window-resize.svg" alt="Mouse window resizing" width="100%" />
</td>
</tr>
</table>

歡迎貢獻。本專案以 [MIT License](LICENSE) 發布。

## 常用快捷鍵

| 功能 | 快捷鍵 |
| --- | --- |
| 檔案總管 | `Ctrl+b`, `Ctrl+n`, `Space e` |
| 搜尋檔案 | `Space ff` |
| 全域搜尋 | `Space fg` |
| 儲存 | `Ctrl+s`, `Space w`, `:w` |
| 關閉視窗 | `Ctrl+w`, `Space q`, `:q` |
| Markdown 預覽 | `Space mp`, 右鍵選單 |
| 使用提示 | 狀態列 `TIP`, `Space t` |

## 測試

```bash
tests/smoke.sh
```
