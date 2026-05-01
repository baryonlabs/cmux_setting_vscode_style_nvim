<h1 align="center">Neovim File Editing Setup for cmux</h1>
<p align="center">A VSCode-style Neovim setup for cmux users, with Korean input support</p>

<p align="center">
   <a href="README.ko.md">한국어</a> | English | <a href="README.ja.md">日本語</a> | <a href="README.zh-CN.md">简体中文</a> | <a href="README.zh-TW.md">繁體中文</a> | <a href="README.vi.md">Tiếng Việt</a>
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

<a href="https://cmux.com/">cmux</a> is a multi-agent coding workspace for running and coordinating AI coding agents.

This repository contains a cmux-friendly Neovim setup for editing and managing project files in one place. It is designed for people coming from VSCode: file explorer, quick file search, project search, Markdown preview, LSP, formatting, Git indicators, mouse-friendly window resizing, and Korean input safeguards.

## Quick Install With an LLM

Give this URL to ChatGPT, Claude, Codex, or another coding agent:

```text
Read this GitHub repository and install this Neovim setup on my macOS machine.
Before applying it, summarize README.md and NVIM_CORE_SETTINGS.md.
If ~/.config/nvim/init.lua already exists, back it up first.

https://github.com/baryonlabs/cmux_setting_vscode_style_nvim/
```

For details, see:

- [INSTALL_WITH_LLM.md](INSTALL_WITH_LLM.md)
- [INSTALL_WITH_MCP.md](INSTALL_WITH_MCP.md)
- [NVIM_CORE_SETTINGS.md](NVIM_CORE_SETTINGS.md)
- [docs/AGENTIXWORK_INTEGRATION.md](docs/AGENTIXWORK_INTEGRATION.md)
- [docs/ZSH_SETTINGS.md](docs/ZSH_SETTINGS.md)

## Manual Install

```bash
git clone https://github.com/baryonlabs/cmux_setting_vscode_style_nvim.git
cd cmux_setting_vscode_style_nvim
mkdir -p ~/.config/nvim
cp init.lua ~/.config/nvim/init.lua
nvim
```

To keep the English entrypoint explicit, install it this way:

```bash
cp init.lua ~/.config/nvim/cmux-base.lua
cp init.en.lua ~/.config/nvim/init.lua
nvim
```

Optional macOS tools:

```bash
brew install macism
```

Optional zsh helpers are documented separately in [docs/ZSH_SETTINGS.md](docs/ZSH_SETTINGS.md).

## Features

<table>
<tr>
<td width="40%" valign="middle">
<h3>VSCode-style file explorer</h3>
Use <code>Ctrl+b</code> to open and close Neo-tree. It also closes from inside Neo-tree.
</td>
<td width="60%">
<img src="screenshots/file-explorer.png" alt="Neo-tree file explorer" width="100%" />
</td>
</tr>
<tr>
<td width="40%" valign="middle">
<h3>Markdown preview</h3>
Use <code>Space mp</code> or the right-click menu. Preview runs on fixed port <code>8755</code>.
</td>
<td width="60%">
<img src="screenshots/preview-and-file-explorer.png" alt="Markdown preview" width="100%" />
</td>
</tr>
<tr>
<td width="40%" valign="middle">
<h3>Mouse-friendly window resizing</h3>
Use the mouse to focus panes and resize Neovim windows in the terminal.
</td>
<td width="60%">
<img src="screenshots/mouse-window-resize.svg" alt="Mouse window resizing" width="100%" />
</td>
</tr>
</table>

Contributions are welcome. This project is released under the [MIT License](LICENSE).

## Key Bindings

| Action | Key |
| --- | --- |
| Toggle file explorer | `Ctrl+b`, `Ctrl+n`, `Space e` |
| Find files | `Space ff` |
| Search project | `Space fg` |
| Open buffers | `Space fb` |
| Save | `Ctrl+s`, `Space w`, `:w` |
| Close window | `Ctrl+w`, `Space q`, `:q` |
| Markdown preview | `Space mp`, right-click menu |
| Usage tips | statusline `TIP`, `Space t` |
| Startup status | automatic, `:NvimStartupStatus` |

## Korean Input Support

When Korean IME is active, common command typos are corrected:

| Korean input | Runs |
| --- | --- |
| `:ㅂ` | `:q` |
| `:ㅂ!` | `:q!` |
| `:ㅈ` | `:w` |
| `:ㅈㅂ` | `:wq` |

If `macism` or `im-select` is installed, the setup can switch back to the English keyboard layout when leaving Insert mode.

## Test

```bash
tests/smoke.sh
```

The smoke test checks core files, Neovim config loading, key mappings, custom commands, popup menu entries, Markdown preview settings, and startup status refresh.
