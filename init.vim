"Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes

" Airline is a plugin that makes the status line look fancier.
" It requires a custom font (with arrows), and is completely optional
Plug 'vim-airline/vim-airline'

Plug 'vim-airline/vim-airline-themes'

" Nord color theme
Plug 'arcticicestudio/nord-vim'

" Gruvbox color theme
Plug 'morhetz/gruvbox'

" A more convenient (than default) directory browser for Vim
Plug 'scrooloose/nerdtree'

Plug 'pangloss/vim-javascript'

" This is a core plugin to support autocompletion for most of the things.
" This is also the messiest one, as it requires manual (and periodic) 
" invocation of the build script.
Plug 'Valloric/YouCompleteMe'

" Highlights new/mofified/deleted lines in the "gutter"
Plug 'airblade/vim-gitgutter'

" Later in the config I'll bind this plugin to "gc"
" Typing "gc" will comment out a block or line of code in any language
Plug 'tpope/vim-commentary'

" A wrapper around silversearcher-ag
Plug 'rking/ag.vim'

" If you prefer Ctrl+h/j/k/l for navigating across vim/tmux splits,
" this plugin will integrate Vim and Tmux, so that you can seamlessly
" Jump across the border of a vim/tmux split
Plug 'christoomey/vim-tmux-navigator'

" This is the interesting one: it generates a Tmux config that makes
" a tmux status line look like a vim airline with an applied theme
Plug 'edkolev/tmuxline.vim'

" Never got used to this one, but it allows for wrapping a piece of
" text into "", '', or custom tags
Plug 'tpope/vim-surround'

" Fzf for ffffuzzzy search~
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Ale for linting
Plug 'w0rp/ale'

" Ultisnips!!
" Track the engine.
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<Leader>q"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

Plug 'vim-syntastic/syntastic'

Plug 'mattn/emmet-vim'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

" Initialize plugin system
call plug#end()

set updatetime=500

" Neomake configs to make it a bit less annoying
"
" Airline setup

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme = "jellybeans"


" Turn on line numbers
set relativenumber 
" Turn on syntax highlighting
syntax on
" It hides buffers instead of closing them.
" https://medium.com/usevim/vim-101-set-hidden-f78800142855
set hidden
" Highlights search results as you type vs after you press Enter
set incsearch
" Ignore case when searching
set ignorecase
set smartcase 
" Turns search highlighting on
set hlsearch
" Expands TABs into whitespaces
set expandtab
set shiftwidth=4  

set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing

" Exclude these files from *
set wildignore=*.swp,*.bak,*.pyc,*.class
" Turn on TrueColor
set termguicolors

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --ignore .git --ignore build-out --ignore build-opt --ignore build-dbg -g ""'

endif

"let g:nord_cursor_line_number_background = 1

"let g:nord_comment_brightness = 15

"colorscheme nord

colorscheme gruvbox
set background=dark

" Ctrl+P opens a fuzzy filesearch window (powered by Fzf)
nnoremap <C-p> :Files<CR>

" Buffer manipulation
nnoremap <C-n> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <C-X> :bdelete<CR>

" select all text in buffer
map <Leader>a ggVG

"edit init.vim quickly
map <Leader>v :sp ~/.config/nvim/init.vim<CR>

" Eslint through vim
let g:ale_fixers = {
    \ 'javascript': ['eslint']
    \ }
" Switch to last active tab
let g:lasttab = 1
" I really like tt for switching between recent tabs
nmap tt :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" This is a quick way to call search-and-replace on a current word
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
" cc now hides those annoying search highlihghts after you're done searching
nnoremap cc :let @/ = ""<cr>
" \e to open a NerdTree at in the directory of the currently viewed file
nnoremap <Leader>e :Ex<CR>
nnoremap <Leader>t :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" I said write it!
cmap w!! w !sudo tee % >/dev/null
