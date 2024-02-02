set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'preservim/nerdtree'
Plugin 'preservim/tagbar'
Plugin 'vim-syntastic/syntastic'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'PhilRunninger/nerdtree-buffer-ops'
Plugin 'PhilRunninger/nerdtree-visual-selection'
Plugin 'blueyed/vim-diminactive'
Plugin 'ryanoasis/vim-devicons'
Plugin 'jiangmiao/auto-pairs'
" Html CSS
Plugin 'mattn/emmet-vim'

" colorscheme
"Plugin 'skielbasa/vim-material-monokai'

" syntax Highlight
Plugin 'sheerun/vim-polyglot'

call plug#end()

filetype plugin indent on

"Cursor Shape
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode
" reset the cursor on start (for older versions of vim, usually not required)
" reset the cursor on End / Leave
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[1 q"
augroup END

"Plugin 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=1
"let g:airline_theme='materialmonokai'

nmap <F2> : TagbarToggle<cr>
nmap <F3> : NERDTreeToggle<cr>

inoremap <expr><Tab> getline('.')[col('.')-1] =~? '[]>)}''"`]' ? '<Right>' : '<Tab>'

"let g:materialmonokai_italic=1
if has("termguicolors")
	set termguicolors
endif
"colorscheme material-monokai

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

if has("Syntax")
	syntax on
endif

autocmd FileType sh,bash,zsh set ts=2 sts=2 sw=2
autocmd FileType c set ts=8 sts=8 sw=8
autocmd FileType cpp set ts=4 sts=4 sw=4
autocmd Filetype rust set ts=4 sts=4 sw=4
autocmd FileType python set ts=4 sts=4 sw=4
autocmd FileType java set ts=4 sts=4 sw=4
autocmd FileType javascript set ts=2 sts=2 sw=2
autocmd FileType javascriptreact set ts=2 sts=2 sw=2
autocmd FileType typescript set ts=2 sts=2 sw=2
autocmd FileType typescriptreact set ts=2 sts=2 sw=2
autocmd FileType vim set ts=2 sts=2 sw=2
autocmd FileType html set ts=2 sts=2 sw=2
autocmd FileType css set ts=2 sts=2 sw=2

set clipboard=unnamedplus
set t_Co=256
set autoindent
set completeopt=menuone,menu,longest,preview
set wildmenu
set wildmode=longest,list
set autowrite
set autoread
set showmatch
set cindent
set smartindent
set wrap
set nowrapscan
set nobackup
set noswapfile
set ruler
set sw=1
set number
set fencs=utf-8,euc-kr,cp949
set encoding=utf-8
set tenc=utf-8
set hlsearch
set ignorecase
set lbr
set incsearch
set cursorline
set laststatus=2
filetype indent on
set background=dark
set backspace=eol,start,indent
set history=256
set mouse=a
set listchars=tab:\|\ ,trail:•,extends:»,precedes:« "Unprintable chars mapping
set list
set vb t_vb=
set statusline=\ %<%l:%v\ [%p]%=%a\ %h%m%r\ %F\

highlight Comment term=italic cterm=italic ctermfg=4
highlight Repeat term=italic cterm=italic ctermfg=4
highlight Statement term=italic cterm=italic ctermfg=4
highlight Conditional term=italic cterm=italic ctermfg=4

" ************************************************************************
"" Functions
" ************************************************************************
if !exists('*s:setupWrapping')
	function s:setupWrapping()
	 	set wrap
		set wm=2
		set textwidth=79
	endfunction
endif


"" remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e

"" Remember cursor position
augroup vimrc-remember-cursor-position
	autocmd!
	autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "norm g'\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
	autocmd!
	autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

"" make/cmake
augroup vimrc-make-cmake
	autocmd!
	autocmd FileType make setlocal noexpandtab
	autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

set autoread

if $LANG[0]=='k' && $LANG[1]=='o'
	set fileencoding=korea
endif

"using copy paste system clipboard
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

"set foldenable          " enable folding
"set foldlevelstart=10   " open most folds by default
"set foldnestmax=10      " 10 nested fold max
"nnoremap <space> za	" space open/closes folds
"set foldmethod=indent   " fold based on indent level
