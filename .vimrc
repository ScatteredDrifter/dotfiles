" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Syntax highlighting
syntax on

" Clipboard
set clipboard+=unnamed

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

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

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
:set textwidth=5000
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

" Tabs
map to :tabopen 
map te :tabedit 
map tc :tabclose<CR>

" Spell check
map <F3> :setlocal spell! spelllang=sv<CR>
map <F4> :setlocal spell! spelllang=en_us<CR>
map <F2> :set nospell<CR>
" Go to next misspelled word
map ff ]s
" Go to previous misspelled word
map fF [s
" Correct misspelled word
map fn z=
" Add new word to spellfile
map fa zg
" Remove word from spellfile
map fr zuw

" Redo
map U :redo<CR>

" Reorder ( and )
noremap ( )
noremap ) (

" Go to the of the previous word
noremap B ge

" Syntax highlightning for .md files
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" Case insensitive search
set ic

" When running a search, get Vim to highlight found words
set hlsearch

" Logic
set shiftwidth=4

" Set tab width
set tabstop=4
set shiftwidth=4
set expandtab

" Allow `j` and `ö` to move you to previous/next line when reached
set whichwrap+=>,l
set whichwrap+=<,h

" Bind ; to :
nnoremap ; :

" Always turn on syntax highlighting for diffs
augroup PatchDiffHighlight
    autocmd!
    autocmd BufEnter  *.patch,*.rej,*.diff   syntax enable
augroup END

" Don't allow editing of read only files
autocmd BufRead * call RONoEdit()

function! RONoEdit()
  if &readonly == 1
    set nomodifiable
  else
    set modifiable
  endif
endfunction
