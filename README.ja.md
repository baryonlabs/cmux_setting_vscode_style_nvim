<h1 align="center">cmux Neovim ファイル編集セットアップ</h1>
<p align="center">cmux ユーザー向けの VSCode 風 Neovim 設定</p>

<p align="center">
  <a href="README.ko.md">한국어</a> | <a href="README.md">English</a> | 日本語 | <a href="README.zh-CN.md">简体中文</a> | <a href="README.zh-TW.md">繁體中文</a> | <a href="README.vi.md">Tiếng Việt</a>
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

<a href="https://cmux.com/">cmux</a> は、複数の AI コーディングエージェントを実行して調整するマルチエージェント型コーディングワークスペースです。

cmux でプロジェクトのファイル編集と管理を一か所で行うための Neovim 設定です。VSCode から移行しやすいように、ファイルエクスプローラー、検索、Markdown プレビュー、LSP、フォーマット、Git 表示、マウスでのウィンドウサイズ調整を重視しています。

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
cp init.lua ~/.config/nvim/cmux-base.lua
cp init.ja.lua ~/.config/nvim/init.lua
nvim
```

## 機能

<table>
<tr>
<td width="40%" valign="middle">
<h3>VSCode 風ファイルエクスプローラー</h3>
<code>Ctrl+b</code> で Neo-tree を開閉します。Neo-tree 内でも同じキーで閉じられます。
</td>
<td width="60%">
<img src="screenshots/file-explorer.png" alt="Neo-tree file explorer" width="100%" />
</td>
</tr>
<tr>
<td width="40%" valign="middle">
<h3>Markdown プレビュー</h3>
<code>Space mp</code> または右クリックメニューでブラウザ preview を開きます。ポートは <code>8755</code> 固定です。
</td>
<td width="60%">
<img src="screenshots/preview-and-file-explorer.png" alt="Markdown preview" width="100%" />
</td>
</tr>
<tr>
<td width="40%" valign="middle">
<h3>マウスでウィンドウサイズ調整</h3>
ターミナル上の Neovim で、マウスを使ってペインを選択し、分割ウィンドウのサイズを調整できます。
</td>
<td width="60%">
<img src="screenshots/mouse-window-resize.svg" alt="Mouse window resizing" width="100%" />
</td>
</tr>
</table>

Contributions are welcome. This project is released under the [MIT License](LICENSE).

## キーバインド

| 機能 | キー |
| --- | --- |
| ファイルエクスプローラー | `Ctrl+b`, `Ctrl+n`, `Space e` |
| ファイル検索 | `Space ff` |
| 全体検索 | `Space fg` |
| 保存 | `Ctrl+s`, `Space w`, `:w` |
| ウィンドウを閉じる | `Ctrl+w`, `Space q`, `:q` |
| Markdown プレビュー | `Space mp`, 右クリックメニュー |
| ヒント | ステータスライン `TIP`, `Space t` |

## テスト

```bash
tests/smoke.sh
```
