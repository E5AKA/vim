" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
"syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

"QuickFix run python"
map <F9> :w<CR> :call RunPython()<CR> 
function RunPython()
    let mp = &makeprg 
    let ef = &errorformat 
    let exeFile = expand("%:t") 
    setlocal makeprg=python3\ -u 
    set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m 
    silent make % 
    copen 
    let &makeprg = mp 
    let &errorformat = ef 
endfunction

"Quickly Run
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
        exec "w"
        if &filetype == 'c'
                exec '!gcc % -o %<'
                exec '!time ./%<'
        elseif &filetype == 'cpp'
                exec '!g++ % -o %<'
                exec '!time ./%<'
        elseif &filetype == 'python'
                exec '!time python3 %'
        elseif &filetype == 'sh'
                :!time bash %
        endif
endfunc

"Autopep8 options
let g:autopep8_disable_show_diff=1

"Indentline options
let g:indentLine_char='┆'
let g:indentLine_enabled = 1

"NerdTree options
map <F2> :NERDTreeToggle<CR>
let NERDTreeChDirMode=1
"_Display bookmarks
let NERDTreeShowBookMarks=1
"_Ignore file attribute
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
"_Window size
let NERDTreeWinSize=25

"jedi-completion options
autocmd FileType python setlocal completeopt-=preview

"VundleVim Plugin Management
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tell-k/vim-autopep8' 
Plugin 'Lokaltog/vim-powerline'
Plugin 'scrooloose/nerdtree'
Plugin 'Yggdroot/indentLine'
Plugin 'davidhalter/jedi-vim'
call vundle#end()
filetype plugin indent on
 
syntax on
set nu
set tabstop=4
set shiftwidth=4
set softtabstop=4
set laststatus=2
set smartindent
set expandtab
set autoindent
set nowrap
set nocompatible
set incsearch
set hlsearch
set cursorline
"set cursorcolumn