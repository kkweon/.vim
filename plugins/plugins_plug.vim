if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Sometimes, it's useful to line up text. It's nicer to have the computer do this for you
Plug 'godlygeek/tabular'

" Syntatic Checker
Plug 'scrooloose/syntastic'

" You complete me
Plug 'valloric/youcompleteme'
" manually disable Syntastic Java diagnostics.
let g:syntastic_java_checkers = []

" Markdown
Plug 'plasticboy/vim-markdown'

" Trailing Whitespace
Plug 'bronson/vim-trailing-whitespace'

" Multi Cursor
Plug 'terryma/vim-multiple-cursors'

" FZF
" If installed using git
set rtp+=~/.fzf
" The following are examples of different formats supported.
" Keep Plug commands between vundle#begin/end.
" plugin on GitHub repo
Plug 'tpope/vim-fugitive'

" JavaScript Support
Plug 'pangloss/vim-javascript'

" Prettier
Plug 'prettier/vim-prettier'

" TypeScript
Plug 'leafgarland/typescript-vim'

" plugin from http://vim-scripts.org/vim/scripts.html
" Plug 'L9'
" Git plugin not hosted on GitHub
Plug 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plug 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plug 'ascenator/L9', {'name': 'newL9'}
" Color Scheme
Plug 'flazz/vim-colorschemes' " nerd tree
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'bling/vim-airline'
" Perform all your vim insert mode completions with Tab
Plug 'ervandew/supertab'
" Vim plugin for intensely orgasmic commenting
Plug 'scrooloose/nerdcommenter'

" Surround.vim is all about "surroundings": parentheses, brackets, quotes, XML
" tags, and more. The plugin provides mappings to easily delete, change and
" add such surroundings in pairs.
Plug 'tpope/vim-surround'

filetype plugin indent on                   " required!
call plug#end()
