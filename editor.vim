" Editor
set number          " Set Line number
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent      " turns it on
set smartindent     " does the right thing (mostly) in programs


" Search Related
set ignorecase " case insensitive
set smartcase  " use case if any caps used
set incsearch  " show match as search proceeds
set hlsearch   " search highlighting

" ETC
syntax enable
filetype plugin on
set nobackup   " Do not create backup files
set noswapfile " Do not create swap files

" THEME
colorscheme Monokai

augroup global_whitespace_fix
    autocmd!
    autocmd BufWritePre * :FixWhitespace
    autocmd BufWritePre * :call TrimEndLines()
augroup END
