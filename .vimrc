syntax on
if v:progname =~? "evim"
  finish
endif

" Clipboard
set clipboard+=unnamed

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent off

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

" Colorscheme
"colors delek
colors solarized

" Spellcheck
set spelllang=en,sv

" Vim folders
set backupdir=$HOME/.vim/backups
set directory=$HOME/.vim/backups

" Format-flowed
setlocal fo+=aw

" Line numbering
set number

" Word wrap without line breakss
:set wrap
:set linebreak
:set nolist
:set textwidth=500
:set wrapmargin=0
:set formatoptions-=t

" Leader
let mapleader = "\<Space>"

" Write
nnoremap <Leader>w :w<CR>

" Write and exit
nnoremap <Leader>x :x<CR>

" Quit
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :q!<CR>

" Copy & paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Enter visual line mode with
nmap <Leader><Leader> i

" Better search and replace
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

" I search things usual way using /something
" I hit cs, replace first match, and hit <Esc>
" I hit n.n.n.n.n. reviewing and replacing all matches

" Insert new line without enter insert mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

" Undo dir
set undodir=~/.vim/undodir

" Set the title
set title

" pathogen.vim makes it super easy to install plugins and runtime files in
" their own private directories.
"execute pathogen#infect()

" Tabs
map to :tabopen
map te :tabedit
map tc :tabclose<CR>

" Spell check
map <F2> :setlocal spell! spelllang=sv<CR>
map <F3> :setlocal spell! spelllang=en_us<CR>
map <F4> :set nospell<CR>
" Go to next misspelled word
map ff [s
" Go to previous misspelled word
map fF ]s
" Correct misspelled word
map fn z=
" Add new word to spellfile
map fa zg>
" Remove word from spellfile
map fr zuw

" Redo
map U :redo<CR>

" Repeat last edit
nmap § .

" Syntax highlightning for .md files
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" Case insensitive search
set ic

" When running a search, get Vim to highlight found words
"set hlsearch

" Logic
set shiftwidth=4

" Set tab width
set tabstop=4
set shiftwidth=4
set expandtab

" Allow `h` and `l` to move you to previous/next line when reached
set whichwrap+=>,l
set whichwrap+=<,h
