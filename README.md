vim-minizinc
============

Simple vim-Bundle for syntax highlighting for minizinc and Gringo ASPs and Bule .bul files. 
Detects .mzn, .fzn, .dzn .lp and .bul files. 
The definition of the syntax for vim is taken from the official minizinc-1.6 distribution. 

## Installation

### vim-plug 

https://github.com/junegunn/vim-plug

Add the line inbetween `call plug#begin()` and `call plug#end()` in `.config/nvim/init.vim`

```
Plug 'cervedin/vim-minizinc'
```

### Vundle 

Ensure you have [Vundle](https://github.com/gmarik/Vundle.vim) installed.
Ensure your ~/.vimrc file contains the following plugin line:

```
Plugin 'cervedin/vim-minizinc'
```

To install to vim add this line: 

```
$ vim +PluginInstall +qall
```

### References

For the original highlighting sources and target languages see: 

* http://www.minizinc.org/
* http://potassco.sourceforge.net/
* https://github.com/vale1410/bule
