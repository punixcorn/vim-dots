call plug#begin('~/.vim/plugged/vim_plugins')
"lsp server
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'nvim-lua/plenary.nvim'
"snippets 
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ' "syntax highlighting 
Plug 'nvim-telescope/telescope.nvim' "icons
Plug 'ryanoasis/vim-devicons'
"colorschemes
Plug 'EdenEast/nightfox.nvim' 
Plug 'thedenisnikulin/vim-cyberpunk'
""clang-format
Plug 'kana/vim-operator-user'
Plug 'rhysd/vim-clang-format'
"vim cmake
Plug 'cdelledonne/vim-cmake'
"vim gitgutter
Plug 'airblade/vim-gitgutter'
"fuzzy finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
"auto pairs 
Plug 'jiangmiao/auto-pairs'
call plug#end()

" -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ some settings -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ "

imap    jk <ESC>
vmap    nm <ESC>
set encoding=UTF-8
set number 
"set laststatus=2
set tabstop=4
set expandtab
set shiftwidth=4
set mouse=a
set clipboard=unnamedplus
set undofile 
set undodir=~/.vim/plugged/vim_plugins/undodir
set termguicolors 
" move line or visually selected block 
vnoremap <A-k> :m '<-2<CR>gv=gv
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
inoremap <A-j> <Esc>:m .+1<CR>==gi

" -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ colorscheme -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ "
colorscheme duskfox


"_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ colorscheme -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ "
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

" -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ vim lsp -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ "
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.cpp,*.c,*.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

set foldmethod=expr
  \ foldexpr=lsp#ui#vim#folding#foldexpr()
  \ foldtext=lsp#ui#vim#folding#foldtext()

" -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ clang-format -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ "
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "c++17"}
let g:clang_format#code_style = "mozilla"
"google chromium llvm mozilla
" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>
autocmd FileType c ClangFormatAutoEnable 
autocmd FileType cpp ClangFormatAutoEnable 


" -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ auto pairs -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ "
""inoremap " ""<left>
""inoremap ' ''<left>
""inoremap ( ()<left>
""inoremap [ []<left>
""inoremap { {}<left>
""inoremap {<CR> {<CR>}<ESC>O
""inoremap {;<CR> {<CR>};<ESC>O

" -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ vim snips -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ "
" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}

" -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ completion -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ "
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"


