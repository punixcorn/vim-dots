" To install plugInstall use this
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.vim/plugged/vim_plugins')
"lsp server
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'nvim-lua/plenary.nvim'
"snippets
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ' 
" icons
Plug 'nvim-telescope/telescope.nvim' 
Plug 'ryanoasis/vim-devicons'
"colorschemes
Plug 'EdenEast/nightfox.nvim' 
Plug 'thedenisnikulin/vim-cyberpunk'
Plug 'morhetz/gruvbox' 
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
"vim tex 
Plug 'lervag/vimtex'
"which key
Plug 'liuchengxu/vim-which-key'
"pywal 
Plug 'dense-analysis/ale'
call plug#end()


" -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ some settings -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ "
imap    jk <ESC>
vmap    nm <ESC>
tnoremap <ESC> <C-\><C-n>
set encoding=UTF-8
set number 
set tabstop=4
set expandtab
set shiftwidth=4
set clipboard=unnamedplus
set mouse=v
set undofile 
set undodir=~/.vim/plugged/vim_plugins/undodir
set termguicolors 

" move line or visually selected block 
vnoremap <A-k> :move '<-2<CR>gv=gv
inoremap <A-k> <Esc>:move .-2<CR>==gi
vnoremap <A-j> :move '>+1<CR>gv=gv
inoremap <A-j> <Esc>:move .+1<CR>==gi

" -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ colorscheme -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ "
let g:gruvbox_contrast_dark='soft'
set bg=dark " needed for dark  gruvbox
colorscheme gruvbox

"_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ GitGutter -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ "
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
"
"    let g:lsp_format_sync_timeout = 1000
"    autocmd! BufWritePre *.cpp,*.c,*.rs,*.go call execute('LspDocumentFormatSync')
"    
"    " refer to doc to add more commands
endfunction
let g:lsp_diagnostics_enabled = 0         " disable diagnostics support
augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

"set foldmethod=expr
" \ foldexpr=lsp#ui#vim#folding#foldexpr()
"  \ foldtext=lsp#ui#vim#folding#foldtext()

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


"-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ utlilsnips -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ "

" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
"let g:UltiSnipsExpandTrigger="<Tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"

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

"If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}

" -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ completion -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ "
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"


" -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ vimTex -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ "
" This is necessary for VimTeX to load properly. The "indent" is optional.
" Note that most plugin managers will do this automatically.
filetype plugin indent on

" This enables Vim's and neovim's syntax-related features. Without this, some
" VimTeX features will not work (see ":help vimtex-requirements" for more
" info).
syntax enable

" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
let g:vimtex_view_method = 'zathura'

" Or with a generic interface:
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
let g:vimtex_compiler_method = 'latexrun'

" Most VimTeX mappings rely on localleader and this can be changed with the
" following line. The default is usually fine and is the symbol "\".
let maplocalleader = ','

" -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ which Key -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ "
nnoremap <silent> <leader> :silent WhichKey ','<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual ','<CR>

let g:which_key_map =  {}
let g:which_key_sep = ': '
" Set a shorter timeout, default is 1000
set timeoutlen=100

let g:which_key_use_floating_win = 1

