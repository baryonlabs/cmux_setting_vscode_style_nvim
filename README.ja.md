<h1 align="center">cmux Neovim ファイル編集セットアップ</h1>
<p align="center">cmux ユーザー向けの VSCode 風 Neovim 設定</p>

<p align="center">
  <a href="README.ko.md">한국어</a> | <a href="README.md">English</a> | 日本語 | <a href="README.zh-CN.md">简体中文</a> | <a href="README.zh-TW.md">繁體中文</a> | <a href="README.vi.md">Tiếng Việt</a>
</p>

<p align="center">
  <a href="https://github.com/baryonlabs/cmux_setting_vscode_style_nvim"><img src="https://img.shields.io/badge/GitHub-baryonlabs%2Fcmux__setting__vscode__style__nvim-555?logo=github" alt="GitHub repository" /></a>
  <img src="https://img.shields.io/badge/Neovim-0.12+-57A143?logo=neovim&logoColor=white" alt="Neovim 0.12+" />
  <img src="https://img.shields.io/badge/macOS-ready-000?logo=apple" alt="macOS ready" />
</p>

<p align="center">
  <img src="screenshots/preview-and-file-explorer.png" alt="Markdown preview and Neo-tree file explorer" width="900" />
</p>

cmux でプロジェクトのファイル編集と管理を一か所で行うための Neovim 設定です。VSCode から移行しやすいように、ファイルエクスプローラー、検索、コマンドパレット、Markdown プレビュー、LSP、フォーマット、Git 表示、マウス操作を重視しています。

## LLM でインストール

```text
この GitHub リポジトリを読んで、macOS にこの Neovim 設定をインストールしてください。
適用前に README.md と NVIM_CORE_SETTINGS.md を要約し、
既存の ~/.config/nvim/init.lua があればバックアップしてください。

https://github.com/baryonlabs/cmux_setting_vscode_style_nvim/
```

## 手動インストール

```bash
git clone https://github.com/baryonlabs/cmux_setting_vscode_style_nvim.git
cd cmux_setting_vscode_style_nvim
mkdir -p ~/.config/nvim
cp init.lua ~/.config/nvim/init.lua
nvim
```

## 主な機能

| 機能 | キー |
| --- | --- |
| ファイルエクスプローラー | `Ctrl+b`, `Ctrl+n`, `Space e` |
| コマンドパレット | `Space p`, `Ctrl+Shift+P` |
| ファイル検索 | `Space ff` |
| 全体検索 | `Space fg` |
| 保存 | `Ctrl+s`, `Space w`, `:w` |
| ウィンドウを閉じる | `Ctrl+w`, `Space q`, `:q` |
| Markdown プレビュー | `Space mp`, 右クリックメニュー |
| ヒント | ステータスライン `TIP`, `Space t` |

## スクリーンショット

![Preview and file explorer](screenshots/preview-and-file-explorer.png)

## テスト

```bash
tests/smoke.sh
```

