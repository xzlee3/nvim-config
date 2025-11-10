# Neovim Configuration

Neovim config.

## Setup

Copy `init.lua` to `~/.config/nvim`.

### Dependencies

- [fzf][fzf]
- [ripgrep][ripgrep]
- [Universal Ctags](https://ctags.io/)

## LSPs

[nvim-lspconfig][nvim-lspconfig] is used to setup LSPs.

| Language | LSP                                                        |
| -------- | ---------------------------------------------------------- |
| Bash     | [BashLS](https://github.com/bash-lsp/bash-language-server) |
| Lua      | [LuaLS](https://github.com/LuaLS/lua-language-server)      |

<!-- Links -->

[fzf]: https://github.com/junegunn/fzf
[nvim-lspconfig]: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
[ripgrep]: https://github.com/BurntSushi/ripgrep
