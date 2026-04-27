#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

pass() {
  printf 'ok - %s\n' "$1"
}

fail() {
  printf 'not ok - %s\n' "$1" >&2
  exit 1
}

require_file() {
  local path="$1"
  [[ -f "$path" ]] || fail "missing file: $path"
  pass "file exists: $path"
}

require_text() {
  local path="$1"
  local text="$2"
  grep -Fq "$text" "$path" || fail "$path does not contain: $text"
  pass "$path contains: $text"
}

require_cmd() {
  local cmd="$1"
  command -v "$cmd" >/dev/null 2>&1 || fail "missing command: $cmd"
  pass "command exists: $cmd"
}

require_cmd nvim
require_cmd git

require_file README.md
require_file README.en.md
require_file NVIM_CORE_SETTINGS.md
require_file INSTALL_WITH_LLM.md
require_file INSTALL_WITH_MCP.md
require_file init.lua
require_file screenshots/file-explorer.svg
require_file screenshots/preview-and-file-explorer.png
require_file screenshots/startup-status.svg
require_file screenshots/tips-window.svg
require_file screenshots/command-palette.svg

require_text README.md "cmux Neovim 파일 편집/관리 세팅"
require_text README.md '<a href="README.en.md">English</a>'
require_text README.en.md "cmux Neovim File Editing Setup"
require_text README.en.md '<a href="README.md">한국어</a>'
require_text README.md "https://github.com/baryonlabs/cmux_setting_vscode_style_nvim/"
require_text README.md "클립보드 이미지 붙여넣기"
require_text README.md "VSCode처럼 파일 저장, Neovim 포커스 복귀, 외부 파일 변경 이벤트"
require_text NVIM_CORE_SETTINGS.md 'Git 상태는 `BufWritePost`, `FocusGained`, `FileChangedShellPost`에서 다시 계산합니다.'
require_text INSTALL_WITH_LLM.md "가장 쉬운 요청"
require_text INSTALL_WITH_MCP.md "가장 쉬운 요청"

nvim --headless -u "$ROOT_DIR/init.lua" '+qa'
pass "init.lua loads in headless Neovim"

nvim --headless -u "$ROOT_DIR/init.lua" README.md '+qa'
pass "README.md opens with init.lua"

nvim --headless -u "$ROOT_DIR/init.lua" README.en.md '+qa'
pass "README.en.md opens with init.lua"

nvim --headless -u "$ROOT_DIR/init.lua" \
  '+lua assert(vim.g.mkdp_port == "8755", "mkdp_port"); assert(vim.g.mkdp_auto_start == 0, "mkdp_auto_start"); assert(vim.g.mkdp_auto_close == 0, "mkdp_auto_close")' \
  '+qa'
pass "markdown preview settings are fixed"

nvim --headless -u "$ROOT_DIR/init.lua" \
  '+lua local keys = { {"<C-b>", "파일 탐색기"}, {"<C-s>", "저장"}, {"<C-w>", "현재 창 닫기"}, {"<leader>p", "명령 팔레트"}, {"<leader>t", "상황별 팁"} }; for _, item in ipairs(keys) do local m = vim.fn.maparg(item[1], "n", false, true); assert(m.desc and m.desc:find(item[2], 1, true), item[1] .. " missing " .. item[2]) end' \
  '+qa'
pass "core normal-mode mappings exist"

nvim --headless -u "$ROOT_DIR/init.lua" \
  '+lua for _, command in ipairs({ "NvimTipsKo", "NvimStartupStatus", "PasteClipboardImage", "Folder", "Dir" }) do assert(vim.fn.exists(":" .. command) == 2, command .. " missing") end' \
  '+qa'
pass "custom commands exist"

nvim --headless -u "$ROOT_DIR/init.lua" \
  '+lua local menu = vim.api.nvim_exec2("menu PopUp", { output = true }).output; assert(menu:find("상황별 팁", 1, true), "tips menu missing"); assert(menu:find("Markdown 미리보기", 1, true), "markdown menu missing"); assert(menu:find("클립보드 이미지 저장", 1, true), "image menu missing")' \
  '+qa'
pass "popup menu entries exist"

nvim --headless -u "$ROOT_DIR/init.lua" \
  '+NvimStartupStatus' \
  '+lua local m = vim.fn.maparg("r", "n", false, true); assert(m.desc == "시작 상태 새로고침", "startup refresh key missing")' \
  '+qa'
pass "startup status refresh key exists"

printf 'All smoke tests passed.\n'
