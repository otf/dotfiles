"========================================
" basic configuration {{{1
"========================================
if &compatible
  set nocompatible
endif
set runtimepath^=$HOME/repos/github.com/Shougo/dein.vim

set number
set nowrap
filetype on
syntax on
set incsearch
set hlsearch
let mapleader = "\<Space>"
set statusline=%<%f\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%8P
colorscheme delek

"========================================
" key mapping {{{1
"========================================
" window key mapping
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" for easy-motion
map s <Plug>(easymotion-s2)
map f <Plug>(easymotion-fl)
map t <Plug>(easymotion-tl)
map F <Plug>(easymotion-Fl)
map T <Plug>(easymotion-Tl)

" for skk
inoremap <C-j> <Nop>
inoremap <silent> <C-[> <ESC>:call system('fcitx-remote -c')<CR>

"========================================
" dein.vim {{{1
"========================================
let s:dein_dir = expand('$HOME/.cache/dein')
let s:toml = expand('$HOME/.config/nvim/dein.toml')
let s:haskell_toml = expand('$HOME/.config/nvim/dein_haskell.toml')
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:haskell_toml, {'lazy': 0})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_as_default_explorer = 1
let g:neocomplete#enable_at_startup = 1

