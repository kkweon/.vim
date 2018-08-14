""" Leader key
let mapleader = " "
""" CUSTOM FUNCTIONS
nnoremap <Leader>ev :vsplit $MYVIMRC<cr>
nnoremap <Leader>sv :source $MYVIMRC<cr>
" Close Buffer
nnoremap <Leader>bd :bd<cr>
" Open NERD Tree
nnoremap <Leader>ft :NERDTreeToggle %<cr>
" Run FZF
nnoremap <Leader>pf :Files<cr>

""" YCMD Keybindings
nnoremap <Leader>gg :YcmCompleter GoTo<cr>
nnoremap <Leader>gd :YcmCompleter GoToDefinition<cr>
nnoremap <Leader>gb <C-o>

" Delete all content in a buffer
nnoremap <Leader>be ggVGx
