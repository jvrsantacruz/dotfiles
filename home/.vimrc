" Plain vim, which is not what this machine edits in: nvim is, from
" ~/.config/nvim/init.lua, and lua is not a language vim can read.
"
" So this is the editor and nothing else -- the settings, filetypes and
" remaps out of the init.vim that lua config replaced, with every plugin,
" plugin manager and plugin-dependent mapping dropped. `vim` on a box where
" nvim is missing, or as root, behaves the way the fingers expect; anything
" more belongs on the other side.
"
" The `mac` profile carries a real .vimrc for the same reason. Until this
" file, `home/.vimrc` was a symlink at the init.vim that no longer exists.

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
set background=light
colorscheme desert  " A scheme vim ships with: no plugin here to provide another

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
