set nu
set showcmd
set incsearch
set cul
set nobackup
set wrap
set title
set ignorecase
set hls
set smartindent
set tabstop=4
set expandtab
set shiftwidth=4
set encoding=utf-8
set fileencodings=utf-8
set clipboard=unnamed
set noimd
set autochdir
set noswapfile
set t_Co=256

filetype plugin indent on
filetype plugin on
filetype on
syntax on

call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install -all'}
Plug 'junegunn/fzf.vim'

"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
"Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
"Plug 'nsf/gocode'
"Plug 'pappasam/coc-jedi' , {'do': 'yarn install --frozen-lockfile && yarn build'}

" LSP for Swift
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/vim-lsp'
            \ |Plug 'prabirshrestha/async.vim'
            \ |Plug 'prabirshrestha/asyncomplete-lsp.vim'
            \ |Plug 'prabirshrestha/asyncomplete.vim'
            \ |Plug 'prabirshrestha/asyncomplete-buffer.vim'

Plug 'keith/swift.vim'

Plug 'Lokaltog/vim-easymotion'
Plug 'kien/ctrlp.vim'
            \| Plug 'fisadev/vim-ctrlp-cmdpalette'
            \| Plug 'ivalkeen/vim-ctrlp-tjump'
            \| Plug 'sgur/ctrlp-extensions.vim'
            \| Plug 'suy/vim-ctrlp-commandline'
            \| Plug 'tacahiroy/ctrlp-funky'
Plug 'dyng/ctrlsf.vim'
Plug 'godlygeek/tabular'
Plug 'jiangmiao/auto-pairs'
Plug 'majutsushi/tagbar'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'abudden/taghighlight-automirror'
Plug 'vim-scripts/a.vim'

" color scheme
Plug 'drewtempelmeyer/palenight.vim'
Plug 'tpope/vim-fugitive'
Plug 'morhetz/gruvbox'
Plug 'git://git.wincent.com/command-t.git'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-abolish'
Plug 'Lokaltog/vim-easymotion'
Plug 'ronakg/quickr-cscope.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'mhinz/vim-startify'

call plug#end()

"au VimEnter * colorscheme palenight
colorscheme palenight

let mapleader=','

" Sourcekit-LSP configuration
if executable('sourcekit-lsp')
    au User lsp_setup call lsp#register_server({
                \ 'name': 'sourcekit-lsp',
                \ 'cmd': {server_info->['sourcekit-lsp']},
                \ 'whitelist': ['swift'],
                \ })
endif

autocmd FileType swift setlocal omnifunc=lsp#complete
autocmd FileType swift nnoremap <C-]> :LspDefinition<CR>

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" Use Tab for trigger completion
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "<C-n>" :
    \ coc#expandableOrJumpable() ? coc#rpc#request('doKeymap', ['snippets-expand-jump','']) :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

 "Use <cr> to confirm completion, '<C-g>u' means break undo chain at current
 "position.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use '[g' and ']g' to navigate diagnostics
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

" Use K show documentation in previe window.
"nnoremap <silent> K :call <SID>show_documentations()<CR>

"function! s:show_documentations()
"    if (index(['vim','help'], &filetype) >= 0)
"        execute 'h '.expand('<cword>')
"    else
"        call CocAction('doHover')
"    endif
"endfunction

" Symbol renaming
"nmap <leader>rn <Plug>(coc-rename)

"let g:coc_snippet_next = '<TAB>'

map <leader>sb <ESC>:CtrlPBuffer<CR>
map <leader>sd <ESC>:CtrlPBookmarkDir<CR>
map <leader>sm <ESC>:CtrlPMRUFiles<CR>

vmap <leader>sq <Plug>CtrlSFVwordPath

nnoremap <leader>su :CtrlPFunky<CR>
nnoremap <leader>sU :execute 'CtrlPFunky ' . expand('<cword>')<CR>

nmap / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map <leader>l <Plug>(easymotion-lineforward)
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)
map <leader>h <Plug>(easymotion-linebackward)
nmap s <Plug>(easymotion-overwin-f)

nnoremap <buffer><silent> q :cclose<CR>

au FileType swift nmap <leader>r :w<CR>:cgete system('swift '.shellescape(expand('%')))<CR>:copen<CR><C-w><C-w><CR>

autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \ exe "normal g'\"" |
            \ endif

if executable('pyls')
    au User lsp_setup call lsp#register_server({
                \ 'name': 'pyls',
                \ 'cmd': {server_info->['pyls']},
                \ 'allowlist': ['python'],
                \ 'whitelist': ['python'],
                \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]d <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Tab Completion, asyncomplete.vim
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

"vim-lsp
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')
let g:asyncomplete_log_file = expand('~/asyncomplete.log')

" fzf.vim
" Mapping selecting mappings
nmap <leader><tab> <Plug>(fzf-map-n)
xmap <leader><tab> <Plug>(fzf-map-x)
omap <leader><tab> <Plug>(fzf-map-o)
" Insert mode competion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

map <leader>gr :cgete system('swift ' . shellescape(expand('%:p')))<CR>:copen<CR><C-w><C-w>
