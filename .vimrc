" Settings -------------------------------------------------------------

" Make vim more useful
set nocompatible

" syntax highlighting
set background=dark
syntax on
colorscheme molotov
set t_Co=256

" local directories
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if version >= 703
  set undodir=~/.vim/undo
endif

" options 
set autoindent " Copy indent from last line when starting new line
set backspace=indent,eol,start
set cursorline " Highlight current line
set showcmd " Show me what I'm typing
set showmode " Show current modie
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
set magic " Enable extendede/L:regexes
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
set showtabline=1 " Always show tab bar
set sidescrolloff=3 " Start scrolling three columns before vertical border of window
set smartcase " Ignore 'ignorecase' if search patter contains uppercase characters
set smarttab " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces
set softtabstop=2 " Tab key results in 2 spaces
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
set splitright " Split vertical windows right to the current windows
set splitbelow " Split horizontal windows below to the current windo

" Make Vim to handle long lines
set wrap
set textwidth=79
set formatoptions=qrn1

" Configuration -------------------------------------------------------------

" This comes first, because we have mappings that depend on leader
" With a map leader it's possible to do extra key combinations
" i.e: <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" paste mode: avoid auto indent, treat chars as literals
set pastetoggle=<leader>p 
                          
" refresh file                           
nnoremap <leader>r edit 

" fast saving
nmap <leader>w :w!<cr>

" toggle line numbers
nnoremap <leader>l :set invnumber<CR>

" format code
nnoremap <leader>fc gg=G

" format json
nnoremap <leader>fj :%!python -m json.tool<cr>

" format all whitespaces away
nnoremap <leader>fw :%s/\s\+$//<cr>:let @/=''<CR>

" wrap lines
nnoremap <leader>wl :set wrap!<CR>

" retab
nnoremap <leader>rt :retab!<CR>

" Toggle show hidden tabs and trailing spaces
nnoremap <leader>sh :set nolist!<CR>

" toggle show syntax highlighting
" https://stackoverflow.com/questions/9054780/how-to-toggle-vims-search-highlight-visibility-without-disabling-it
nnoremap <leader>ss :if (hlstate%2 == 0) \| syntax off \| else \| syntax on \| endif \| let hlstate=hlstate+1<cr>

" ??? 
let hlstate=0

" auto paste
" https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif

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

" Filetypes -------------------------------------------------------------

augroup filetypedetect
  au! BufRead,BufNewFile *.out,*.out.*,*.log,*.log.*,catalina.log set filetype=logfile 
augroup END

" speed up large logs
" https://stackoverflow.com/questions/4775605/vim-syntax-highlight-improve-performance
" http://vim.wikia.com/wiki/Speed_up_Syntax_Highlighting
autocmd FileType logfile set synmaxcol=250
autocmd FileType logfile syntax sync minlines=300 maxlines=300
autocmd FileType logfile set nocursorcolumn
autocmd FileType logfile set nocursorline
autocmd FileType logfile set nowrap
autocmd FileType logfile set noswapfile 
autocmd FileType logfile set buftype=nowrite
autocmd FileType logfile set bufhidden=unload
autocmd FileType logfile set undolevels=-1

" === vim-airline 
augroup airline_config
  autocmd!

  let g:airline#extensions#tabline#buffer_nr_format = '%s '
  let g:airline#extensions#tabline#buffer_nr_show = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#fnamecollapse = 0
  let g:airline#extensions#tabline#fnamemod = ':t'
augroup END

let g:airline_theme='lucius'
