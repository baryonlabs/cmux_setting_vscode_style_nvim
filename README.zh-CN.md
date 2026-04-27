<h1 align="center">cmux Neovim 文件编辑配置</h1>
<p align="center">面向 cmux 用户的 VSCode 风格 Neovim 配置</p>

<p align="center">
  <a href="README.ko.md">한국어</a> | <a href="README.md">English</a> | <a href="README.ja.md">日本語</a> | 简体中文 | <a href="README.zh-TW.md">繁體中文</a> | <a href="README.vi.md">Tiếng Việt</a>
</p>

<p align="center">
  <a href="https://github.com/baryonlabs/cmux_setting_vscode_style_nvim"><img src="https://img.shields.io/badge/GitHub-baryonlabs%2Fcmux__setting__vscode__style__nvim-555?logo=github" alt="GitHub repository" /></a>
  <img src="https://img.shields.io/badge/Neovim-0.12+-57A143?logo=neovim&logoColor=white" alt="Neovim 0.12+" />
  <img src="https://img.shields.io/badge/macOS-ready-000?logo=apple" alt="macOS ready" />
</p>

<p align="center">
  <img src="screenshots/preview-and-file-explorer.png" alt="Markdown preview and Neo-tree file explorer" width="900" />
</p>

这是一个面向 cmux 的 Neovim 配置，用于在同一个工具里完成文件编辑和项目管理。它针对 VSCode 用户设计，包含文件浏览器、快速搜索、命令面板、Markdown 预览、LSP、格式化、Git 状态、鼠标友好提示等功能。

## 让 LLM 安装

```text
请阅读下面的 GitHub 仓库，并在我的 macOS 上安装这个 Neovim 配置。
安装前请先总结 README.md 和 NVIM_CORE_SETTINGS.md。
如果 ~/.config/nvim/init.lua 已存在，请先备份。

https://github.com/baryonlabs/cmux_setting_vscode_style_nvim/
```

## 手动安装

```bash
git clone https://github.com/baryonlabs/cmux_setting_vscode_style_nvim.git
cd cmux_setting_vscode_style_nvim
mkdir -p ~/.config/nvim
cp init.lua ~/.config/nvim/cmux-base.lua
cp init.zh-CN.lua ~/.config/nvim/init.lua
nvim
```

## 常用快捷键

| 功能 | 快捷键 |
| --- | --- |
| 文件浏览器 | `Ctrl+b`, `Ctrl+n`, `Space e` |
| 命令面板 | `Space p`, `Ctrl+Shift+P` |
| 查找文件 | `Space ff` |
| 全局搜索 | `Space fg` |
| 保存 | `Ctrl+s`, `Space w`, `:w` |
| 关闭窗口 | `Ctrl+w`, `Space q`, `:q` |
| Markdown 预览 | `Space mp`, 右键菜单 |
| 使用提示 | 状态栏 `TIP`, `Space t` |

## 截图

![Preview and file explorer](screenshots/preview-and-file-explorer.png)

## 测试

```bash
tests/smoke.sh
```
