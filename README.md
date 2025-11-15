# Neovim Configuration

Neovim config.

## Setup

Copy `init.lua` to `~/.config/nvim`.

### Dependencies

- [fzf][fzf]
- [ripgrep][ripgrep]
- [Universal Ctags][ctags]

## LSPs

[nvim-lspconfig][nvim-lspconfig] is used to setup LSPs.

| Language | LSP                                        |
| -------- | ------------------------------------------ |
| Bash     | [BashLS][BashLS]                           |
| Lua      | [LuaLS][LuaLS]                             |
| Python   | [basedpyright][basedpyright], [ruff][ruff] |

<!-- Links -->

[basedpyright]: https://docs.basedpyright.com/latest/
[BashLS]: https://github.com/bash-lsp/bash-language-server
[fzf]: https://github.com/junegunn/fzf
[LuaLS]: https://github.com/LuaLS/lua-language-server
[nvim-lspconfig]: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
[ripgrep]: https://github.com/BurntSushi/ripgrep
[ruff]: https://docs.astral.sh/ruff/
[ctags]: https://ctags.io/
