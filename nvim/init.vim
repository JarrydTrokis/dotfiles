syntax on

set cindent
set expandtab
set hidden
set incsearch
set incsearch
set mouse=a
set noswapfile
set number
set number relativenumber
set relativenumber
set scrolloff=4
set shiftwidth=2
set smartcase
set smarttab
set tabstop=2
set termguicolors
set title
set updatetime=50
set noshowmode

call plug#begin('~/.config/vim/init.vim')
" Vim editor 
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'yuki-ycino/fzf-preview.vim'
Plug 'vim-test/vim-test'

" Language Plugins 
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'elmcast/elm-vim'

" Code Editor Specific
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" Themes
Plug 'gruvbox-community/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }

" Syntax highlighting
Plug 'HerringtonDarkholme/yats.vim'
call plug#end()

let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Set Colour Theme
let g:NERDTreeDirArrows = 1
let g:NERDTreeIgnore = ['^node_modules$']
let g:NERDTreeMinimalUI = 1
let g:elm_format_autosave = 1
let g:elm_setup_keybindings = 0
let g:elm_syntastic_show_warnings = 1
let g:import_sort_auto = 1
let g:rehash256 = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:tsuquyomi_shortest_import_path = 1

" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ ]

let g:lightline = {
      \ 'colorscheme': 'ayu_dark',
      \ }

colorscheme gruvbox
set background=dark

nnoremap <SPACE> <Nop>
let mapleader = " "

" Short cuts for copy/paste
vmap <C-x> "*d 
vmap <C-c> "*y
nmap <C-c> "*Y
nmap <C-v> "*p 

" Short cuts for plugins
map <silent><leader>o :NERDTreeFind<CR>
map <silent><leader><Tab> :NERDTreeToggle<CR>
nnoremap <silent><leader>m :Goyo<CR>
nnoremap <silent><c-p> :FzfPreviewDirectoryFiles<CR>
nnoremap <c-f> :Find<space>
nnoremap <c-s> :vsp<CR>
nnoremap <silent><leader>c :Commentary<CR>
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>
nmap <silent><leader>as :CocCommand eslint.executeAutofix<CR>
nmap <leader>rr <Plug>(coc-rename)
" Vim-Fugitive
nmap <leader>gf :diffget //2<CR>
nmap <leader>gj :diffget //3<CR>
nmap <leader>gs :G<CR>
"------------------------------" 

" Shortcuts for navigating tabs
nnoremap <leader>l gt
nnoremap <leader>h gT
"------------------------------"

" #### VIM TEST MAPPINGS ####
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>
"------------------------------"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Shortcut for clearing search
nnoremap <silent> <leader><space> :nohlsearch<CR>

" Ctrl P Settings
let g:ctrlp_working_path_mode = 'c'

" TYPESCRIPT STUFF
autocmd FileType typescript.tsx nmap <buffer> <leader>gt :<C-u>echo tsuquyomi#hint()<CR>
autocmd FileType typescript nmap <buffer> <leader>gt :<C-u>echo tsuquyomi#hint()<CR>

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" COC Setup

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your NeoVim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
syntax on
