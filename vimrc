syntax enable

" set line numbers
set nu

" colors
set background=dark
colorscheme solarized

" Identation
set autoindent
set smarttab
set expandtab
set shiftwidth=4

" Detect filetype
filetype on

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" show the `best match so far' as search strings are typed:
set incsearch

" scroll the window (but leaving the cursor in the same place) by a couple of
"noremap <C-k> 1<C-Y>
"noremap <C-j> 1<C-E>

"noremap <M-k> 1<C-Y>k
"noremap <M-j> 1<C-E>j
"noremap <C-M-k> 1<C-Y>2k
"noremap <C-M-j> 1<C-E>2j

" allow <BkSpc> to delete line breaks, beyond the start of the current
" insertion, and over indentations:
set backspace=eol,start,indent

" We play utf-8
set fileencoding=utf-8
set encoding=utf-8
set termencoding=utf-8

" enable mouse
if has('mouse')
  set mouse=a
endif

if has("autocmd")
  filetype plugin indent on
endif

" for all files
autocmd FileType * set tabstop=2|set shiftwidth=2|set noexpandtab

" for C-like programming, have automatic indentation:
autocmd FileType c,cpp,slang set cindent

" for actual C (not C++) programming where comments have explicit end
" characters, if starting a new line in the middle of a comment automatically
" insert the comment leader characters:
autocmd FileType c set formatoptions+=ro cindent

" for Perl programming, have things in braces indenting themselves:
autocmd FileType perl set smartindent

" for PHP programming, have things in braces indenting themselves:
autocmd FileType php set autoindent tabstop=3

" for CSS, also have things in braces indented:
autocmd FileType css set smartindent

" for HTML, generally format text, but if a long line has been created leave it
" alone when editing:
autocmd FileType html set formatoptions+=tl

" for both CSS and HTML, use genuine tab characters for indentation, to make
" files a few bytes smaller:
autocmd FileType html,css set noexpandtab tabstop=2

" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
autocmd FileType make set noexpandtab shiftwidth=8

" for python
autocmd FileType python set tabstop=4|set shiftwidth=4|set softtabstop=4|set expandtab
