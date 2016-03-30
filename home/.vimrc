""" Pathogen
filetype off

" Use pathogen to easily modify runtime path to include plugins
" plugins are in ~/.vim/bundle
call pathogen#infect()
call pathogen#helptags()

"filetype plugin indent on  " Load plugins based on file type
filetype plugin on

" Avoid menu in gvim
set guioptions=

" Avoid vi weird compatibility issues
set nocompatible |  filetype indent on | syn on
set encoding=utf-8

" Makes you able to hide buffers without closing them
set hidden

" Highlight current line
set cursorline

" Avoid sticky cursor and slow scrolling
set lazyredraw

" Avoid uncontrolled swap files over the house
set backupdir=~/.swap-vim

" Enable mouse use
set mouse=a

""" Encoding
set encoding=utf-8
setglobal fileencoding=utf-8
set fileencodings=utf-8,latin1


""" Basic things
set number     " show line numbers
set nowrap     " do not wrap long lines and scroll horizontally
set tabstop=4  " tab is four spaces
set autoindent " always autoindent
set copyindent " copy previous indentation on autoindenting
set smarttab   " insert tabs at start of a line according to shiftwidth and not tabstop
set shiftwidth=4 " number of spaces for autoindenting
set shiftround  " use a multiple of shiftwidth when indenting using '<' and '>'
set showmatch  " show matching parenthesis
set ignorecase " ignore case when searching
set smartcase  " ignore case if search pattern is all lowercase
set hlsearch   " highlight search terms
set incsearch  " show search while you type pattern
set backspace=indent,eol,start
               " backspace over everything in insert mode

set history=1000 " remember commands and search history up to 1000
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.class,bower_components,node_modules
                 " ignore temp files when browsing
set title  " change terminal title to the file its beeing edited
set visualbell   " please DONT BEEP
set noerrorbells " please DONT BEEP
"set mouse=a      " enable mouse for selecting, scrolling... not for terminal

" Do not save backup file while editing
set nowritebackup

""" Colors
syntax enable
set t_Co=256
set background=dark
color mustang

" Change pop-up menu color (pink is horrible)
highlight Pmenu ctermfg=0 ctermbg=2
highlight PmenuSel ctermfg=0 ctermbg=7
highlight PmenuSbar ctermfg=7 ctermbg=0
highlight PmenuThumb ctermfg=0 ctermbg=7

""" Specific per-filetype basic setups

" LaTeX
"au BufRead,BufNewFile *.tex set expandtab       	" Convertir tabuladores en espacios
"au BufRead,BufNewFile *.tex set textwidth=99    	" Ancho a 99 caracteres para LaTeX

" Python
au BufRead,BufNewFile *.py,*.pyx set expandtab
au BufRead,BufNewFile *.py,*.pyx set filetype=python
au BufRead,BufNewFile *.py,*.pyx,*pyw set textwidth=78    " Ancho a 79 caracteres
  													" Only python show invisible spaces, 
au filetype python set list                         " tabulators and the end of lines as #
au filetype python set listchars=tab:>·,trail:·,extends:#,nbsp:·
au BufRead,BufNewFile *.py,*pyw match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.py,*pyw match BadWhitespace /^\s\+$/
au BufRead,BufNewFile *.py,*pyw set nofoldenable       " Desactivar folding

" Markdown/txt
au BufRead,BufNewFile *.md,*.mk,*.markdown set expandtab
au BufRead,BufNewFile *.md,*.mk,*.markdown set textwidth=99        " Ancho a 99 caracteres para LaTeX
au BufRead,BufNewFile *.md,*.mk,*.markdown set filetype=markdown   " Unify markdown filetypes

" HTML/XML
au BufRead,BufNewFile *.html,*.htm,*.xml set expandtab     " Convert tabs into spaces
au BufRead,BufNewFile *.html,*.htm,*.xml set tabstop=2     " Tab is 2 spaces
au BufRead,BufNewFile *.html,*.htm,*.xml set shiftwidth=2  " Autoindent with 2 spaces
au BufRead,BufNewFile *.html,*.htm,*.xml match BadWhitespace /^\s\+$/  " Bad whitespace at eol

" Ruby
au BufRead,BufNewFile *.rb set shiftwidth=2  " Autoindent with 2 spaces

""""""""" Plugins """"""""""""

""" Snipmate
let g:snips_author="Javier Santacruz"

""" Python-mode
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

"
let g:pymode_lint_write = 1
let g:pymode_lint_ignore = "E501,E128,E127,W0401"

""" Python-jedi
"let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 1
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#show_call_signatures = "0"
set completeopt=menuone,longest,preview

""" Syntastic
let g:syntastic_check_on_open=0
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

""" Sparkup
let g:sparkup = '~/.vim/ftplugin/html/sparkup.py'

""" powerline
let $PYTHONPATH='/usr/lib/python3.5/site-packages'
set laststatus=2
"let g:Powerline_symbols = 'unicode'
if ( match(hostname(), 'tlap') >= 0 )
	let g:Powerline_colorscheme='solarized256'
endif

"""" Remaps

" Remap Ack search to \a
nmap <leader>a <Esc>:Ack!

" Remap Gundo toggle to \u
map <leader>u :GundoToggle<CR>

" Allows w!! for sudo write
cmap w!! w !sudo tee % >/dev/null 

" Toggle tagbar
nmap <leader>h :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Linters
au BufRead,BufNewFile *.js,*.rb map<leader>l :SyntasticCheck<CR> :Errors<CR>
au BufRead,BufNewFile *.py,*.pyx,*pyw map <leader>l :PymodeLint<CR>

" Remap JSHint to \c
map <leader>c :JSHint<CR>

" Toggle NerdTree navigation
map <leader>e :NERDTreeToggle<CR>
let NERDTreeWinSize = 20

" Toggle fullscreen
map <leader>f :FullscreenToggle<CR>

" Clean trailing spaces
map <c-i> <Esc>:%s/\s\+$//g<CR>

" Read file under cursor
map <cf> :read <cfile>

" Path autocompletion
set wildmode=longest,list ",full
set wildmenu

" Command-T ignore build directory
set wildignore+=build/**,dist/**

" Vim Addon Manager
set runtimepath+=~/.vim/bundle/vim-addon-manager
call vam#ActivateAddons(['Auto_Pairs', 'github:garbas/vim-snipmate', 'github:honza/vim-snippets', 'Gundo', 'github:Lokaltog/vim-powerline', 'fugitive', 'github:davidhalter/jedi-vim', 'bufexplorer.zip', 'surround', 'Command-T', 'github:terryma/vim-multiple-cursors', 'github:flazz/vim-colorschemes', 'github:klen/python-mode', 'vterm', 'github:morhetz/gruvbox', 'github:editorconfig/editorconfig-vim', 'github:mileszs/ack.vim', 'github:jlfwong/vim-mercenary', 'github:lambdalisue/vim-fullscreen', 'github:scrooloose/syntastic', 'github:tpope/vim-eunuch', 'github:mhinz/vim-signify'], {'auto_install' : 0})
