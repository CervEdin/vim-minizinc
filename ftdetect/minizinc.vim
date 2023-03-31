augroup zinc
	autocmd!
	autocmd BufNewFile,BufRead *.dzn,*.fzn,*.mzn set filetype=zinc
	autocmd BufNewFile,BufRead *.dzn,*.fzn,*.mzn setlocal commentstring=%\ %s
augroup END
