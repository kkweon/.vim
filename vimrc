
" ==============================
" PLUGINS
" ==============================
set nocompatible              " be iMproved, required
filetype off                  " required
set shell=/bin/bash

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
            \   'rg --column --line-number --no-heading --color=never --smart-case '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)
nnoremap <Leader>ps :Rg<cr>

Plug 'easymotion/vim-easymotion'
" Shell Format
Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }

" Thrift Support
Plug 'solarnz/thrift.vim', { 'for': 'thrift' }

" Org-mode
Plug 'jceb/vim-orgmode', { 'for': 'org' }

" Tag Bar
Plug 'majutsushi/tagbar'

" Requirement for ghcmod-vim
Plug 'shougo/vimproc.vim', {'do' : 'make'}
" Haskell Support
" NECO-GHC: GHC-MOD COMPLETION FOR NEOCOMPLCACHE/NEOCOMPLETE/DEOPLETE
"Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
"Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }

" Disable haskell-vim omnifunc
"let g:haskellmode_completion_ghc = 0

augroup filetype_haskell
    autocmd!
    "autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
    autocmd FileType haskell setlocal formatprg=stylish-haskell
    autocmd FileType haskell setlocal equalprg=hindent\ --style\ 'johan-tibell'
augroup END



" Elm Support
Plug 'elmcast/elm-vim', { 'for': 'elm' }
" ReasonML Support
Plug 'reasonml-editor/vim-reason-plus', { 'for': 'reason' }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" for neovim
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'parsonsmatt/intero-neovim' " intero
" for vim 8 with python
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
  " the path to python3 is obtained through executing `:echo exepath('python3')` in vim
  let g:python3_host_prog = exepath('python3')
endif

" Snippets
Plug 'sirver/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" This is equivalent to <C-/>
let g:UltiSnipsExpandTrigger = "<C-_>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit = "vertical"

" Sometimes, it's useful to line up text. It's nicer to have the computer do this for you
Plug 'godlygeek/tabular'

" CSS
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'less', 'scss'] }
" Emmet
Plug 'mattn/emmet-vim'

" Syntatic Checker
" Plug 'w0rp/ale'
Plug 'scrooloose/syntastic'

let g:ale_linters = {
            \   'javascript': ['eslint'],
            \}

" You complete me
Plug 'valloric/youcompleteme'
" manually disable Syntastic Java diagnostics.
let g:syntastic_java_checkers = []

" Markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

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
Plug 'tpope/vim-rhubarb'

" JavaScript Support
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'typescript'] }
Plug 'mxw/vim-jsx'
" Prettier
Plug 'prettier/vim-prettier'

" TypeScript
Plug 'leafgarland/typescript-vim', { 'for': ['javascript', 'typescript'] }

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

" ==============================
" PLUGINS
" ==============================
" reasonML
let s:reason_language_server_exe_path = fnamemodify('~/.vim/bin/reason-language-server.exe', ':p')
let g:LanguageClient_serverCommands = {
    \ 'reason': [s:reason_language_server_exe_path],
    \ }
" enable autocomplete
let g:deoplete#enable_at_startup = 1
" elm
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:elm_syntastic_show_warnings = 1
let g:elm_detailed_complete = 1

let g:ycm_always_populate_location_list = 1
let g:ycm_semantic_triggers = {
            \ 'elm' : ['.'],
            \ 'haskell': ['.'],
            \ }



" ==============================
" FUNCTION
" ==============================
source ~/.vim/functions.vim

" ==============================
" EDITOR
" ==============================
set nowrap         " NO WRAP
set number         " Set Line number
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent     " turns it on
set smartindent    " does the right thing (mostly) in programs
set encoding=utf-8 " utf-8 always

" Search Related
set ignorecase " case insensitive
set smartcase  " use case if any caps used
set incsearch  " show match as search proceeds
set hlsearch   " search highlighting

" ETC
syntax enable
set nobackup   " Do not create backup files
set noswapfile " Do not create swap files

" THEME
colorscheme Monokai

" ==============================
" AUTO COMMANDS
" ==============================
augroup global_whitespace_fix
    autocmd!
    autocmd BufWritePre * :FixWhitespace
    autocmd BufWritePre * :call TrimEndLines()
augroup END

augroup js_file_commands
    au!
    au FileType javascript,typescript,html,htmlcheetah nnoremap <buffer> <LocalLeader>tt :call MoToggleViewFile()<cr>
augroup END


" ==============================
" KEYBINDINGS
" ==============================
let mapleader = " "
""" CUSTOM FUNCTIONS
nnoremap <Leader>ev :vsplit $MYVIMRC<cr> :execute 'lcd ' . fnamemodify($MYVIMRC, ':p:h')<cr>
nnoremap <Leader>sv :source $MYVIMRC<cr>
" Close Buffer
nnoremap <Leader>bd :bd<cr>
" Open NERD Tree
function! MoToggleNERDTree(command)
    if expand('%') =~ 'NERD' || expand('%') == ''
        execute 'NERDTreeToggle'
    else
        execute a:command
    endif
endfunction
nnoremap <Leader>ft :call MoToggleNERDTree('NERDTree %')<cr>
nnoremap <Leader>pt :call MoToggleNERDTree('NERDTree .')<cr>
" Run FZF
nnoremap <Leader>pf :Files<cr>

""" YCMD Keybindings
nnoremap <Leader>gg :YcmCompleter GoTo<cr>
nnoremap <Leader>gd :YcmCompleter GoToDefinition<cr>
nnoremap <Leader>gb <C-o>
nnoremap <Leader>gf :call MoEditByGitFiles(expand('<cword>'))<cr>
nnoremap <Leader>ef :YcmCompleter FixIt<cr>
nnoremap <Leader>rr :YcmCompleter RefactorRename

" Delete all content in a buffer
nnoremap <Leader>be ggVGx

" Tag bar
nnoremap <Leader>tT :TagbarToggle<cr>

command! MoExecute execute "read !" . getline('.')
