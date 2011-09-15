" Install pathogen.  Makes installing plugins easier.
call pathogen#infect()

" Setup indenting
set autoindent
set smartindent

" Tabs should be rendered as two spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Highlight matching braces
set showmatch

" Disable the terminal bell on error
set t_vb=
set noerrorbells

" Make sure the ruler is displayed at the bottom
set ruler

" Use incremental search whenever performing a search
set incsearch

" Whenever a file is updated, reload it
set autoread

" Ignore case when searching
set ignorecase
set smartcase

" Highlight items when searching
set hlsearch

" Highlight according to syntax
syntax enable

" Convert tabs to spaces
set expandtab

" Load filetype plugins/indent settings
filetype plugin indent on

" Chdir into the directory where the file exists
set autochdir

" Show line numbers
set number
set numberwidth=5

" Ruby, use 2 spaces
au BufRead,BufNewFile *.rb,*.rhtml set shiftwidth=2
au BufRead,BufNewFile *.rb,*.rhtml set softtabstop=2

" Set default color scheme
colorscheme wombat
