set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'           " vundle its own self

Plugin 'Markdown'                       " markdown support
Plugin 'fatih/vim-go'                   " golang support (:GoInst... :GoUp...)
Plugin 'jade.vim'                       " pug (nee jade) html dialact
Plugin 'posva/vim-vue'                  " vue single-file components
Plugin 'tpope/vim-fugitive'             " git stuff
Plugin 'vim-stylus'                     " stylus (css dialact)
Plugin 'pangloss/vim-javascript'        " modern javascript
Plugin 'mxw/vim-jsx'                    " html embedded in javascript
Plugin 'scrooloose/nerdcommenter'       " comment/uncomment stuff
Plugin 'lisposter/vim-blackboard'       " color scheme
Plugin 'stephpy/vim-yaml'               " yaml support (limited)
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
Plugin 'jaxbot/semantic-highlight.vim'  " even fancier syntax highlighting
Plugin 'prettier/vim-prettier'          " run prettier within vim
Plugin 'leafOfTree/vim-svelte-plugin'   " svelte syntax highlighting
Plugin 'coc-extensions/coc-svelte'      " the rest of svelte
Plugin 'airblade/vim-gitgutter'         " gutter shows git changes
Plugin 'ruanyl/vim-gh-line'             " open current line on github
Plugin 'google/vim-jsonnet'             " jsonnet
Plugin 'kyoh86/vim-go-coverage'         " Go code coverage: GoCover GoCoverClear

call vundle#end()

filetype plugin indent on

let mapleader = ","

let g:airline_theme = "deus"
let g:black_linelength = 80
let g:go_fmt_cmd = "goimports"
let g:go_fmt_fail_silently = 1
let g:gh_line_blame_map = '<leader>gB'

set hidden incsearch hlsearch ignorecase smartcase
nnoremap <silent> <CR> :nohl<CR><CR>
nnoremap <silent> <leader> :WhichKey ','<CR>

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
map <leader>sh :SemanticHighlightToggle<ENTER>

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
autocmd FileType * AnyFoldActivate
set foldlevel=99
