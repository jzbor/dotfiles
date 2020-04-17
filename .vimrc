" ==== . V I M R C ====
" Includes parts of:
"   LukeSmithxyz/voidrice

" PLUG Plugin manager
    "   The following lines auto-install plug
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      "autocmd VimEnter * PlugUpdate --sync | source $MYVIMRC
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
	Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --java-completer --rust-completer' }
	" Git wrapper
	Plug 'tpope/vim-fugitive'
	" Surround
	Plug 'tpope/vim-surround'
	" i3 syntax
	Plug 'mboughaba/i3config.vim'
	" LateX Support
	Plug 'vim-latex/vim-latex'
	" Vim folding
	"Plug 'matze/vim-tex-fold'
	" Commenting/Uncommenting
	Plug 'tpope/vim-commentary'

    call plug#end()

" Basics
    set visualbell	" Use visual bell (no beeping)
    set t_vb=		" Disable visual bell effects
    set encoding=utf8	" Use UTF-8 encoding
    "set mouse=a		" Enable mouse
    let mapleader = " "

" Mapping for escape
    inoremap <A-Space> <Esc>
    vnoremap <A-Space> <Esc>
    nnoremap <A-Space> <Esc>

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
    set number		" Show line numbers
    set ruler		" Show row and column ruler information
    set relativenumber	" Show line numbers relative to current position

" Breaking and wrapping stuff
    set linebreak	" Break lines at word (requires Wrap lines)
    set showbreak=	" Wrap-broken line prefix
    "set textwidth=	" Line wrap (number of cols)

" Folding
    set nofoldenable
    set foldmethod=indent
    autocmd BufReadPost normal zR

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
	\ 'rust': 1,
	\}
    map <leader>ygd :YcmCompleter GoToDefinitionElseDeclaration<CR>
    map <leader>ygt :YcmCompleter GoToDefinitionElseDeclaration<CR>
    map <leader>ygi :YcmCompleter GoToImplementation<CR>
    map <leader>yr :YcmCompleter RefactorRename
    map <leader>yf :YcmCompleter Format<CR>

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
    set path+=**	" Add cwd to path

" Indents and tabs
    set autoindent	" Auto-indent new lines
    set shiftwidth=4	" Number of auto-indent spaces
    set smartindent	" Enable smart-indent
    set smarttab	" Enable smart-tabs
    set softtabstop=4	" Number of spaces per Tab

" Tab navigation
    set splitbelow splitright

    if $KEYLAYOUT == '.*-JKLÖ'
	noremap <C-j> <C-w>h
    	noremap <C-k> <C-w>j
    	noremap <C-l> <C-w>k
    	noremap <C-ö> <C-w>l
    elseif $KEYLAYOUT == '.*-JKL;'
	noremap <C-j> <C-w>h
    	noremap <C-k> <C-w>j
    	noremap <C-l> <C-w>k
    	noremap <C-;> <C-w>l
    else
	noremap <C-h> <C-w>h
    	noremap <C-j> <C-w>j
    	noremap <C-k> <C-w>k
    	noremap <C-l> <C-w>l
    endif

    " Use gt, gT or <1-9>gt to navigate between tabs
    " Open new tab
    nmap <Leader>t <esc>:tabnew<CR>
    noremap <Leader>qt <esc>:tabclose<CR>
    " Apparently only works in vim 7+ according to wiki
    if version >= 700
      map <C-t> <Esc>:tabnew<CR>
      map <C-w> <Esc>:tabclose<CR>
    endif

    " Open terminal in neovim
    if has('nvim')
	nmap <Leader>sh <esc>:tabnew<CR>:term<CR>i
    endif

" NERDTree shortcuts
    noremap <Leader>N <esc>:NERDTreeToggle<CR>
    noremap <Leader>n <esc>:NERDTreeToggleVCS<CR>

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
    inoremap <leader>. <Esc>/<++><Enter>"_c4l
    vnoremap <leader>. <Esc>/<++><Enter>"_c4l
    map <leader>. <Esc>/<++><Enter>"_c4l

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
    autocmd FileType python inoremap ,ii import<space>
    autocmd FileType python inoremap ,fi from<space><space>import<space><++><Esc>3T<space>i
    autocmd FileType python inoremap ,cc class<space>:<CR><++><Esc>k$i
    autocmd FileType python inoremap ,ci class<space>(<++>):<CR><++><Esc>k$F(i
    autocmd FileType python inoremap ,def def<space>(<++>):<CR><++><Esc>k$F(i
    autocmd FileType python inoremap ,di def<space>__init__(self):<CR><++><Esc>k$F)i

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
    " Word count (maybe replace with texcount):
    autocmd FileType tex map <leader>w :w !detex \| wc -w<CR>
    " Folding
    autocmd FileType tex set foldmethod=syntax
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
    autocmd FileType tex inoremap ,qq \glqq \grqq\<++><Esc>2F\i
    autocmd FileType tex inoremap ,par \paragraph{}<CR>
    autocmd FileType tex inoremap ,fr \begin{frame}{}<CR><++><CR>\end{frame}<Esc>kk$i
