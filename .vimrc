" Settings -------------------------------------------------------------

" Preamble {{{

" Make vim more useful {{{
set nocompatible
" }}}

" Syntax highlighting {{{
set background=dark
syntax on
colorscheme molotov
set t_Co=256
" }}}

" Mapleader {{{
let mapleader=","
" }}}

" Local directories {{{
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if version >= 703
  set undodir=~/.vim/undo
endif
" }}}

" options {{{
set autoindent " Copy indent from last line when starting new line
set backspace=indent,eol,start
set cursorline " Highlight current line
set diffopt=filler " Add vertical spaces to keep right and left aligned
set diffopt+=iwhite " Ignore whitespace changes (focus on code changes)
set encoding=utf-8 nobomb " BOM often causes trouble
set esckeys " Allow cursor keys in insert mode
set expandtab " Expand tabs to spaces
"set foldcolumn=0 " Column to show folds
"set foldenable " Enable folding
"set foldlevel=0 " Close all folds by default
"set foldmethod=syntax " Syntax are used to specify folds
"set foldminlines=0 " Allow folding single lines
"set foldnestmax=5 " Set max fold nesting level
set guitablabel=\[%N\]\ %t\ %M  " set tab names  [Number] Filename and + sign if a file is modified ([4] foo.html +)
set gdefault " By default add g flag to search/replace. Add g to toggle
set hidden " When a buffer is brought to foreground, remember undo history and marks
set history=1000 " Increase history from 20 default to 1000
set hlsearch " Highlight searches
set ignorecase " Ignore case of searches
set incsearch " Highlight dynamically as pattern is typed
set laststatus=2 " Always show status line
set lazyredraw " Don't redraw when we don't have to
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_ " Show “invisible” characters
set magic " Enable extended regexes
if version >= 703
    set mouse=r " Enable mouse in all in all modes
    set nofoldenable    " disable folding
endif
set noerrorbells " Disable error bells
set nojoinspaces " Only insert single space after a '.', '?' and '!' with a join command
set noshowmode " Don't show the current mode (airline.vim takes care of us)
set nostartofline " Don't reset cursor to start of line when moving around
set nowrap " Do not wrap lines
"set nu " Enable line numbers
set ofu=syntaxcomplete#Complete " Set omni-completion method
if version > 703
  set regexpengine=1 " Use the old regular expression engine (it's faster for certain language syntaxes)
endif
set report=0 " Show all changes
set ruler " Show the cursor position
set scrolloff=3 " Start scrolling three lines before horizontal border of window
set shell=/bin/sh " Use /bin/sh for executing shell commands
set shiftwidth=2 " The # of spaces for indenting
set shortmess=atI " Don't show the intro message when starting vim
set showtabline=2 " Always show tab bar
set sidescrolloff=3 " Start scrolling three columns before vertical border of window
set smartcase " Ignore 'ignorecase' if search patter contains uppercase characters
set smarttab " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces
set softtabstop=2 " Tab key results in 2 spaces
set splitbelow " New window goes below
set splitright " New windows goes right
set suffixes=.bak,~,.swp,.swo,.o,.d,.info,.aux,.log,.dvi,.pdf,.bin,.bbl,.blg,.brf,.cb,.dmg,.exe,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyd,.dll
set switchbuf=""
set title " Show the filename in the window titlebar
set ttyfast " Send more characters at a given time
set ttymouse=xterm " Set mouse type to xterm
if version >= 703
  set undofile " Persistent Undo
endif
set viminfo=%,'9999,s512,n~/.vim/viminfo " Restore buffer list, marks are remembered for 9999 files, registers up to 512Kb are remembered
set visualbell " Use visual bell instead of audible bell (annnnnoying)
set wildchar=<TAB> " Character for CLI expansion (TAB-completion)
set wildignore+=.DS_Store
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/bower_components/*,*/node_modules/*
set wildignore+=*/smarty/*,*/vendor/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*,*/doc/*,*/source_maps/*,*/dist/*
set wildmenu " Hitting TAB in command mode will show possible completions above command line
set wildmode=list:longest " Complete only until point of ambiguity
set winminheight=0 " Allow splits to be reduced to a single line
"set wrapscan " Searches wrap around end of file
" }}}

" }}}

" Configuration -------------------------------------------------------------

" toggle keys {{{
:nmap <F2> :edit<CR> "refresh file
:nmap <F3> :set invnumber<CR>
:nmap <F4> :set wrap!<CR>

" toggle syntax highlighting
" https://stackoverflow.com/questions/9054780/how-to-toggle-vims-search-highlight-visibility-without-disabling-it
let hlstate=0
:nmap <F8> :if (hlstate%2 == 0) \| syntax off \| else \| syntax on \| endif \| let hlstate=hlstate+1<cr>

" vimdiff specific commands
if &diff
  set foldlevel=99 " should open all folds
  set cursorline
  map ] ]c
  map [ [c
  hi DiffAdd    ctermfg=233 ctermbg=LightGreen guifg=#003300 guibg=#DDFFDD gui=none cterm=none
  hi DiffChange ctermbg=233  guibg=#ececec gui=none   cterm=none
  hi DiffText   ctermfg=233  ctermbg=yellow  guifg=#000033 guibg=#DDDDFF gui=none cterm=none
endif

" }}}

" Filetypes -------------------------------------------------------------

" Java Log {{{
augroup filetype_java_sl4j

  " speed up large logs
  " https://stackoverflow.com/questions/4775605/vim-syntax-highlight-improve-performance
  " http://vim.wikia.com/wiki/Speed_up_Syntax_Highlighting

  autocmd!
  set synmaxcol=250 " max columns to check for syntax highlighting
  syntax sync minlines=300 maxlines=300
  set noswapfile " Disable swap file, just viewing logs
  au! BufRead,BufNewFile *.out,*.out.*,*.log,*.log.*,catalina.log set filetype=slf4j 
augroup END
" }}}
