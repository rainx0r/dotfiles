call plug#begin()
  Plug 'neoclide/coc.nvim', {'branch': 'release'}  " Code Completion
  Plug 'scrooloose/nerdtree'  " File Explorer
  Plug 'Xuyuanp/nerdtree-git-plugin'  " Git extension
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Highlight framework specific stuff
  Plug 'ryanoasis/vim-devicons' " Icons
  Plug 'christoomey/vim-tmux-navigator' " Terminal Navigation
call plug#end()

" Indentation
set smarttab
set expandtab
set shiftwidth=2
set autoindent
set cindent
filetype plugin indent on " Auto indent based on file type

" Code structure
set number
syntax on

" Plugin Configs
" - coc
let g:coc_global_extensions = [
  \'coc-snippets',
  \'coc-pairs',
  \'coc-tsserver',
  \'coc-tslint',
  \'coc-prettier',
  \'coc-json',
  \'coc-pyright',
  \]
command! -nargs=0 Prettier :CocCommand prettier.formatFile
autocmd CursorHold * silent call CocActionAsync('highlight')
nmap <F2> <Plug>(coc-rename)
inoremap <silent><expr> <c-space> coc#refresh()

" - NERDTree
let g:NERDTreeIgnore = ['^node_modules$', '^site_packages$']
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeHighlightCursorLine = 0

nmap <C-n> :NERDTreeToggle<CR>
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

autocmd BufEnter * call SyncTree()
