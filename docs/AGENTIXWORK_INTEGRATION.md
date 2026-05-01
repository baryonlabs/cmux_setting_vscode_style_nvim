# AgentixWork Terminal Integration

This Neovim setup is intended to be callable from AgentixWork Terminal as an optional file editing workflow.

AgentixWork Terminal fork:

https://github.com/baryonlabs/agentixwork-terminal

## Button Contract

AgentixWork Terminal should expose a visible `Nvim` button.

When clicked:

1. Resolve the current project path from the focused terminal pane.
2. Fall back to the workspace path.
3. Fall back to `$HOME`.
4. Run `nvim` in that directory.

Expected command:

```sh
cd "$TARGET_DIR" && nvim
```

## Expected Neovim Behavior

When this setup is installed, the button-launched Neovim session should provide:

| Feature | Expected behavior |
| --- | --- |
| File explorer | `Ctrl+b`, `Ctrl+n`, `Space e` open/close Neo-tree |
| Markdown preview | `Space mp` or right-click menu opens preview on port `8755` |
| Startup status | Current folder and Git status appear on start |
| Korean command correction | `:ㅂ`, `:ㅈ`, `:ㅈㅂ` map to `:q`, `:w`, `:wq` |
| Mouse support | Pane focus and split resizing work with the mouse |

## Safety Rules

AgentixWork Terminal should not silently overwrite existing Neovim dotfiles.

If it adds an installer later, it must:

1. Detect existing `~/.config/nvim/init.lua`.
2. Show a dry-run summary.
3. Back up existing files before writing.
4. Allow users to install only the docs/instructions without changing dotfiles.

## Related Docs

- AgentixWork roadmap: https://github.com/baryonlabs/agentixwork-terminal/blob/main/docs/agentixwork-terminal-roadmap.md
- Neovim button contract: https://github.com/baryonlabs/agentixwork-terminal/blob/main/docs/neovim-button-contract.md
