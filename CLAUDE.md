# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with
code in this repository.

## Overview

This is a Vim/Neovim runtime plugin providing syntax highlighting and filetype
detection for MiniZinc (Zinc). It is a standard Vim plugin following the
`ftdetect/` + `syntax/` runtime path layout — no build system, package
manager, or test suite.

The plugin also bundles syntax files for a few adjacent ASP/solver formats
(Gringo, Bule, GCNF), but MiniZinc/Zinc is the actively maintained focus.

Install via vim-plug (`Plug 'cervedin/vim-minizinc'`) or Vundle
(`Plugin 'cervedin/vim-minizinc'`) — see README.md.

## Repository layout

- `ftdetect/minizinc.vim` — maps `.mzn`/`.fzn`/`.dzn` to filetype `zinc` via
  `autocmd BufNewFile,BufRead`, and also sets `commentstring` and
  `errorformat` for that filetype.
- `syntax/zinc.vim` — defines `syn match`/`syn region`/`syn keyword` rules for
  Zinc and links them to standard highlight groups (`hi link`).

## Testing changes

There is no automated test suite. Verify syntax changes manually:

```sh
vim -u NONE -c "set rtp+=." -c "e /path/to/example.mzn" -c "syntax on"
```

Confirm highlighting looks correct and that `:echo &filetype` matches `zinc`.

## Related upstream references

When checking whether `syntax/zinc.vim`'s keyword/builtin/global-constraint
lists are current, compare against the `libminizinc` repo (the reference
MiniZinc language implementation) and `MiniZincIDE` (the official IDE, another
source for syntax highlighting conventions) if available in the working
environment.
