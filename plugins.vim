" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Sometimes, it's useful to line up text. It's nicer to have the computer do this for you
Plugin 'godlygeek/tabular'

" You complete me
Plugin 'valloric/youcompleteme'

" Markdown
Plugin 'plasticboy/vim-markdown'

" Trailing Whitespace
Plugin 'bronson/vim-trailing-whitespace'

" Multi Cursor
Plugin 'terryma/vim-multiple-cursors'
let g:multi_cursor_select_all_word_key = '<C-S-n>'

" FZF
" If installed using git
set rtp+=~/.fzf
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'

" JavaScript Support
Plugin 'pangloss/vim-javascript'

" Prettier
Plugin 'prettier/vim-prettier'

" TypeScript
Plugin 'leafgarland/typescript-vim'

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
" Color Scheme
Plugin 'flazz/vim-colorschemes' " nerd tree
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
" Perform all your vim insert mode completions with Tab
Plugin 'ervandew/supertab'
" Vim plugin for intensely orgasmic commenting
Plugin 'scrooloose/nerdcommenter'

" Surround.vim is all about "surroundings": parentheses, brackets, quotes, XML
" tags, and more. The plugin provides mappings to easily delete, change and
" add such surroundings in pairs.
Plugin 'tpope/vim-surround'



" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
