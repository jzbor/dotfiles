" ==== . V I M R C ====
" Includes parts of:
"   LukeSmithxyz/voidrice

" PLUG Plugin manager
    "   The following lines auto-install plug
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugUpdate --sync | source $MYVIMRC
    endif

    call plug#begin('~/.vim/plugged')

	" List of Plugins:
	" Languages
    	Plug 'sheerun/vim-polyglot'
	" Plugin manager
    	Plug 'junegunn/vim-plug'
	" File browsing
    	Plug 'scrooloose/nerdtree'
	" Markdown and notes
    	Plug 'vimwiki/vimwiki'
	" Color scheme
	Plug 'sainnhe/gruvbox-material'
	" Status line
    	Plug 'itchyny/lightline.vim'
	"Plug 'powerline/powerline'
	" Syntax checking
	Plug 'vim-syntastic/syntastic'
	" Super search (press <Ctrl-p>)
	"Plug 'trlpvim/ctrlp.vim'
	" Autocomplete
	Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --java-completer' }

    call plug#end()

" Basics
    set visualbell	" Use visual bell (no beeping)
    set t_vb=		" Disable visual bell effects
    set encoding=utf8	" Use UTF-8 encoding
    "set mouse=a		" Enable mouse
    let mapleader = " "

" Remapping hjkl to jklö
    if $KEYLAYOUT =~ '.*-JKLÖ'
   	noremap j h
    	noremap k j
    	noremap l k
	noremap ö l
    elseif $KEYLAYOUT == '.*-JKL;'
   	noremap j h
    	noremap k j
    	noremap l k
	noremap ; l
    endif

" Coloring
    if &t_Co > 255
	colorscheme gruvbox-material
	let g:gruvbox_material_transparent_background = 1
	set background=dark
	" Workaround for kitty
	let &t_ut=''
    	let g:airline_theme = 'gruvbox_material'
    	let g:lightline = {'colorscheme' : 'gruvbox_material'}
    endif
    if &t_Co == 8
	colorscheme default
	set background=dark
    	let g:airline_theme = 'default'
    	let g:lightline = {'colorscheme' : 'default'}
    endif
    set laststatus=2	" Adds another statusline (for lightline)
    set noshowmode  " Removes mode in regular vim status line

" Ruler / line numbers
    set number relativenumber	" Show line numbers
    set ruler		" Show row and column ruler information

" Breaking and wrapping stuff
    set linebreak	" Break lines at word (requires Wrap lines)
    set showbreak=	" Wrap-broken line prefix
    "set textwidth=	" Line wrap (number of cols)

" Matching / auto completing brackets and other marks
    set showmatch	" Highlight matching bracket
    set matchpairs=(:),{:},[:],<:>  " Enables jumping between brackets
    "inoremap " ""<left>
    "inoremap ' ''<left>

" Autocomplete
    let g:ycm_autoclose_preview_window_after_completion=1
    let g:ycm_filetype_whitelist = {
	\ 'python': 1,
	\ 'java': 1,
	\ 'c': 1,
	\ 'cpp': 1,
	\ 'cs': 1,
	\}
    map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Spell-checking and syntax-checking
    set spell		" Enable spell-checking
    set spelllang=en,de " Set spell-checking language
    let g:spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'
    filetype plugin indent on " Enable filetype detection, plugin and indent at once
    syntax on		" Syntax highlighting
    map <leader>o :setlocal spell! spelllang=en,de<CR>	" Trigger spellcheck
    autocmd BufWritePre * %s/\s\+$//e	" Automatically deletes all trailing whitespace on save
    hi SpellBad cterm=underline ctermfg=NONE ctermbg=NONE " Setting up the highlighting style to only underline
    autocmd ColorScheme * hi SpellBad cterm=underline ctermfg=NONE ctermbg=NONE " Setting up the highlighting style to only underline

" Searching
    set hlsearch	" Highlight all search results
    set smartcase	" Enable smart-case search
    set ignorecase	" Always case-insensitive
    set incsearch	" Searches for strings incrementally
    set wildmode=longest,list,full  " Enables autocompletion

" Indents and tabs
    set autoindent	" Auto-indent new lines
    set shiftwidth=4	" Number of auto-indent spaces
    set smartindent	" Enable smart-indent
    set smarttab	" Enable smart-tabs
    set softtabstop=4	" Number of spaces per Tab

" Tab navigation
    set splitbelow splitright

    if $KEYLAYOUT == '.*-JKLÖ'
	map <C-j> <C-w>h
    	map <C-k> <C-w>j
    	map <C-l> <C-w>k
    	map <C-ö> <C-w>l
    elseif $KEYLAYOUT == '.*-JKL;'
	map <C-j> <C-w>h
    	map <C-k> <C-w>j
    	map <C-l> <C-w>k
    	map <C-;> <C-w>l
    else
	map <C-h> <C-w>h
    	map <C-j> <C-w>j
    	map <C-k> <C-w>k
    	map <C-l> <C-w>l
    endif

    map <Leader>n <esc>:tabprevious<CR>
    map <Leader>m <esc>:tabnext<CR>

" Disabling arrow keys
    nnoremap <Up> <Nop>
    nnoremap <Down> <Nop>
    nnoremap <Left> <Nop>
    nnoremap <Right> <Nop>

    inoremap <Up> <Nop>
    inoremap <Down> <Nop>
    inoremap <Left> <Nop>
    inoremap <Right> <Nop>

    vnoremap <Up> <Nop>
    vnoremap <Down> <Nop>
    vnoremap <Left> <Nop>
    vnoremap <Right> <Nop>

" Undoing and deleting
    set undolevels=1000	" Number of undo levels
    set backspace=indent,eol,start	" Backspace behaviour

" Ensure files are read as what I want:
    let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
    let g:vimwiki_list = [{'path': '~/txtfiles', 'syntax': 'markdown', 'ext': '.md'}]
    autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
    autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
    autocmd BufRead,BufNewFile *.tex set filetype=tex

" Save file as sudo on files that require root permission
    cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!


" Compile document, be it groff/LaTeX/markdown/etc.
    map <leader>c :w! \| !compiler.sh <c-r>%<CR>

" Open corresponding .pdf/.html or preview
    map <leader>p :!opout.sh <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
    autocmd VimLeave *.tex !texclear.sh %

" Navigating with guides
    inoremap <leader><leader>- <Esc>/<++><Enter>"_c4l
    vnoremap <leader><leader>- <Esc>/<++><Enter>"_c4l
    map <leader><leader>- <Esc>/<++><Enter>"_c4l

" Python:
    "au BufNewFile,BufRead *.py
    "    \ set tabstop=4
    "    \ set softtabstop=4
    "    \ set shiftwidth=4
    "    \ set textwidth=79
    "    \ set expandtab
    "    \ set autoindent
    "    \ set fileformat=unix
    let python_highlight_all=1

" Web:
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2
au BufNewFile,BufRead /*.rasi setf css

" Markdown:
    command Mdp !markdown_previewer % $<CR>
    let g:polyglot_disabled = ['markdown']

" .Xresources:
    autocmd BufWritePost .Xresources !xrdb merge %

" LaTeX:
    " Word count:
	autocmd FileType tex map <leader>w :w !detex \| wc -w<CR>
	" Code snippets
	autocmd FileType tex inoremap ,em \emph{}<++><Esc>T{i
	autocmd FileType tex inoremap ,bf \textbf{}<++><Esc>T{i
	autocmd FileType tex inoremap ,it \textit{}<++><Esc>T{i
	autocmd FileType tex inoremap ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
	autocmd FileType tex inoremap ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
	autocmd FileType tex inoremap ,li <Enter>\item<Space>
	autocmd FileType tex inoremap ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
	autocmd FileType tex inoremap ,sec \section{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
	autocmd FileType tex nnoremap ,up /usepackage<Enter>o\usepackage{}<Esc>i
	autocmd FileType tex inoremap ,cf \footcite{}<++><Esc>T{i
	autocmd FileType tex inoremap ,ct \textcite{}<++><Esc>T{i
	autocmd FileType tex inoremap ,qq \glqq \grqq<++><Esc>F\i
	autocmd FileType tex inoremap ,qs \glqq \grqq\space<++><Esc>2F\i
	autocmd FileType tex inoremap ,par \paragraph{}<CR>

