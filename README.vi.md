<h1 align="center">Thiết lập Neovim cho chỉnh sửa tệp trong cmux</h1>
<p align="center">Cấu hình Neovim kiểu VSCode dành cho người dùng cmux</p>

<p align="center">
  <a href="README.ko.md">한국어</a> | <a href="README.md">English</a> | <a href="README.ja.md">日本語</a> | <a href="README.zh-CN.md">简体中文</a> | <a href="README.zh-TW.md">繁體中文</a> | Tiếng Việt
</p>

<p align="center">
  <a href="https://github.com/baryonlabs/cmux_setting_vscode_style_nvim"><img src="https://img.shields.io/badge/GitHub-baryonlabs%2Fcmux__setting__vscode__style__nvim-555?logo=github" alt="GitHub repository" /></a>
  <img src="https://img.shields.io/badge/Neovim-0.12+-57A143?logo=neovim&logoColor=white" alt="Neovim 0.12+" />
  <img src="https://img.shields.io/badge/macOS-ready-000?logo=apple" alt="macOS ready" />
</p>

<p align="center">
  <img src="screenshots/preview-and-file-explorer.png" alt="Markdown preview and Neo-tree file explorer" width="900" />
</p>

Đây là cấu hình Neovim thân thiện với cmux để chỉnh sửa và quản lý tệp trong cùng một nơi. Nó được thiết kế cho người quen dùng VSCode: trình duyệt tệp, tìm tệp nhanh, tìm kiếm toàn dự án, command palette, xem trước Markdown, LSP, format, trạng thái Git và gợi ý dùng chuột.

## Cài đặt bằng LLM

```text
Hãy đọc repository GitHub sau và cài đặt cấu hình Neovim này trên macOS của tôi.
Trước khi áp dụng, hãy tóm tắt README.md và NVIM_CORE_SETTINGS.md.
Nếu ~/.config/nvim/init.lua đã tồn tại, hãy sao lưu trước.

https://github.com/baryonlabs/cmux_setting_vscode_style_nvim/
```

## Cài đặt thủ công

```bash
git clone https://github.com/baryonlabs/cmux_setting_vscode_style_nvim.git
cd cmux_setting_vscode_style_nvim
mkdir -p ~/.config/nvim
cp init.lua ~/.config/nvim/cmux-base.lua
cp init.vi.lua ~/.config/nvim/init.lua
nvim
```

## Phím tắt chính

| Hành động | Phím |
| --- | --- |
| File explorer | `Ctrl+b`, `Ctrl+n`, `Space e` |
| Command palette | `Space p`, `Ctrl+Shift+P` |
| Tìm tệp | `Space ff` |
| Tìm toàn dự án | `Space fg` |
| Lưu | `Ctrl+s`, `Space w`, `:w` |
| Đóng cửa sổ | `Ctrl+w`, `Space q`, `:q` |
| Xem trước Markdown | `Space mp`, menu chuột phải |
| Gợi ý sử dụng | statusline `TIP`, `Space t` |

## Ảnh chụp

![Preview and file explorer](screenshots/preview-and-file-explorer.png)

## Kiểm thử

```bash
tests/smoke.sh
```
