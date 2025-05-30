<div align="center">
  <h1>slivers.nvim</h1>
  <h3>🌸 ~ My Neovim config  ~ 🌸</h3>
</div>

----------

- [Screenshots](#screenshots)
- [Features](#features)
- [Dependencies](#dependencies)
- [Credits](#credits)
- [Roadmap](#roadmap)

## Screenshots

![screenshot](https://github.com/joaoinez/personal-website/blob/main/assets/slivers-nvim.png)

## Features

- ⚡ **Lazy:** Plugins are loaded lazily, thanks to [lazy.nvim](https://github.com/folke/lazy.nvim).
- 🤖 **IDE tools:** [Compiler.nvim](https://github.com/Zeioth/compiler.nvim) (compiler) and [DAP](https://github.com/mfussenegger/nvim-dap) (debugger)
- 🐞 **IDE parsers:** Linters, Formatters, LSP and Treesitter
- 🧰 Git workflow: [Lazygit](https://github.com/kdheepak/lazygit.nvim) integration plus [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- 🧠 AI companion: Somewhat helpful sometimes, courtesy of [avante.nvim](https://github.com/yetone/avante.nvim) and [ollama](https://github.com/ollama/ollama)
- ✨ **Fully modular:** Every feature is a small plugin.

## Dependencies

- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- Fuzzy finding:
  - [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
  - [fd](https://github.com/sharkdp/fd)
  - [fzf](https://github.com/junegunn/fzf)
- [fzf-lua](https://github.com/ibhagwan/fzf-lua) previewer:
  - [delta](https://github.com/dandavison/delta)
  - [chafa](https://github.com/hpjansson/chafa)
- Git stuff:
  - [lazygit](https://github.com/jesseduffield/lazygit)
  - [github-cli](https://github.com/cli/cli#installation)
- Local AI:
  - [ollama](https://ollama.com/download/linux)
  - [qwen2.5-coder](https://ollama.com/library/qwen2.5-coder)
  - [deepseek-r1](https://ollama.com/library/deepseek-r1)

> [!NOTE]
> If running into errors run `:checkhealth slivers`

## Credits

Originally started as a [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) configuration and slowly started changing plugins, options and structure.
I'm unimaginably thankful for [NormalNvim](https://github.com/NormalNvim/NormalNvim)'s excellent codebase and helpful comments.
Equal thanks go to [LazyVim](https://github.com/LazyVim/LazyVim)'s website and codebase, both of which are great for discovery.
Also credit to [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) for their color lib and diagnostics tinting.

Special thanks to ThePrimeagen and TJ DeVries for making my move to Neovim feasible.

Hopefully one day I can contribute to this incredible tool.

## Roadmap

- [ ] Adding [Neotest](https://github.com/nvim-neotest/neotest) to handle testing
- [ ] Writing more comments throught the code
- [ ] Making some functionality more modular by better checking for any other plugins its using
- [ ] Adding Hyprland lang support
