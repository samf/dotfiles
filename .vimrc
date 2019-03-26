set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'     " vundle its own self

Plugin 'Markdown'                 " markdown support
Plugin 'fatih/vim-go'             " super golang support
Plugin 'jade.vim'                 " pug (nee jade) html dialact
Plugin 'posva/vim-vue'            " vue single-file components
Plugin 'tpope/vim-fugitive'       " git stuff
Plugin 'tpope/vim-db'             " database stuff
Plugin 'vim-stylus'               " stylus (css dialact)
Plugin 'pangloss/vim-javascript'  " modern javascript
Plugin 'mxw/vim-jsx'              " html embedded in javascript
Plugin 'scrooloose/nerdcommenter' " comment/uncomment stuff
Plugin 'nelstrom/vim-blackboard'  " color scheme
Plugin 'stephpy/vim-yaml'         " yaml support (limited)
Plugin 'RRethy/vim-illuminate'    " highlight the word you're sitting on
Plugin 'scrooloose/nerdtree'      " directory tree browser
Plugin 'mhinz/vim-signify'        " highlight your changes from source control
Plugin 'tpope/vim-sleuth'         " heuristically set shiftwidth and tabexpand
Plugin 'liuchengxu/vim-which-key' " a realtime helper for the leader key
Plugin 'w0rp/ale'                 " asynchronous lint engine
Plugin 'vim-airline/vim-airline'  " status line fun

call vundle#end()
filetype plugin indent on

let mapleader = ","

let g:go_fmt_cmd = "goimports"
let g:go_fmt_fail_silently = 1

set hidden incsearch hlsearch ignorecase smartcase
nnoremap <silent> <CR> :nohl<CR><CR>
nnoremap <silent> <leader> :WhichKey ','<CR>

imap <C-C> <Esc>

map <leader>gi :GoImports<ENTER>
map <leader>gf :GoFmt<ENTER>
map <leader>gb :GoBuild<ENTER>
map <leader>gt :GoTest<ENTER>
map <leader>gc :GoCallees<ENTER>
map <leader>gI :GoImplements<ENTER>
map <leader>ge :GoIfErr<ENTER>
map <leader>nt :NERDTreeToggle<ENTER>
map <leader>nr :set invrelativenumber<ENTER>
map <leader>df :%w !diff % -<ENTER>
map <leader>nh :nohl<ENTER>

syntax on
color blackboard
set background=dark
set mouse=a
set ttymouse=sgr
set scrolloff=3
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
set autoindent smartindent autowrite
set cindent cinoptions=>8,:0,+4,(4,u0,U1,t0
set colorcolumn=81
set list number cursorline
set listchars=tab:.\ ,trail:~
set showcmd wildmenu
highlight ColorColumn ctermbg=Black
highlight link illuminatedWord Visual
autocmd FileType make setlocal noexpandtab
autocmd FileType cpp setlocal noexpandtab
autocmd FileType go setlocal noexpandtab
autocmd FileType vue syntax sync fromstart
