" general
colorscheme molokai

set encoding=UTF-8
set number " Show line numbers
set numberwidth=4
set nowrap " Wrap lines
set showbreak=+++ " Wrap-broken line prefix
set textwidth=100 " Line wrap (number of cols)
set showmatch " Highlight matching brace
set visualbell " Use visual bell (no beeping)
set scrolloff=1
set sidescrolloff=2
set hlsearch " Highlight all search results
set smartcase " Enable smart-case search
set incsearch " Searches for strings incrementally
set ttimeout " More responsive ESC key
set ttimeoutlen=100
set autoindent " Auto-indent new lines
set expandtab " Use spaces instead of tabs
set shiftwidth=2 " Number of auto-indent spaces
set smartindent " Enable smart-indent
set smarttab " Enable smart-tabs
set softtabstop=2 " Number of spaces per Tab
set eol
set splitbelow
set splitright
set nocompatible
set ruler " Show row and column ruler information
set undolevels=1000 " Number of undo levels
set backspace=indent,eol,start " Backspace behaviour
set autoread " Auto-updates vim after disk-changes
set wildmenu
set wildmode=list,longest
set wildignore=*.docx,*.doc,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe
if has('patch-8.2.1663')
  set fixendofline
endif

if &t_Co == 8 && $TERM !~# '^Eterm'
  set t_Co=16
endif

let g:mapleader = ','

nnoremap <leader>s w<CR>
nnoremap <leader>q :q<CR>
nnoremap <BS> i<BS><ESC>`^

" Tab/Shift tab for cmd and insert modes
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>

" Resize panes Horiz
noremap <leader>. :10winc <<CR>
nnoremap <leader>, :10winc ><CR>
nnoremap <leader><Left> :winc ><CR>
nnoremap <leader><Right> :winc <<CR>
nnoremap <leader><Up> :5winc -<CR>
nnoremap <leader><Down> :5winc +<CR>

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nnoremap <leader>k :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nnoremap <leader>j :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nnoremap <leader>h :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>n :tabnext<CR>
nnoremap <leader>t :tabnew<CR>

" Plugins
call plug#begin()
  Plug 'editorconfig/editorconfig-vim'
  Plug 'preservim/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'vim-airline/vim-airline'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  if has('patch-7.4.2008')
    Plug 'romainl/vim-cool'
  endif
call plug#end()
nnoremap <leader>pp :PlugInstall<CR>
nnoremap <leader>pr :source $MYVIMRC<CR>

" NERDTREE
nnoremap <leader>b :NERDTreeToggle<CR>
nnoremap <leader>m :NERDTreeFind<CR>
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
let g:NERDTreeGitStatusShowIgnored = 1
let g:NERDTReeGitStatusUseNerdFonts = 1
nmap <leader>g :GitGutterLineHighlightsToggle<CR>
cnoreabbr git Git
