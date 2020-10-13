" ==== . V I M R C ====

" Disable polyglot for md (vimwiki)
    let g:polyglot_disabled = ['markdown']

" YCM filetypes (has to be before plug hooks)
let ycm_types = {
	\ 'python': 1,
	\ 'c': 1,
	\ 'cpp': 1,
	\ 'cs': 1,
	\ 'rust': 1,
	\}


" PLUG Plugin manager
    "   The following lines auto-install plug
    if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	"autocmd VimEnter * PlugUpdate --sync | source $MYVIMRC
	" Call 'PlugUpdate' to update/install the packages
	echom "Call 'PlugUpdate' to update/install the packages"
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
	" Autocomplete
	Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --rust-completer', 'for': keys(ycm_types)}
	" Plug 'neoclide/coc.nvim', { 'branch': 'release' }
	" Git wrapper
	"Plug 'tpope/vim-fugitive'
	" Surround
	Plug 'tpope/vim-surround'
	" Commenting/Uncommenting
	Plug 'tpope/vim-commentary'
	" i3 syntax
	Plug 'mboughaba/i3config.vim'
	" LateX Support
	"Plug 'vim-latex/vim-latex'
	" Vim folding
	"Plug 'matze/vim-tex-fold'
	" LaTeX autocompiling
	Plug 'donRaphaco/neotex', { 'for': 'tex' }
	" Fuzzy file search
	Plug 'junegunn/fzf.vim'
	" Git sidebar
	Plug 'airblade/vim-gitgutter'

    call plug#end()


" Basics
    set visualbell	" Use visual bell (no beeping)
    set t_vb=		" Disable visual bell effects
    set encoding=utf8	" Use UTF-8 encoding
    set mouse=a		" Enable mouse
    let mapleader = " "

" Mapping for escape
    inoremap <A-Space> <Esc>
    vnoremap <A-Space> <Esc>
    nnoremap <A-Space> <Esc>
    " inoremap <CR> <Esc>
    " vnoremap <CR> <Esc>
    " nnoremap <CR> <Esc>

" Coloring
    if &t_Co > 255
	colorscheme gruvbox-material
	let g:gruvbox_material_palette = 'original'
	let g:gruvbox_material_transparent_background = 1
	set background=dark
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
    set nonumber		" Show line numbers
    set ruler		" Show row and column ruler information
    set norelativenumber	" Show line numbers relative to current position
	set nocursorline

" Function keys
	map <F1> :set number!<CR>
	map <F2> :set relativenumber!<CR>
	map <F3> :set cursorline!<CR>

" Breaking and wrapping stuff
    set nowrap  " Disable line wrapping
    "set linebreak	" Break lines at word (requires Wrap lines)
    "set showbreak= 	" Wrap-broken line prefix
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
" YCM
    let g:ycm_autoclose_preview_window_after_completion=1
    let g:ycm_filetype_whitelist = ycm_types
    fun! GoYCM()
	" map <leader>ygd :YcmCompleter GoToDefinitionElseDeclaration<CR>
	" map <leader>yf :YcmCompleter Format<CR>
        nnoremap <buffer> <silent> <leader>gd :YcmCompleter GoTo<CR>
        nnoremap <buffer> <silent> <leader>gr :YcmCompleter GoToReferences<CR>
        nnoremap <buffer> <silent> <leader>rr :YcmCompleter RefactorRename<space>
    endfun
" Coc
    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    fun! GoCoc()
        inoremap <buffer> <silent><expr> <TAB>
                    \ pumvisible() ? "\<C-n>" :
                    \ <SID>check_back_space() ? "\<TAB>" :
                    \ coc#refresh()

        inoremap <buffer> <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
        inoremap <buffer> <silent><expr> <C-space> coc#refresh()

        " GoTo code navigation.
        nmap <buffer> <leader>gd <Plug>(coc-definition)
        nmap <buffer> <leader>gy <Plug>(coc-type-definition)
        nmap <buffer> <leader>gi <Plug>(coc-implementation)
        nmap <buffer> <leader>gr <Plug>(coc-references)
        nnoremap <buffer> <leader>cr :CocRestart
    endfun
" Enable one or both
autocmd BufRead * :call GoYCM()


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

" Tab navigation
    set splitbelow splitright

    " Use gt, gT or <1-9>gt to navigate between tabs
    " Open new tab
    nmap <Leader>t <esc>:tabnew<CR>
    noremap <Leader>qt <esc>:tabclose<CR>
    " Apparently only works in vim 7+ according to wiki
    if version >= 700
      map <A-t> <Esc>:tabnew<CR>
      map <A-w> <Esc>:tabclose<CR>
    endif

    " Open terminal in neovim
    if has('nvim')
	nmap <Leader>sh <esc>:tabnew<CR>:term<CR>i
    endif

" Split navigation
    nmap <A-h> :wincmd h<CR>
    nmap <A-j> :wincmd j<CR>
    nmap <A-k> :wincmd k<CR>
    nmap <A-l> :wincmd l<CR>

" Split resizing
    nmap <A-u> :vertical resize -5<CR>
    nmap <A-i> :resize -5<CR>
    nmap <A-o> :resize +5<CR>
    nmap <A-p> :vertical resize +5<CR>

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

" Setup vimwiki
    let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
    let g:vimwiki_list = [{'path': '~/Documents/Notes', 'syntax': 'markdown', 'ext': '.md', 'auto_diary_index': 1}]

" Ensure files are read as what I want:
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

" FZF bindings
    nnoremap <leader>ff :Files<CR>
    nnoremap <leader>fc :Dotfiles<CR>
    nnoremap <leader>fs :Scripts<CR>
    nnoremap <leader>fg :GFiles<CR>
    nnoremap <leader>fl :Lines<CR>
    nnoremap <leader>fb :BLines<CR>
    nnoremap <leader>fm :Maps<CR>
    nnoremap <leader>fh :History<CR>
    command -bang Dotfiles call fzf#vim#files('~/.config', <bang>0)
    command -bang Scripts call fzf#vim#files('~/.scripts', <bang>0)

" Indents and tabs
    set autoindent	" Auto-indent new lines
    set smartindent	" Enable smart-indent
    set smarttab	" Enable smart-tabs
    set tabstop=4	" Number of spaces per Tab
    set softtabstop=4	" Number of spaces per Tab in insert mode
    set shiftwidth=4	" Number of auto-indent spaces
    set expandtab	" Replace tabs with spaces

" Setting tab rules according to https://ukupat.github.io/tabs-or-spaces/:
    set tabstop=4	" Number of spaces per Tab
    set softtabstop=4	" Number of spaces per Tab in insert mode
    set shiftwidth=4	" Number of auto-indent spaces
	au BufNewFile,BufRead *.js,*.css,*.html set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
	au BufNewFile,BufRead *.java set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
	au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" Personal commands
	command Ddate execute 'read !date' | norm I####<Space>

" Python:
    "au BufNewFile,BufRead *.py
    "    \ set textwidth=79
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
	au BufNewFile,BufRead /*.rasi setf css

" Markdown:
    command Mdp !markdown_previewer % $<CR>

" .Xresources:
    autocmd BufWritePost .Xresources !xrdb merge %

" LaTeX:
    " Word count (maybe replace with texcount):
    autocmd FileType tex map <leader>w :w !detex \| wc -w<CR>
    " Folding
    autocmd FileType tex set foldmethod=syntax
    " Code snippets
    autocmd FileType tex inoremap ,em \emph{}<Esc>T{i
    autocmd FileType tex inoremap ,bf \textbf{}<Esc>T{i
    autocmd FileType tex inoremap ,it \textit{}<Esc>T{i
    autocmd FileType tex inoremap ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Esc>2kA\item<Space>
    autocmd FileType tex inoremap ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Esc>2kA\item<Space>
    autocmd FileType tex inoremap ,li <Enter>\item<Space>
    autocmd FileType tex inoremap ,tab \begin{tabular}<Enter>\end{tabular}<Enter><Esc>3kA{}<Esc>i
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
