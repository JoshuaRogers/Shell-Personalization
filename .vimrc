" Install pathogen.  Makes installing plugins easier.
call pathogen#infect()

" Add a shortcut to toggle NERDTree: CTRL-n
nmap <silent> <c-e> :NERDTreeToggle<CR>

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

" Load filetype plugins/indent settings
filetype plugin indent on

" Chdir into the directory where the file exists
set autochdir

" Show line numbers
set number
set numberwidth=5

" Set default color scheme
set t_Co=256
set background=dark
colorscheme solarized

" Maps F5 to the undo tree.
nnoremap <F5> :GundoToggle<CR>

" Make the status bar show up.
set laststatus=2

" Used for branching icons.
let g:airline_powerline_fonts = 1

" Syntax checkers for syntastic
let g:syntastic_python_checkers = ['python']

set pastetoggle=<F10>
