call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'amperser/proselint'
Plug 'bufexplorer.zip'
Plug 'davidhalter/jedi-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'flazz/vim-colorschemes'
Plug 'jiangmiao/auto-pairs'
Plug 'jmcantrell/vim-virtualenv'
Plug 'jreybert/vimagit'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'klen/python-mode'
Plug 'majutsushi/tagbar'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'mhinz/vim-grepper'
Plug 'mhinz/vim-signify'
Plug 'mhinz/vim-startify'
Plug 'mileszs/ack.vim'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'sirver/ultisnips'
Plug 'sjl/gundo.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

""" Neovim
if has('nvim')
    let g:python_host_prog='/usr/bin/python'
endif

""" Settings

" Compatibility
set nocompatible               " Drop vi backwards compatibility
filetype plugin indent on      " Load plugins based on file type
syntax on                      " Enable syntax highlighting

"" Visual stuff
set guioptions=                " Remove all menu in gvim
set laststatus=2               " Always show statusline
set display=lastline           " Show last line as much as possible
set ttyfast                    " Allow for faster redrawing
set lazyredraw                 " Avoid sticky cursor and slow scrolling
set number                     " show line numbers
set cursorline                 " Highlight current line
set showmode                   " Show current mode
set showcmd                    " Show already typed keys in commands
set showmatch                  " Show matching parenthesis
set title                      " Set terminal title to filename
set visualbell                 " please DONT BEEP
set noerrorbells               " please DONT BEEP

"" Temporary files
set backup
set backupdir=$HOME/.config/nvim/files/backup/
set backupext =-vimbackup
set backupskip =
set directory =$HOME/.config/nvim/files/swap/
set updatecount=100
set undofile
set undodir=$HOME/.config/nvim/files/undo/
if has('nvim')
    set viminfo='100,n$HOME/.config/.nvim/files/info/nviminfo
else
    set viminfo='100,n$HOME/.config/.nvim/files/info/viminfo
end

"" Encoding
set encoding=utf-8
setglobal fileencoding=utf-8
set fileencodings=utf-8,latin1

"" Editing
set nowrap         " do not wrap long lines and scroll horizontally
set autoindent     " always autoindent
set copyindent     " copy previous indentation on autoindenting
set smarttab       " insert tabs at start of a line according to shiftwidth and not tabstop
set tabstop=4      " tab is four spaces
set softtabstop=4  " Tab indents 4 spaces
set shiftwidth=4   " number of spaces for autoindenting
set shiftround     " use a multiple of shiftwidth when indenting using '<' and '>'
set expandtab
set hidden                     " hide buffers without closing them
set backspace=indent,eol,start  " backspace over everything in insert mode
set textwidth=79    " Default text width to 80 chars
set colorcolumn=79  " Show visual textwidth limit

"" Searching
set ignorecase     " ignore case when searching
set smartcase      " ignore case if search pattern is all lowercase
set hlsearch       " highlight search terms
set incsearch      " show search while you type pattern
set wildmode=longest,list  " Path autocompletion
set wildmenu
" ignore temp files when browsing
set wildignore=*.swp,*.bak,*.pyc,*.class,bower_components,node_modules

"" History
set history=1000 " remember commands and search history up to 1000
set undolevels=1000

""" Colors
set t_Co=256
set background=dark
color mustang

" Change pop-up menu color (pink is horrible)
highlight Pmenu ctermfg=0 ctermbg=2
highlight PmenuSel ctermfg=0 ctermbg=7
highlight PmenuSbar ctermfg=7 ctermbg=0
highlight PmenuThumb ctermfg=0 ctermbg=7


" Change BadSpell highlight red background, white letters
highlight SpellBad term=standout ctermbg=1 ctermfg=7 guifg=White guibg=LightRed

" Avoid bad whitespace
highlight BadWhitespace ctermbg=red guibg=red  "Whitespace
set list  " show invisible spaces, tabulators and the end of lines as #
set listchars=tab:>·,trail:·,extends:#,nbsp:·
match BadWhitespace /^\s\+$/
match BadWhitespace /^\t\+/
match BadWhitespace / ;/

""" Specific per-filetype basic setups

" Python
autocmd BufRead,BufNewFile *.py,*.pyx set filetype=python
autocmd filetype python set nofoldenable  " Desactivar folding
"autocmd filetype python map <leader>l :PymodeLint<CR> :Errors<CR>
autocmd filetype python map <leader>l :SyntasticCheck<CR> :Errors<CR>
" Highlight max line marker


" Markdown/txt
autocmd BufRead,BufNewFile *.md,*.mk,*.markdown set filetype=markdown
autocmd filetype markdown set textwidth=99
autocmd filetype markdown set colorcolumn=99

" HTML
autocmd BufRead,BufNewFile *.html,*.htm set filetype=html
autocmd filetype html set tabstop=2
autocmd filetype html set shiftwidth=2

" XML
autocmd BufRead,BufNewFile *.xml set filetype=xml
autocmd filetype xml set tabstop=2
autocmd filetype xml set shiftwidth=2

" Ruby
autocmd BufRead,BufNewFile *.rb set filetype=ruby  " Autoindent with 2 spaces

" Make
autocmd filetype make set expandtab!  " disable tab expanding for make

" Javascript
autocmd BufRead,BufNewFile *.js set filetype=javascript " Autoindent with 2 spaces
autocmd filetype javascript map <leader>l :SyntasticCheck<CR> :Errors<CR>

""""""""" Plugins """"""""""""

"" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-i>"
let g:UltiSnipsJumpForwardTrigger="<c-I>"
let g:UltiSnipsEditSplit="vertical"

"" Python-mode
" No documentation
let g:pymode_doc = 0
" No code folding
let g:pymode_folding = 0

" Rope
let g:pymode_rope = 0
let g:pymode_rope_show_doc_bind = ''
let g:pymode_rope_vim_completion = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_lint_write = 1
let g:pymode_lint_ignore = "E501,E128,E127,W0401,C0111"

"" Python-jedi
"let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 1
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#show_call_signatures = "0"
set completeopt=menuone,longest,preview

"" Syntastic
let g:syntastic_check_on_open=0
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers= ['pyflakes']

"" Sparkup
let g:sparkup = '~/.vim/ftplugin/html/sparkup.py'

"" airline
let g:airline_theme='base16'
let g:airline_powerline_fonts=1
let g:Powerline_symbols='unicode'

"" NERDTree
let NERDTreeWinSize = 20
" Toggle NerdTree navigation
map <leader>e :NERDTreeToggle<CR>

"" Command-T
" ignore build directory
set wildignore+=build/**,dist/**

"" fzf
" fuzzy finding completion
set rtp+=~/.fzf
map <leader>t :FZF<CR>

"" fugitive
" Configure avature local github
let g:fugitive_gitlab_domains = ['http://gitlab', 'http://gitlab.xcade.net']

"" Gundo
map <leader>u :GundoToggle<CR>

"" Tagbar
let g:tagbar_autofocus = 1
nmap <leader>h :TagbarToggle<CR>

"""" Remaps

" Allows w!! for sudo write
cmap w!! w !sudo tee % >/dev/null

" Cleanup trailing spaces
map <leader>cs :%s/\s\+$//g<CR>

" Fix Spaces for tabs
map <leader>ct :%s/\t/    /g<CR>

" Edit file under cursor
map <leader>of :edit <cfile><CR>

" Insert file under cursor
map <leader>if :read <cfile><CR>

" Change path to current file dir
map <leader>cd :cd %:p:h<CR>

" Change window path to current file dir
map <leader>cdl :lcd %:p:h<CR>

" Search word under cursor without jumping
map <leader>sw *``

" Search visual selection
map <leader>sv y/<C-R>"<CR>
