set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'           " VundleUpdate

Plugin 'preservim/vim-markdown'         " markdown with front matter support
Plugin 'fatih/vim-go'                   " golang support (:GoInst... :GoUp...)
Plugin 'jade.vim'                       " pug (nee jade) html dialact
Plugin 'posva/vim-vue'                  " vue single-file components
Plugin 'tpope/vim-fugitive'             " git stuff
Plugin 'vim-stylus'                     " stylus (css dialact)
Plugin 'pangloss/vim-javascript'        " modern javascript
Plugin 'mxw/vim-jsx'                    " html embedded in javascript
Plugin 'scrooloose/nerdcommenter'       " comment/uncomment stuff
Plugin 'RRethy/vim-illuminate'          " highlight the word you're sitting on
Plugin 'scrooloose/nerdtree'            " directory tree browser
Plugin 'tpope/vim-sleuth'               " heuristic shiftwidth and tabexpand
Plugin 'liuchengxu/vim-which-key'       " a realtime helper for the leader key
Plugin 'w0rp/ale'                       " asynchronous lint engine
Plugin 'vim-airline/vim-airline'        " status line fun
Plugin 'vim-airline/vim-airline-themes' " themes for vim-airline
Plugin 'mattn/emmet-vim'                " html tag helpers
Plugin 'pseewald/vim-anyfold'           " helpers for folding
Plugin 'psf/black'                      " python formatter (:BlackUpgrade)
Plugin 'prettier/vim-prettier'          " run prettier within vim
Plugin 'airblade/vim-gitgutter'         " gutter shows git changes
Plugin 'ruanyl/vim-gh-line'             " open current line on github
Plugin 'kyoh86/vim-go-coverage'         " Go code coverage: GoCover GoCoverClear
Plugin 'davidoc/taskpaper.vim'          " Taskpaper support

Plugin 'neoclide/coc.nvim', {'branch': 'release'}  " Typescript support + more?

Plugin 'catppuccin/vim', { 'name': 'catppuccin' }  " catppuccin color schemes

call vundle#end()

filetype plugin indent on

let mapleader = ","

let g:airline_theme = "deus"
let g:black_linelength = 80
" Only use tsserver and eslint for TypeScript (not deno)
let g:ale_linters = {
\   'typescript': ['tsserver', 'eslint'],
\   'go': ['golangci-lint']
\}
let g:ale_go_golangci_lint_package = 1
let g:gh_line_blame_map = '<leader>gB'
let g:vim_markdown_toml_frontmatter = 1

runtime neural.vim
runtime claude.vim

set hidden incsearch hlsearch ignorecase smartcase
nnoremap <silent> <CR> :nohl<CR><CR>
nnoremap <silent> <leader> :WhichKey ','<CR>

runtime coc.vim

" escape for escape-less keyboards
imap <C-C> <Esc>
imap <C-Y> <Esc><C-Y>,i

map <leader>df :%w !diff % -<ENTER>
map <leader>dF :let g:gitgutter_diff_base = 
map <leader>zv :normal mzzMzv`z<CR>
map <leader>gI :GoImplements<ENTER>
map <leader>gb :GoBuild<ENTER>
map <leader>gc :GoCallees<ENTER>
map <leader>ge :GoIfErr<ENTER>
map <leader>gf :GoFmt<ENTER>
map <leader>gi :GoImports<ENTER>
map <leader>gt :GoTest<ENTER>
map <leader>hs :set nowrap sidescroll=1<ENTER>
map <leader>nh :nohl<ENTER>
map <leader>nr :set invrelativenumber<ENTER>
map <leader>nt :NERDTreeToggle<ENTER>
map <leader>pb :Black<ENTER>
map <leader>pp :Prettier<ENTER>

map <leader>gdr :GoDebugStart
map <leader>gdS :GoDebugStop<ENTER>
map <leader>gdr :GoDebugRestart<ENTER>
map <leader>gdt :GoDebugTest<ENTER>
map <leader>gdb :GoDebugBreakpoint<ENTER>
map <leader>gds :GoDebugStep<ENTER>
map <leader>gdn :GoDebugNext<ENTER>
map <leader>gdo :GoDebugStepOut<ENTER>
map <leader>gdc :GoDebugContinue<ENTER>
map <leader>gdp :GoDebugPrint

syntax on
set termguicolors
color catppuccin_mocha
highlight Comment guifg=#89dceb

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
autocmd FileType make setlocal noexpandtab
autocmd FileType cpp setlocal noexpandtab
autocmd FileType go setlocal noexpandtab
autocmd FileType vue syntax sync fromstart
autocmd FileType * AnyFoldActivate
set foldlevel=99
