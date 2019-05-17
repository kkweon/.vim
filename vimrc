" ==============================
" PLUGINS
" ==============================
set nocompatible              " be iMproved, required
set termguicolors
" the path to python3 is obtained through executing `:echo exepath('python3')` in vim
let g:python3_host_prog = exepath('python3')

if executable('nvim-python3')
    let g:python3_host_prog = exepath('nvim-python3')
endif

filetype off                  " required
let $SHELL = 'bash'
set shell=bash
set runtimepath+=~/.vim
set relativenumber

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

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
autocmd BufNewFile,BufRead *.gohtml setlocal filetype=html
let g:go_metalinter_enabled = 1

" Rust
Plug 'racer-rust/vim-racer'

" Scala
" For ensime, http://ensime.github.io/editors/vim/install/
Plug 'ensime/ensime-vim', { 'do': ':UpdateRemotePlugins' }
Plug 'derekwyatt/vim-scala'

Plug 'jiangmiao/auto-pairs'
Plug 'yggdroot/indentline'
Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0
Plug 'dag/vim-fish'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

Plug 'python-mode/python-mode', { 'branch': 'develop' }
let g:pymode_python = 'python3'
" Shell Format
Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }
" Thrift Support
Plug 'solarnz/thrift.vim', { 'for': 'thrift' }
Plug 'ap/vim-css-color'
" Org-mode
Plug 'jceb/vim-orgmode', { 'for': 'org' }
" Tag Bar
Plug 'majutsushi/tagbar'
" Requirement for ghcmod-vim
Plug 'shougo/vimproc.vim', {'do' : 'make'}

" Purescript
Plug 'raichoo/purescript-vim'
Plug 'frigoeu/psc-ide-vim'

" Elm Support
Plug 'elmcast/elm-vim', { 'for': 'elm' }
" elm
let g:elm_syntastic_show_warnings = 1
let g:elm_detailed_complete = 1
" ReasonML Support
Plug 'reasonml-editor/vim-reason-plus', { 'for': 'reason' }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
let g:LanguageClient_serverCommands = {
    \ 'reason': ['~/.vim/bin/reason-language-server.exe'],
    \ 'css': ['css-language-server', '--stdio'],
    \ 'haskell': ['hie-wrapper'],
    \ 'rust': ['rls'],
    \ }

" for neovim
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" for vim 8 with python
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" enable autocomplete
let g:deoplete#enable_at_startup = 1
" Snippets
Plug 'sirver/ultisnips'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" This is equivalent to <C-/>
let g:UltiSnipsExpandTrigger = '<C-y><C-y>'
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
" Sometimes, it's useful to line up text. It's nicer to have the computer do this for you
Plug 'godlygeek/tabular'
" CSS
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'less', 'scss'] }
" Emmet
Plug 'mattn/emmet-vim'
let g:user_emmet_settings = {
            \  'javascript.jsx' : {
            \      'extends' : 'jsx',
            \  },
            \  'typescript' : {
            \      'extends' : 'jsx',
            \  },
            \}
" Syntatic Checker
Plug 'w0rp/ale'
let g:ale_linters = {
            \ 'javascript': ['prettier', 'eslint'],
            \ 'typescript': ['prettier', 'tsserver']
            \}
let g:ale_fixers = {
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \ 'javascript': ['prettier', 'eslint'],
            \ 'typescript': ['prettier', 'tslint']
            \}

" Markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
let g:vim_markdown_conceal = 0
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
" Manually control using filetype_js
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx PrettierAsync
" TypeScript
Plug 'Quramy/tsuquyomi' " for auto import until LS supports it
Plug 'leafgarland/typescript-vim', { 'for': ['javascript', 'typescript'] }
Plug 'maxmellon/vim-jsx-pretty'
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
Plug 'vim-airline/vim-airline'
" Vim plugin for intensely orgasmic commenting
Plug 'scrooloose/nerdcommenter'
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Surround.vim is all about "surroundings": parentheses, brackets, quotes, XML
" tags, and more. The plugin provides mappings to easily delete, change and
" add such surroundings in pairs.
Plug 'tpope/vim-surround'

filetype plugin indent on                   " required!
call plug#end()

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
set textwidth=0    " No text wrap
" Search Related
set ignorecase " case insensitive
set smartcase  " use case if any caps used
set incsearch  " show match as search proceeds
set hlsearch   " search highlighting
" Autocompletions
set completeopt=longest,menuone,preview
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

augroup filetype_py
    au!
    au FileType python setlocal formatprg=black\ -q\ -
augroup END

augroup filetype_proto
    au!
    au FileType proto setlocal formatprg=clang-format
augroup END

augroup filetype_js
    au!
    au FileType javascript,typescript,html,htmlcheetah nnoremap <buffer> <LocalLeader>tt :call MoToggleViewFile()<cr>
augroup END

augroup filetype_java
    au!
    au FileType java setlocal equalprg=google-java-format\ -
augroup END

augroup filetype_reason
    au!
    au FileType reason setlocal equalprg=refmt
augroup END

augroup filetype_scala
    au!
    au BufWritePost *.scala :EnTypeCheck
    au FileType scala nnoremap <buffer> <leader>gd :EnDeclaration<cr>
augroup END

augroup filetype_fish
    au!
    au FileType fish setlocal foldmethod=manual
augroup END

augroup filetype_html
    au!
    autocmd FileType html,htmlcheetah setlocal formatprg=html-beautify
augroup END

augroup filetype_rust
    au!
    au FileType rust setlocal equalprg=rustfmt
augroup END

" Haskell Support
augroup filetype_haskell
    autocmd!
    "autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
    autocmd FileType haskell setlocal formatprg=stylish-haskell
    autocmd FileType haskell setlocal equalprg=hindent
augroup END

augroup filetype_markdown
    autocmd!
    autocmd FileType markdown setlocal nofoldenable
augroup END

augroup filetype_nix
    autocmd!
    autocmd BufNewFile,BufRead *.nix setlocal filetype=nix
    autocmd BufNewFile,BufRead *.nix setlocal tabstop=2
    autocmd BufNewFile,BufRead *.nix setlocal shiftwidth=2
augroup END

augroup filetype_yaml
    autocmd!
    autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 equalprg=prettier\ --parser=yaml\ --stdin
augroup END

augroup filetype_cpp
    autocmd!
    autocmd FileType cpp setlocal shiftwidth=2 tabstop=2 equalprg=clang-format
augroup END

" ==============================
" KEYBINDINGS
" ==============================
let mapleader = " "
""" CUSTOM FUNCTIONS
if has("nvim")
    nnoremap <Leader>ev :vsplit ~/.vim/vimrc<cr> :execute 'lcd ~/.vim'<cr>
    nnoremap <Leader>sv :source ~/.vim/vimrc<cr>
else
    nnoremap <Leader>ev :vsplit $MYVIMRC<cr> :execute 'lcd ' . fnamemodify($MYVIMRC, ':p:h')<cr>
    nnoremap <Leader>sv :source $MYVIMRC<cr>
end
" Close Buffer
nnoremap <Leader>bd :bd<cr>

function! s:IsNerdTreeEnabled()
    " Returns 1 if NERDTree already exists
    return exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1
endfunction
" Open NERD Tree
"
function! MoToggleNERDTree(command)
    if s:IsNerdTreeEnabled()
        NERDTreeClose
    elseif expand('%') == ''
        NERDTreeToggle
    else
        " Else execute a command
        execute a:command
    endif
endfunction

" B
nnoremap <Leader>bb :Buffers<cr>

nnoremap <Leader>ft :call MoToggleNERDTree('NERDTree %')<cr>
nnoremap <Leader>pt :call MoToggleNERDTree('NERDTree')<cr>
" Run FZF
nnoremap <Leader>pf :Files<cr>

""" YCMD Keybindings
nnoremap <Leader>gb <C-o>
nnoremap <Leader>gf :call MoEditByGitFiles(expand('<cword>'))<cr>

" LanguageServer
nnoremap <Leader>ll :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <Leader>lh :call LanguageClient#textDocument_hover()<CR>
nnoremap <Leader>lgd :call LanguageClient#textDocument_definition()<CR>
nnoremap <Leader>lb :call LanguageClient#textDocument_references()<CR>
nnoremap <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
nnoremap <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <Leader>lr :call LanguageClient#textDocument_rename()<CR>

" Delete all content in a buffer
nnoremap <Leader>be ggVGx
nnoremap <Leader>by m'gg"*yG''

" t
nnoremap <Leader>tT :TagbarToggle<cr>
command! -nargs=1 MoToggleFileByExtension :call MoToggleFileByExtension('<args>')
nnoremap <Leader>te :MoToggleFileByExtension<space>
command! MoExecute execute "read !" . getline('.')

" Terminal Keybindings
tnoremap <Esc> <C-\><C-n>
