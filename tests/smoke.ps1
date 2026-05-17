# Windows PowerShell smoke test for cmux_setting_vscode_style_nvim

$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

$ROOT_DIR = Split-Path -Parent $PSScriptRoot

function Test-File {
    param([string]$Path)
    if (-not (Test-Path -Path $Path -PathType Leaf)) {
        Write-Host "not ok - missing file: $Path" -ForegroundColor Red
        exit 1
    }
    Write-Host "ok - file exists: $Path" -ForegroundColor Green
}

function Test-FileContent {
    param([string]$Path, [string]$Text)
    $content = Get-Content -Path $Path -Raw -ErrorAction SilentlyContinue
    if ($content -notmatch [regex]::Escape($Text)) {
        Write-Host "not ok - $Path does not contain: $Text" -ForegroundColor Red
        exit 1
    }
    Write-Host "ok - $path contains: $Text" -ForegroundColor Green
}

function Test-Command {
    param([string]$Cmd)
    $null = Get-Command $Cmd -ErrorAction SilentlyContinue
    if (-not $?) {
        Write-Host "not ok - missing command: $Cmd" -ForegroundColor Red
        exit 1
    }
    Write-Host "ok - command exists: $Cmd" -ForegroundColor Green
}

Write-Host "Testing prerequisites..." -ForegroundColor Cyan

Test-Command "nvim"
Test-Command "git"

Write-Host "`nTesting core files..." -ForegroundColor Cyan

$files = @(
    "README.md",
    "README.ko.md",
    "LICENSE",
    "NVIM_CORE_SETTINGS.md",
    "INSTALL_WITH_LLM.md",
    "INSTALL_WITH_MCP.md",
    "init.lua",
    "init.ko.lua",
    "init.en.lua",
    "screenshots/file-explorer.png",
    "screenshots/mouse-window-resize.svg",
    "screenshots/preview-and-file-explorer.png"
)

foreach ($file in $files) {
    Test-File "$ROOT_DIR\$file"
}

Write-Host "`nTesting README content..." -ForegroundColor Cyan

Test-FileContent "$ROOT_DIR\README.md" "Neovim File Editing Setup for cmux"
Test-FileContent "$ROOT_DIR\README.md" "https://cmux.com/"
Test-FileContent "$ROOT_DIR\README.md" "Windows PowerShell Install"
Test-FileContent "$ROOT_DIR\README.md" "%LOCALAPPDATA%"
Test-FileContent "$ROOT_DIR\README.ko.md" "cmux를 위한 Neovim 파일 편집 세팅"
Test-FileContent "$ROOT_DIR\LICENSE" "MIT License"

Write-Host "`nTesting Neovim config loading..." -ForegroundColor Cyan

nvim --headless -u "$ROOT_DIR/init.lua" "+qa" 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "ok - init.lua loads in headless Neovim" -ForegroundColor Green
} else {
    Write-Host "not ok - init.lua failed to load" -ForegroundColor Red
    exit 1
}

nvim --headless -u "$ROOT_DIR/init.lua" "$ROOT_DIR/README.md" "+qa" 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "ok - README.md opens with init.lua" -ForegroundColor Green
} else {
    Write-Host "not ok - README.md failed to open" -ForegroundColor Red
    exit 1
}

Write-Host "`nTesting markdown preview settings..." -ForegroundColor Cyan

nvim --headless -u "$ROOT_DIR/init.lua" `
    "+lua assert(vim.g.mkdp_port == '8755', 'mkdp_port'); assert(vim.g.mkdp_auto_start == 0, 'mkdp_auto_start'); assert(vim.g.mkdp_auto_close == 0, 'mkdp_auto_close')" `
    "+qa" 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "ok - markdown preview settings are fixed" -ForegroundColor Green
} else {
    Write-Host "not ok - markdown preview settings validation failed" -ForegroundColor Red
    exit 1
}

Write-Host "`nTesting custom commands..." -ForegroundColor Cyan

nvim --headless -u "$ROOT_DIR/init.lua" `
    "+lua for _, command in ipairs({ 'NvimTipsKo', 'NvimStartupStatus', 'Folder', 'Dir' }) do assert(vim.fn.exists(':' .. command) == 2, command .. ' missing') end" `
    "+qa" 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "ok - custom commands exist" -ForegroundColor Green
} else {
    Write-Host "not ok - custom commands validation failed" -ForegroundColor Red
    exit 1
}

Write-Host "`nAll Windows smoke tests passed." -ForegroundColor Green