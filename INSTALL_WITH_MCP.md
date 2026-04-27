# MCP로 설치하기

이 문서는 MCP(Model Context Protocol)를 사용할 수 있는 에이전트가 파일 시스템 도구로 이 Neovim 설정을 설치할 때 따르는 절차입니다.

## 가장 쉬운 요청

MCP 파일 시스템 도구를 가진 에이전트에게 아래처럼 저장소 URL만 주고 설치를 요청하면 됩니다.

```text
아래 GitHub 저장소를 읽고 README.md와 NVIM_CORE_SETTINGS.md를 기준으로
내 ~/.config/nvim/init.lua에 Neovim 설정을 설치해줘.

기존 ~/.config/nvim/init.lua가 있으면 먼저 백업하고,
설치 후 headless Neovim 검증까지 실행해줘.

https://github.com/baryonlabs/cmux_setting_vscode_style_nvim/
```

설명만 원할 때:

```text
아래 GitHub 저장소를 읽고 MCP로 설치할 때 어떤 파일을 어디에 쓰는지 설명해줘.

https://github.com/baryonlabs/cmux_setting_vscode_style_nvim/
```

## 직접 clone해서 MCP로 적용할 때

```sh
git clone https://github.com/baryonlabs/cmux_setting_vscode_style_nvim.git
cd cmux_setting_vscode_style_nvim
```

그 뒤 MCP 에이전트에게 현재 폴더의 문서를 읽고 `init.lua`를 `~/.config/nvim/init.lua`로 적용하라고 요청합니다.

언어별 진입 파일도 있습니다.

```text
init.ko.lua
init.en.lua
init.ja.lua
init.zh-CN.lua
init.zh-TW.lua
init.vi.lua
```

실제 설정은 `init.lua`를 기준으로 유지하고, 언어별 파일은 선택 언어를 표시한 뒤 `init.lua`를 불러오는 wrapper입니다.

## 목표

MCP 에이전트가 다음 파일을 만들거나 갱신합니다.

| 파일 | 설명 |
| --- | --- |
| `~/.config/nvim/init.lua` | 실제 Neovim 설정 |
| `README.md` | English 안내 |
| `README.ko.md` | 한국어 안내 |
| `NVIM_CORE_SETTINGS.md` | 핵심 설정값 요약 |
| `INSTALL_WITH_LLM.md` | LLM 설치 가이드 |
| `INSTALL_WITH_MCP.md` | MCP 설치 가이드 |

## MCP 에이전트 작업 순서

1. 현재 폴더의 `README.md`와 `NVIM_CORE_SETTINGS.md`를 읽습니다.
2. `~/.config/nvim/init.lua`가 있으면 기존 내용을 백업하거나 변경점을 확인합니다.
3. `~/.config/nvim/init.lua`에 lazy.nvim 기반 설정을 적용합니다.
4. Markdown Treesitter 충돌 회피 설정을 반드시 포함합니다.
5. Markdown preview 포트를 `8755`로 고정합니다.
6. VSCode Command Palette 대응으로 `Space p`와 `Ctrl+Shift+P`를 `Telescope commands`에 연결합니다.
7. 상태바 `TIP`과 `NvimTipsKo` 명령을 추가합니다.
8. 시작 직후 현재 폴더와 Git status를 보여주는 `NvimStartupStatus` 창을 추가합니다.
9. 한글 명령어 보정 테이블을 추가합니다.
10. headless Neovim으로 설정 로드를 검증합니다.
11. README에 실제 적용된 단축키와 동작을 반영합니다.

## MCP 에이전트에게 줄 요청문

```text
MCP filesystem 도구를 사용해서 아래 저장소 또는 현재 clone된 폴더의 Neovim 설정 문서를 읽고,
~/.config/nvim/init.lua에 설정을 적용해줘.

https://github.com/baryonlabs/cmux_setting_vscode_style_nvim/

반드시 지킬 것:
- 기존 사용자 변경사항을 함부로 삭제하지 말 것.
- 적용 전후 변경 파일 목록을 보고할 것.
- Markdown preview 포트는 8755로 고정할 것.
- Markdown preview는 자동 시작하지 말 것.
- 우클릭 기본 메뉴에 Markdown 미리보기 항목을 추가하고 MarkdownPreviewToggle에 연결할 것.
- 클립보드 이미지를 저장할 수 있도록 `pngpaste`, `:PasteClipboardImage`, Neo-tree `I` 단축키를 문서화할 것.
- 상태바 오른쪽에 TIP을 표시하고 클릭/hover로 상황별 팁 창을 열 것.
- Space p와 Ctrl+Shift+P로 Telescope commands 명령 팔레트를 열 것.
- 시작 직후 현재 폴더와 Git status가 보이게 할 것.
- `:NvimStartupStatus`로 시작 상태 창을 다시 열 수 있게 할 것.
- Ctrl+s, Space w, :w를 저장으로 사용할 수 있게 할 것.
- Ctrl+s가 터미널 흐름 제어와 충돌할 수 있으므로 README에 `stty -ixon` 안내를 넣을 것.
- 팁 창은 q, Esc, ㅂ으로 닫을 것.
- 우클릭 기본 메뉴는 없애지 말고 PopUp 메뉴에 상황별 팁 항목만 추가할 것.
- Neovim 0.12.2 Markdown Treesitter range 오류를 막을 것.
- README.md와 NVIM_CORE_SETTINGS.md를 실제 설정과 맞게 갱신할 것.

검증:
- nvim --headless ~/.config/nvim/init.lua '+qa'
- nvim --headless README.md '+qa'
- :NvimTipsKo 명령 등록 확인
- <MouseMove> 매핑 확인
- markdown-preview 포트 확인
```

## MCP 파일 작업 체크리스트

| 체크 | 내용 |
| --- | --- |
| [ ] | `~/.config/nvim/init.lua` 존재 확인 |
| [ ] | lazy.nvim bootstrap 확인 |
| [ ] | 기본 옵션 확인 |
| [ ] | 파일 탐색기 토글 함수 확인 |
| [ ] | Neo-tree 내부 `<C-b>` 덮어쓰기 확인 |
| [ ] | 명령 팔레트 `Space p` 확인 |
| [ ] | 저장 키 `Ctrl+s` 확인 |
| [ ] | Markdown preview `mkdp_port = "8755"` 확인 |
| [ ] | Markdown preview `mkdp_auto_start = 0` 확인 |
| [ ] | 우클릭 메뉴 `Markdown 미리보기` 확인 |
| [ ] | 클립보드 이미지 저장 `:PasteClipboardImage` 확인 |
| [ ] | Neo-tree 이미지 저장 키 `I` 확인 |
| [ ] | Markdown Treesitter start guard 확인 |
| [ ] | 상태바 `TIP` 표시 확인 |
| [ ] | `NvimTipsKo` 명령 확인 |
| [ ] | `NvimStartupStatus` 명령 확인 |
| [ ] | 시작 상태 창에 현재 폴더와 Git status 표시 확인 |
| [ ] | 팁 창 닫기 키 `q`, `Esc`, `ㅂ` 확인 |
| [ ] | 한글 Ex 명령어 보정 확인 |
| [ ] | README 갱신 확인 |

## 검증 명령

```sh
nvim --headless ~/.config/nvim/init.lua '+qa'
nvim --headless README.md '+qa'
nvim --headless '+verbose command NvimTipsKo' '+qa'
nvim --headless '+verbose command NvimStartupStatus' '+qa'
nvim --headless '+verbose nmap <leader>p' '+qa'
nvim --headless '+verbose nmap <MouseMove>' '+qa'
```

Markdown preview 값 확인:

```sh
nvim --headless README.md '+lua print(vim.g.mkdp_port, vim.g.mkdp_auto_start, vim.g.mkdp_auto_close)' '+qa'
```

기대값:

```text
8755 0 0
```

## 설치 후 사용자 안내

사용자에게 최소한 아래 내용은 알려줍니다.

```text
파일 탐색기: Ctrl+b
명령 팔레트: Space p
파일 찾기: Space ff
저장: Ctrl+s 또는 Space w
전체 검색: Space fg
상황별 팁: 상태바 TIP 또는 Space t
시작 상태: 시작 시 자동 표시, :NvimStartupStatus
Markdown preview: Space mp
플러그인 상태: :Lazy
언어 도구 상태: :Mason
```
