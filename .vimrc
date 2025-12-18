syntax on

let mapleader = " "
set guicursor=                 " no fancy cursor
set number                     " absolute line numbers
set relativenumber             " relative line numbers
set scrolloff=8                " keep 8 lines visible above/below cursor
set signcolumn=yes             " always show the sign column
set tabstop=2                  " a tab character = 2 spaces
set softtabstop=2              " number of spaces when hitting <Tab>
set shiftwidth=2               " indentation amount for << and >>
set expandtab                  " convert tabs to spaces
set smartindent                " enable smart indentation
set nowrap                     " do not wrap long lines
set noswapfile                 " disable swapfile
set nobackup                   " disable backup files
set undodir=$HOME/.vim/undodir
set undofile                   " enable persistent undo
set nohlsearch                 " do not highlight search results
set incsearch                  " show match as you type
set isfname+=@-@               " allow @-@ in file names
set updatetime=50              " faster update for CursorHold and plugins
"set signcolumn=no              " temporary until I find a good color scheme
highlight SignColumn ctermbg=NONE guibg=NONE



" Keymaps
nnoremap <leader>pv :Ex<CR>
nnoremap <C-S> <Esc>:w<CR>
inoremap <C-S> <Esc>:w<CR>
vnoremap <C-S> <Esc>:w<CR>

if !has('gui_running')
    execute "set <A-w>=\ew"
endif
nnoremap <silent> <A-w>h :wincmd h<CR>
nnoremap <silent> <A-w>j :wincmd j<CR>
nnoremap <silent> <A-w>k :wincmd k<CR>
nnoremap <silent> <A-w>l :wincmd l<CR>
vnoremap <leader>y :w !xclip -selection clipboard<CR><CR>

let g:lsp_document_highlight_enabled = 0
let g:lsp_document_code_action_signs_text = '•'
"let g:loaded_matchparen = 1
highlight MatchParen ctermbg=darkgrey guibg=grey

" ALE https://github.com/dense-analysis/ale
let g:ale_completion_enabled = 1
if executable('pylsp')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

if executable('gopls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'gopls',
        \ 'cmd': {server_info->['gopls']},
        \ 'allowlist': ['go'],
        \ })
endif

if executable('emmet-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'emmet-language-server',
        \ 'cmd': {server_info->['emmet-language-server', '--stdio']},
        \ 'allowlist': ['html'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nmap <buffer> <leader>vf  <plug>(lsp-document-format)
    nmap <buffer> <leader>vca <plug>(lsp-code-action-float)
    
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
