if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Use ripgrep instead of ag
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)
nnoremap <Leader>ps :Rg<cr>

" Snippets
Plug 'sirver/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger = "<C-_>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit = "vertical"

" Sometimes, it's useful to line up text. It's nicer to have the computer do this for you
Plug 'godlygeek/tabular'

" CSS
Plug 'hail2u/vim-css3-syntax'
" Emmet
Plug 'mattn/emmet-vim'

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
if !has('gui_running')
    map ˜ <A-n>
endif

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

" git repos on your local machine (i.e. when working on your own plugin)
" Plug 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plug 'ascenator/L9', {'name': 'newL9'}
" Color Scheme
Plug 'flazz/vim-colorschemes'
" nerd tree
Plug 'scrooloose/nerdtree'
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
