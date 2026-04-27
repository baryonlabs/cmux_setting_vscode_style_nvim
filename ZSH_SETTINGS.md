# zsh settings for cmux

This repository includes `zshrc.cmux`, an optional shell setup for people who use Neovim, cmux, Claude, Codex, and other AI coding tools from the terminal.

## What it adds

| Feature | Behavior |
| --- | --- |
| Ctrl+s support | Runs `stty -ixon` so terminal Neovim can receive `Ctrl+s` for save. |
| Better history | Keeps a larger shared zsh history across terminal tabs. |
| Prefix history search | Type `claude`, press Up/Down, and move through previous `claude --...` commands. |
| Substring history search | Uses `zsh-history-substring-search` when installed. |
| Autosuggestions | Uses `zsh-autosuggestions` when installed. |
| Syntax highlighting | Uses `zsh-syntax-highlighting` when installed. |

## Install

```sh
git clone https://github.com/baryonlabs/cmux_setting_vscode_style_nvim.git
cd cmux_setting_vscode_style_nvim
```

Add this line to `~/.zshrc`:

```sh
source "$HOME/dev/cmux_setting_vscode_style_nvim/zshrc.cmux"
```

Use the actual clone path if the repository is not under `$HOME/dev`.

Reload zsh:

```sh
source ~/.zshrc
```

## Recommended plugins

On macOS with Homebrew:

```sh
brew install zsh-history-substring-search zsh-autosuggestions zsh-syntax-highlighting
```

Then reload:

```sh
source ~/.zshrc
```

`zshrc.cmux` works without these plugins, but `zsh-history-substring-search` gives the best behavior for commands like:

```sh
claude --dangerously-skip-permissions
claude --model sonnet
claude --continue
```

Type `claude`, press Up, and zsh will show matching previous commands instead of unrelated history.

## 한국어 요약

`zshrc.cmux`는 터미널에서 cmux, Neovim, Claude, Codex를 함께 쓸 때 편하게 쓰기 위한 zsh 설정입니다.

가장 중요한 기능은 `claude`라고 입력한 뒤 위/아래 방향키를 누르면 예전에 실행했던 `claude --...` 명령만 찾아서 보여주는 것입니다.

설치:

```sh
brew install zsh-history-substring-search zsh-autosuggestions zsh-syntax-highlighting
```

`~/.zshrc`에 추가:

```sh
source "$HOME/dev/cmux_setting_vscode_style_nvim/zshrc.cmux"
```

그 뒤:

```sh
source ~/.zshrc
```
