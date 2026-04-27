# LLM으로 설치하기

이 문서는 ChatGPT, Claude, Codex 같은 LLM 코딩 도구에게 이 Neovim 설정을 설치시키기 위한 가이드입니다.

## 가장 쉬운 요청

LLM에게 아래처럼 저장소 URL만 주고 설치 또는 설명을 요청하면 됩니다.

```text
아래 GitHub 저장소를 읽고 내 macOS에 이 Neovim 설정을 설치해줘.
설치 전에 README와 NVIM_CORE_SETTINGS.md를 먼저 요약해서 설명하고,
기존 ~/.config/nvim/init.lua가 있으면 백업한 뒤 적용해줘.

https://github.com/baryonlabs/cmux_setting_vscode_style_nvim/
```

설명만 듣고 싶을 때:

```text
아래 GitHub 저장소의 Neovim 설정을 초보자도 이해하기 쉽게 설명해줘.
VSCode 사용자가 어떤 단축키로 적응하면 되는지 중심으로 알려줘.

https://github.com/baryonlabs/cmux_setting_vscode_style_nvim/
```

## 직접 설치할 때

저장소를 직접 clone해서 설치하려면 다음 흐름을 사용합니다.

```sh
git clone https://github.com/baryonlabs/cmux_setting_vscode_style_nvim.git
cd cmux_setting_vscode_style_nvim
mkdir -p ~/.config/nvim
cp init.lua ~/.config/nvim/init.lua
```

언어별 진입 파일을 쓰고 싶으면 기본 설정을 `cmux-base.lua`로 두고, 선택한 언어 파일을 최종 `init.lua`로 복사합니다.

```text
한국어: init.ko.lua
English: init.en.lua
日本語: init.ja.lua
简体中文: init.zh-CN.lua
繁體中文: init.zh-TW.lua
Tiếng Việt: init.vi.lua
```

예:

```sh
cp init.lua ~/.config/nvim/cmux-base.lua
cp init.en.lua ~/.config/nvim/init.lua
```

그 다음 Neovim을 실행합니다.

```sh
nvim
```

## 전제

- 대상 OS: macOS 기준
- Neovim 설정 파일: `~/.config/nvim/init.lua`
- 설정 저장소: `https://github.com/baryonlabs/cmux_setting_vscode_style_nvim/`
- 설명 문서: `README.md`
- 핵심 설정 요약: `NVIM_CORE_SETTINGS.md`

## 상세 커스터마이징 요청문

저장소 내용을 기준으로 세부 조건까지 명확히 주고 싶으면 아래 내용을 LLM에게 전달합니다.

```text
아래 저장소를 기준으로 내 macOS에 초보자와 VSCode 사용자 친화적인 Neovim 설정을 설치해줘.

https://github.com/baryonlabs/cmux_setting_vscode_style_nvim/

요구사항:
- 실제 설정 파일은 ~/.config/nvim/init.lua 로 만든다.
- 플러그인 관리는 lazy.nvim을 사용한다.
- Space를 leader key로 사용한다.
- 파일 탐색기는 neo-tree를 사용한다.
- Ctrl+b, Ctrl+n, Space e 모두 파일 탐색기 열기/닫기로 동작해야 한다.
- Ctrl+b는 neo-tree 안에서도 닫기가 되어야 한다.
- VSCode Command Palette처럼 명령어를 찾고 실행하는 기능을 Space p와 Ctrl+Shift+P에 연결한다.
- 명령 팔레트는 Telescope commands를 사용한다.
- 파일 찾기는 Space ff, 전체 검색은 Space fg, 열린 파일 목록은 Space fb로 둔다.
- 저장은 Ctrl+s, Space w, :w 모두 가능하게 한다.
- Ctrl+s가 터미널 흐름 제어와 충돌할 수 있으므로 README에 stty -ixon 안내를 넣는다.
- LSP는 mason.nvim, mason-lspconfig.nvim, nvim-lspconfig를 사용한다.
- 자동완성은 nvim-cmp를 사용한다.
- 포맷은 conform.nvim을 사용하고 저장 시 자동 포맷한다.
- Markdown preview는 markdown-preview.nvim을 사용한다.
- Markdown preview는 자동 시작하지 않는다.
- Markdown preview 포트는 8755로 고정한다.
- 우클릭 기본 메뉴에 Markdown 미리보기 항목을 추가하고 MarkdownPreviewToggle에 연결한다.
- 클립보드 이미지를 저장할 수 있도록 pngpaste 기반 :PasteClipboardImage 명령과 Neo-tree I 단축키를 추가한다.
- Neovim 0.12.2 Markdown Treesitter range 오류를 피하기 위해 Markdown Treesitter 시작을 막는다.
- 상태바 오른쪽에 TIP을 표시하고 클릭/마우스오버 시 상황별 한글 팁 창을 연다.
- 팁 창은 q, Esc, ㅂ으로 닫히게 한다.
- Neovim 시작 직후 현재 폴더와 Git status를 보여주는 시작 상태 창을 띄운다.
- 시작 상태 창은 q, Esc, ㅂ으로 닫히고 :NvimStartupStatus로 다시 열 수 있게 한다.
- 한글 입력 상태에서 :ㅂ, :ㅈ, :ㅈㅂ 같은 명령어를 :q, :w, :wq로 보정한다.
- README.md는 영어 기본 문서로 유지하고, README.ko.md에는 VSCode와 비교, 주요 단축키, Markdown preview, 한글 사용자 팁, 상황별 사용 팁을 한국어로 설명한다.

설치 후 다음을 확인해줘:
- nvim --headless ~/.config/nvim/init.lua '+qa'
- nvim --headless README.md '+qa'
- Ctrl+b 매핑
- Space p 명령 팔레트 매핑
- Space t 매핑
- NvimTipsKo 명령
- NvimStartupStatus 명령
- Markdown preview 포트 값
```

## LLM이 작업할 파일

| 파일 | 역할 |
| --- | --- |
| `~/.config/nvim/init.lua` | 실제 Neovim 설정 |
| `README.md` | 사용자 안내 문서 |
| `NVIM_CORE_SETTINGS.md` | 핵심 설정값 요약 |

## 설치 후 확인 명령

```sh
nvim --headless ~/.config/nvim/init.lua '+qa'
nvim --headless README.md '+qa'
```

Neovim 안에서는 다음을 확인합니다.

```vim
:Lazy
:Mason
:NvimTipsKo
```

## 자주 생기는 문제

### Markdown 시작 직후 Treesitter 에러

Markdown Treesitter가 켜진 것입니다.
`NVIM_CORE_SETTINGS.md`의 `Markdown Treesitter 충돌 회피` 항목을 기준으로 다시 확인합니다.

### Markdown preview 주소가 매번 바뀜

`vim.g.mkdp_port = "8755"`가 들어갔는지 확인합니다.

### Ctrl+b가 열기만 되고 닫히지 않음

Neo-tree 내부 기본 `<C-b>` 매핑이 preview 스크롤일 수 있습니다.
Neo-tree window mapping에서도 `<C-b>`가 파일 탐색기 토글 함수로 덮어써져야 합니다.

### 한글 상태에서 `:ㅂ!`가 안 됨

command-line `<CR>` 매핑과 `korean_command_aliases`가 들어갔는지 확인합니다.
