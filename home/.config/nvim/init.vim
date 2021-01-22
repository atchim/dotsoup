"
" Chars
"

set fillchars=fold:\ ,vert:\ 
set listchars=extends:>,precedes:<,tab:>\ ,trail:~

"
" Completion
"

set completeopt=menuone,noinsert,noselect
set shortmess+=c

"
" Indentation
"

set breakindent
set copyindent
set expandtab
set shiftround
set smartindent

set shiftwidth=2
set softtabstop=2
set tabstop=2

"
" Map Leader
"

nnoremap <Space> <NOP>
let mapleader=' '

"
" Match
"

set gdefault
set ignorecase
set showmatch
set smartcase

"
" Scroll
"

set scrolloff=8
set sidescroll=8
set sidescrolloff=8

"
" UI
"

colorscheme underworld
set cmdheight=2
set number
set pumblend=10
set list
set relativenumber
set signcolumn=yes
set termguicolors
set title
set visualbell

"
" Variables
"

let g:omni_sql_no_default_maps = 1
let g:python_recommended_style = 0
let g:rust_recommended_style = 0

"
" Wrap
"

set colorcolumn=+1
set textwidth=79
set nowrap

"
" Misc
"

set clipboard=unnamed
set concealcursor=i
set conceallevel=2
set hidden
set inccommand=nosplit
set lazyredraw
set mouse=a
set spelllang=en_us
set ttimeoutlen=0
set undofile
set updatetime=250

lua require'dotsoup'.setup()
