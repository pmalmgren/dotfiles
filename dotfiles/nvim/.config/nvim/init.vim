set shiftwidth=4
set tabstop=4
set number
set expandtab

tnoremap <Esc> <C-\><C-n>

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neovimhaskell/haskell-vim'
Plug 'parsonsmatt/intero-neovim'
Plug 'neomake/neomake'
Plug 'Shougo/vimproc'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'eagletmt/ghcmod-vim'
Plug 'eagletmt/neco-ghc'
Plug 'alx741/vim-hindent'
Plug 'alx741/vim-stylishask'
Plug 'godlygeek/tabular'
Plug 'ervandew/supertab'
Plug 'jistr/vim-nerdtree-tabs'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'ambv/black'
Plug 'fisadev/vim-isort'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }


" List ends here. Plugins become visible to Vim after this call.
call plug#end()
" Required for operations modifying multiple buffers like rename.

let g:LanguageClient_serverCommands = {
    \ 'python': ['/usr/local/bin/pyls'],
    \ }

au BufNewFile,BufRead *.js, *.html, *.css, *.yaml, *.yml set tabstop=2 softtabstop=2 shiftwidth=2

au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent fileformat=unix

autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"Toggle NERDTree with Ctrl-N
map <C-n> :NERDTreeToggle<CR>

"Show hidden files in NERDTree
let NERDTreeShowHidden=1

" Automatically reload on save
au BufWritePost *.hs InteroReload

" Run black and isort on save
au BufWritePost *.py execute ':Black'
au BufWritePost *.py execute ':Isort'
let g:black_virtualenv = "~/.virtualenvs/nvim-language-server/"

" Lookup the type of expression under the cursor
au FileType haskell nmap <silent> <leader>t <Plug>InteroGenericType
au FileType haskell nmap <silent> <leader>T <Plug>InteroType
" Insert type declaration
au FileType haskell nnoremap <silent> <leader>ni :InteroTypeInsert<CR>
" Show info about expression or type under the cursor
au FileType haskell nnoremap <silent> <leader>i :InteroInfo<CR>

" Open/Close the Intero terminal window
au FileType haskell nnoremap <silent> <leader>nn :InteroOpen<CR>
au FileType haskell nnoremap <silent> <leader>nh :InteroHide<CR>

" Reload the current file into REPL
au FileType haskell nnoremap <silent> <leader>nf :InteroLoadCurrentFile<CR>
" Jump to the definition of an identifier
au FileType haskell nnoremap <silent> <leader>ng :InteroGoToDef<CR>
" Evaluate an expression in REPL
au FileType haskell nnoremap <silent> <leader>ne :InteroEval<CR>

" Start/Stop Intero
au FileType haskell nnoremap <silent> <leader>ns :InteroStart<CR>
au FileType haskell nnoremap <silent> <leader>nk :InteroKill<CR>

" Reboot Intero, for when dependencies are added
au FileType haskell nnoremap <silent> <leader>nr :InteroKill<CR> :InteroOpen<CR>

" Managing targets
" Prompts you to enter targets (no silent):
au FileType haskell nnoremap <leader>nt :InteroSetTargets<CR>

" Go configuration
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"

" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1

" Ctrl-{hjkl} for navigating out of terminal panes
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

call neomake#configure#automake('w')
let g:neomake_open_list = 2

au FileType haskell nmap <leader>mc :GhcModSplitFunCase<CR>
au FileType haskell nmap <leader>ms :GhcModSigCodegen<CR>

let g:hindent_on_save = 1
au FileType haskell nnoremap <silent> <leader>ph :Hindent<CR>

let g:stylishask_on_save = 1
au FileType haskell nnoremap <silent> <leader>ps :Stylishask<CR>

nnoremap <leader>= :Tabularize /=<CR>
nnoremap <leader>- :Tabularize /-><CR>
nnoremap <leader>, :Tabularize /,<CR>
nnoremap <leader># :Tabularize /#-}<CR>

let g:deoplete#enable_at_startup = 1

" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0

" neco-ghc
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc 
let g:necoghc_enable_detailed_browse = 1

nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>
