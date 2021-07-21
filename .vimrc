syntax enable             " enable syntax processing
filetype plugin indent on " enable filetype-specific indentation and plugins

" INDENTATION ================================================================

set tabstop=4             " number of visual spaces per TAB
set softtabstop=4         " number of spaces in TAB when editing
set shiftwidth=4          " number of spaces for each step of (auto)indent
set expandtab             " tabs are spaces
set autoindent            " auto indentation

" END INDENTATION ============================================================

" UI =========================================================================

set number                " show line numbers
"set cursorline           " highlight current line
set showcmd               " show command in bottom bar
"set showmode             " show current mode in bottom bar
set noshowmode            " mode is shown by lightline plugin
set wildmenu              " visual autocomplete for command menu
set laststatus=2          " always show status line

" brackets matching already works without this option
"set showmatch            " highlight matching brackets

" END UI =====================================================================

" SEARCH =====================================================================

set incsearch             " search as characters are entered
set hlsearch              " highlight matches
set smartcase

" END SEARCH =================================================================

" PLUGINS ====================================================================

" enable automatic installation of vim-plug (plugin manager)
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'

Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf.vim'

Plug 'matze/vim-move'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'

"Plug 'preservim/nerdtree'
"Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'majutsushi/tagbar'

Plug 'andrewstuart/vim-kubernetes'

" Languages support
Plug 'udalov/kotlin-vim' 
" TODO enable snipets
Plug 'pearofducks/ansible-vim'
Plug 'mustache/vim-mustache-handlebars'

" Color schemes
Plug 'doums/darcula'
call plug#end()

" END PLUGINS ================================================================

let g:ale_sign_error   = ''
let g:ale_sign_warning = ''

let g:NERDSpaceDelims = 1

" COLORS =====================================================================

colorscheme darcula
set termguicolors
" remove theme background
highlight Normal guibg=NONE ctermbg=NONE
" remove line numbers background
"highlight LineNr guibg=NONE ctermbg=NONE

let g:lightline = { 'colorscheme': 'darculaOriginal' }
"let g:lightline = { 'colorscheme': 'darcula' }

highlight ALEErrorSign ctermbg=236 ctermfg=131 guifg=#BC3F3C guibg=#313335

" END COLORS =================================================================

" KEYBINDINGS ================================================================

let mapleader=','

" change key modifier for vim-move (lines movement plugin) to Ctrl+Shift+key
let g:move_key_modifier = 'C-S'

nmap <C-S-Up>   <Plug>MoveLineUp
nmap <C-S-Down> <Plug>MoveLineDown

vmap <C-S-Up>   <Plug>MoveBlockUp
vmap <C-S-Down> <Plug>MoveBlockDown

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

inoremap jj <Esc>
noremap <C-n> :NERDTreeToggle<CR>

" toggle comment with Ctrl+/
" https://stackoverflow.com/a/48690620
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv

" copy to system clipboard
vnoremap <C-c> "+y

noremap ; :Files<CR>

" END KEYBINDINGS ============================================================

" LIGHTLINE ==================================================================

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \ }

let g:lightline.component_type = {
      \  'linter_checking': 'raw',
      \  'linter_infos': 'right',
      \  'linter_warnings': 'warning',
      \  'linter_errors': 'error',
      \ }

let g:lightline.active = {
      \  'right': [
      \             [ 'lineinfo' ],
      \             [ 'percent' ],
      \             [ 'fileformat', 'fileencoding', 'filetype' ],
      \             [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos' ] ]
      \ }

let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_infos = "\uf129"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e "

" END LIGHTLINE ==============================================================

" REFERENCES =================================================================

" https://dougblack.io/words/a-good-vimrc.html
" https://opensource.com/article/19/11/vim-plugins
