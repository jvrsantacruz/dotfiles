call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'AndrewRadev/sideways.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'avakhov/vim-yaml'
Plug 'beanworks/vim-phpfmt'
Plug 'cespare/vim-toml'
Plug 'chr4/nginx.vim'
Plug 'chrisbra/unicode.vim'
Plug 'davidhalter/jedi-vim'
Plug 'elzr/vim-json'
Plug 'ervandew/supertab'
Plug 'fisadev/vim-isort'
Plug 'flazz/vim-colorschemes'
Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }
Plug 'hdima/python-syntax'
Plug 'honza/vim-snippets'
Plug 'https://gitlab.com/gi1242/vim-emoji-ab.git'
Plug 'idanarye/vim-merginal'
Plug 'jiangmiao/auto-pairs'
Plug 'jmcantrell/vim-virtualenv'
Plug 'jreybert/vimagit'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'KabbAmine/zeavim.vim'
Plug 'lepture/vim-jinja'
Plug 'majutsushi/tagbar'
Plug 'Matt-Deacalion/vim-systemd-syntax'
Plug 'mgedmin/python-imports.vim'
Plug 'mhinz/vim-grepper'
Plug 'mhinz/vim-signify'
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'ncm2/ncm2'
Plug 'rodjek/vim-puppet'
Plug 'roxma/yarp'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/denite.nvim'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'sirver/UltiSnips'
Plug 'sjl/gundo.vim'
Plug 'szw/vim-g'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'vim-scripts/pyrex.vim'
Plug 'vim-utils/vim-man'
Plug 'w0rp/ale'

call plug#end()

""" Neovim
if has('nvim')
    let g:python_host_prog='/usr/bin/python3'
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
color mustang

" Change pop-up menu color (pink is horrible)
highlight Pmenu ctermfg=0 ctermbg=2
highlight PmenuSel ctermfg=0 ctermbg=7
highlight PmenuSbar ctermfg=7 ctermbg=0
highlight PmenuThumb ctermfg=0 ctermbg=7

" Change BadSpell highlight red background, white letters
highlight SpellBad term=standout cterm=underline ctermfg=Red

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
"autocmd filetype python setlocal equalprg=yapf  " Autoformatting
autocmd filetype python nmap <leader>l :ALELint<CR>:lopen<CR>
autocmd filetype python let g:ale_fixers = {'python': ['black', 'isort']}

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
autocmd filetype make set noexpandtab  " disable tab expanding for make

" systemd
autocmd BufRead,BufNewFile *.service,*.unit set filetype=systemd

" Javascript
autocmd BufRead,BufNewFile *.js set filetype=javascript " Autoindent with 2 spaces
autocmd filetype javascript map <leader>l :SyntasticCheck<CR> :Errors<CR>

" nginx
autocmd BufRead,BufNewFile *.conf set filetype=nginx

" php
autocmd filetype php let g:ale_fixers = {'php': ['phpcbf']}

" golang
autocmd filetype go let g:ale_fixers = {'go': ['gofmt']}

""""""""" Plugins """"""""""""

"" Python-jedi
"let g:jedi#popup_on_dot = 1
"let g:jedi#show_call_signatures = "1"
set completeopt=menuone,longest,preview

"" Supertab
" Autocomplete jedi with supertab
let g:SuperTabDefaultCompletionType = "context"

"" airline
let g:airline_theme='base16'
let g:airline_powerline_fonts=1
" disable filetype section that takes a lot of space
let g:airline_section_y=""
" disable hunks as they take useful space
let g:airline#extensions#hunks#enabled = 0
let g:Powerline_symbols='unicode'

"" Python Ale linters
let g:ale_python_mypy_options = '--ignore-missing-imports'
let g:ale_python_pylint_options = '--disable missing-docstring,
            \no-self-use,expression-not-assigned,invalid-name'
let g:ale_python_isort_executable = 'isort'
let g:ale_php_phpcs_executable='./vendor/bin/phpcs'
let g:ale_php_phpcbf_executable='./vendor/bin/phpcbf'
map <leader>f :ALEFix<CR>

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
if has('python3')
    let g:gundo_prefer_python3 = 1
endif
map <leader>u :GundoToggle<CR>

"" Tagbar
let g:tagbar_autofocus = 1
nmap <leader>h :TagbarToggle<CR>

"" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

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

" Search visual selection
map <leader>sv y/<C-R>"<CR>

" Grep selected text
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)
