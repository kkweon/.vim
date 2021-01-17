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
let mapleader = ' '
let localleader = ','

" Plug {{{
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kkweon/vim-convert-case'
" Use ripgrep instead of ag
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=never --smart-case '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)
nnoremap <Leader>ps :Rg<cr>

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" Coc Settings BEGIN
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nmap <leader>rn <Plug>(coc-rename)
" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Coc Settings END
Plug 'junegunn/vader.vim'
Plug 'google/vim-maktaba'
Plug 'bazelbuild/vim-bazel'
Plug 'dart-lang/dart-vim-plugin'
let g:dart_style_guide = 2
let g:dart_format_on_save = 1
Plug 'Shougo/denite.nvim'
if executable('go')
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
endif
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
Plug 'liuchengxu/vim-which-key'
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
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
            \  'typescript.tsx' : {
            \      'extends' : 'jsx',
            \  },
            \}
" Syntatic Checker
Plug 'w0rp/ale'
let g:ale_linters = {
            \ 'javascript': ['prettier', 'eslint'],
            \ 'typescript': ['prettier', 'tsserver'],
            \}
let g:ale_fixers = {
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \ 'javascript': ['prettier', 'eslint'],
            \ 'typescript': ['prettier', 'tslint'],
            \}

" Markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
let g:vim_markdown_conceal = 0
" Trailing Whitespace
Plug 'bronson/vim-trailing-whitespace'
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
"}}}
" Loading functions.{{{
source ~/.vim/functions.vim

if &rtp=~'vader'
    command! VaderCurrent source % <BAR> Vader %:p:r.vader
endif
"}}}
" EDITOR 'set's{{{
set nowrap         " NO WRAP
set relativenumber " Set Line number
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent     " turns it on
set smartindent    " does the right thing (mostly) in programs
set encoding=utf-8 " utf-8 always
set textwidth=0    " No text wrap
set wildignorecase " Ignore case in wildmenu
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

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
"}}}
" AUTO COMMANDS{{{
"
" Define mappings
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction
" filetype begins{{{
augroup filetype_custom
    autocmd!
    autocmd FileType denite call s:denite_my_settings()
    autocmd BufNewFile,BufRead *.gohtml setlocal filetype=html
augroup END

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
    autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
    au FileType javascript,typescript,html,htmlcheetah nnoremap <buffer> <LocalLeader>tt :call MoToggleViewFile()<cr>
augroup END

augroup filetype_typescript
    au!
    autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
    au FileType typescript nnoremap <buffer> <leader>ef :TsuReload<cr> :TsuImport<cr>
    au FileType typescript nnoremap <buffer> <leader>er :TsuReload<cr>
    au FileType typescript nnoremap <buffer> <leader>gd :TsuReload<cr> :TsuDefinition<cr>
augroup END

augroup filetype_java
    au!
    au FileType java setlocal equalprg=google-java-format\ -
    au FileType java setlocal shiftwidth=2 tabstop=2
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
    autocmd BufNewFile,BufRead BUILD,*.BUILD,WORKSPACE,*.bzl setlocal equalprg=buildifier
augroup END

augroup filetype_go
    autocmd!
    autocmd BufWritePre *.go GoImports
augroup END
"}}}}}}
" KEYBINDINGS{{{
""" CUSTOM FUNCTIONS
if has("nvim")
    nnoremap <Leader>ev :vsplit ~/.vim/vimrc<cr> :execute 'lcd ~/.vim'<cr>
    nnoremap <Leader>sv :source ~/.vim/vimrc<cr>
else
    nnoremap <Leader>ev :vsplit $MYVIMRC<cr> :execute 'lcd ' . fnamemodify($MYVIMRC, ':p:h')<cr>
    nnoremap <Leader>sv :source $MYVIMRC<cr>
end

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

" [b]uffer{{{
nnoremap <Leader>bb :Buffers<cr>
" Close Buffer
nnoremap <Leader>bd :bd<cr>
"}}}
" [f]ile {{{
nnoremap <Leader>ft :call MoToggleNERDTree('NERDTree %')<cr>
" }}}
" [p]roject {{{
nnoremap <Leader>pt :call MoToggleNERDTree('NERDTree')<cr>
" Run FZF
nnoremap <Leader>pf :Files<cr>
"}}}
" [b]uffer {{{
" Delete all content in a buffer
nnoremap <Leader>be ggVGx
nnoremap <Leader>by m'gg"*yG''
" }}}
" [t]oggle{{{
nnoremap <Leader>tT :TagbarToggle<cr>
command! -nargs=1 MoToggleFileByExtension :call MoToggleFileByExtension('<args>')
nnoremap <Leader>te :MoToggleFileByExtension<space>
command! MoExecute execute "read !" . getline('.')
"}}}
" Terminal Keybindings{{{
tnoremap <Esc> <C-\><C-n>
"}}}
"}}}
