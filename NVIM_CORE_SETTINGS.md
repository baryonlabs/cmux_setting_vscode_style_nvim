# Neovim 핵심 설정값

이 파일은 현재 Neovim 설정에서 꼭 유지해야 하는 핵심값만 따로 정리한 문서입니다.
실제 적용 파일은 `~/.config/nvim/init.lua`입니다.

## 핵심 방향

| 방향 | 핵심 설정 |
| --- | --- |
| 파일 탐색기 강조 | `Ctrl+b`, `Ctrl+n`, `Space e`를 모두 파일 탐색기 토글로 사용 |
| 마우스 사용 강조 | `mouse=a`, 상태바 `TIP`, 우클릭 메뉴, 마우스 클릭 가능한 팁 창 |
| 한글 입력 보정 강조 | 한글 Ex 명령어를 영어 명령어로 보정 |
| VSCode 적응 | Command Palette, Explorer, Quick Open에 대응하는 단축키 제공 |

## 기본 편집 설정

| 설정 | 값 | 이유 |
| --- | --- | --- |
| `vim.g.mapleader` | `" "` | `Space`를 주요 단축키 시작 키로 사용 |
| `vim.opt.mouse` | `"a"` | 마우스 클릭, 스크롤, 메뉴 사용 |
| `vim.opt.mousemodel` | `"popup_setpos"` | 우클릭 기본 메뉴 사용 |
| `vim.opt.mousemoveevent` | `true` | 상태바 `TIP` 마우스오버 감지 |
| `vim.opt.clipboard` | `"unnamedplus"` | 시스템 클립보드와 연동 |
| `vim.opt.number` | `true` | 줄 번호 표시 |
| `vim.opt.wrap` | `false` | 긴 줄 자동 줄바꿈 방지 |
| `vim.opt.signcolumn` | `"yes"` | Git/LSP 표시 때문에 화면 밀림 방지 |
| `vim.opt.splitright` | `true` | 새 세로 창을 오른쪽에 열기 |
| `vim.opt.splitbelow` | `true` | 새 가로 창을 아래에 열기 |

## 한글 사용자 설정

| 설정 | 값 | 이유 |
| --- | --- | --- |
| `vim.opt.encoding` | `"utf-8"` | 한글 인코딩 |
| `vim.opt.fileencoding` | `"utf-8"` | 저장 파일 인코딩 |
| `vim.opt.ambiwidth` | `"single"` | 한글/특수문자 폭 문제 완화 |
| `vim.opt.iminsert` | `0` | 시작 입력기를 영문 기준으로 유지 |
| `vim.opt.imsearch` | `-1` | 검색 입력기 동작을 입력 모드와 맞춤 |

## VSCode 사용자용 핵심 키

| 기능 | 단축키 |
| --- | --- |
| 파일 탐색기 열기/닫기 | `Ctrl+b`, `Ctrl+n`, `Space e` |
| 명령 팔레트 | `Space p`, `Ctrl+Shift+P` |
| 파일 찾기 | `Space ff` |
| 프로젝트 전체 검색 | `Space fg` |
| 열린 파일 목록 | `Space fb` |
| 저장 | `Ctrl+s`, `Space w` |
| 닫기 | `Ctrl+w`, `Space q` |
| 상황별 팁 | 상태바 `TIP`, `Space t` |
| 한글 도움말 | `Space ?` |
| 시작 상태 | 자동 표시, `:NvimStartupStatus` |

## Markdown 미리보기

| 설정 | 값 | 이유 |
| --- | --- | --- |
| `vim.g.mkdp_auto_start` | `0` | Markdown 열 때 브라우저가 바로 뜨지 않게 함 |
| `vim.g.mkdp_auto_close` | `0` | 버퍼 이동 시 preview 서버가 바로 죽지 않게 함 |
| `vim.g.mkdp_refresh_slow` | `0` | 수정 내용을 빠르게 반영 |
| `vim.g.mkdp_port` | `"8755"` | preview 주소를 고정 |
| `vim.g.mkdp_echo_preview_url` | `1` | 열린 preview URL 확인 |

Markdown preview는 두 방식으로 엽니다.

- `Space mp`
- 우클릭 메뉴 `Markdown 미리보기`

## 예정 기능

클립보드 이미지 저장은 아직 테스트가 충분하지 않아 핵심 설정값에서 제외합니다.
검증 후 별도 PR/변경으로 문서화합니다.

## Markdown Treesitter 충돌 회피

Neovim 0.12.2의 기본 Markdown ftplugin은 Markdown 파일을 열 때 `vim.treesitter.start()`를 자동 실행합니다.
현재 환경에서는 이 동작이 `attempt to call method 'range'` 오류를 만들 수 있어 Markdown만 예외 처리합니다.

유지해야 할 원칙:

- Markdown과 `markdown_inline`은 Treesitter 하이라이트를 끕니다.
- Lua, Python, JavaScript, TypeScript 등 코드 파일의 Treesitter는 유지합니다.
- Markdown은 일반 syntax 하이라이트로 fallback합니다.

## 한글 명령어 보정

한글 입력 상태에서 실수로 입력한 명령어를 자동 보정합니다.

| 입력 | 실행 |
| --- | --- |
| `:ㅂ` | `:q` |
| `:ㅂ!` | `:q!` |
| `:ㅈ` | `:w` |
| `:ㅈㅂ` | `:wq` |
| `:ㄹㅐㅣㅇㄷㄱ` | `:Folder` |
| `:ㅇㅑㄱ` | `:Dir` |

## 상태바 TIP

상태바 오른쪽에 `TIP`을 표시합니다.

- `TIP` 클릭: 상황별 팁 열기
- `TIP` 위에 마우스 올리기: 상황별 팁 열기
- 팁 창 닫기: `q`, `Esc`, `ㅂ`

터미널에 따라 마우스오버 이벤트가 다를 수 있으므로 가장 안정적인 방법은 `TIP` 클릭 또는 `Space t`입니다.

## 시작 상태 창

Neovim 시작 직후 현재 폴더와 Git 상태를 표시합니다.

| 표시 | 내용 |
| --- | --- |
| 현재 폴더 | `vim.fn.getcwd()` |
| Git branch | `git branch --show-current` |
| Git status | `git status --short` |

Git 저장소가 아니면 `Git: 저장소 아님`으로 표시합니다.
Git 상태는 `BufWritePost`, `FocusGained`, `FileChangedShellPost`에서 다시 계산합니다.
시작 상태 창은 `q`, `Esc`, `ㅂ`으로 닫고 `r`로 새로고침합니다.
다시 보려면 `:NvimStartupStatus`를 실행합니다.

## 터미널 Ctrl+s 주의

`Ctrl+s`는 저장으로 매핑되어 있습니다.
다만 일부 터미널은 `Ctrl+s`를 화면 출력 정지(XOFF)로 먼저 처리할 수 있습니다.
이 보정은 필수 설정이 아니므로 `docs/ZSH_SETTINGS.md`에 선택 설정으로 따로 정리합니다.
