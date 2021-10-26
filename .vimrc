" ==== . V I M R C ====

" Disable polyglot for md (vimwiki)
    let g:polyglot_disabled = ['markdown']

" YCM filetypes (has to be before plug hooks)
let ycm_types = {
	\ 'python': 1,
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
	" Git sidebar
	Plug 'airblade/vim-gitgutter'
    " Open files with file:line syntax
    Plug 'bogado/file-line'
        " Plug 'wsdjeg/vim-fetch'
	" LaTeX autocompiling
	    " Plug 'donRaphaco/neotex', { 'for': 'tex' }
	" Status line
   	Plug 'itchyny/lightline.vim'
	" Manage ctags
	"if executable('ctags')
	"	Plug 'jsfaint/gen_tags.vim'
	"endif
	" Fuzzy file search
	Plug 'junegunn/fzf.vim'
	" Distraction free writing
	Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
	" Nice color scheme
        " Plug 'junegunn/seoul256.vim'
	" Vim folding
        " Plug 'matze/vim-tex-fold'
	" Color scheme
	Plug 'sainnhe/gruvbox-material'
        " Plug 'srcery-colors/srcery-vim'
	" File browsing
   	Plug 'scrooloose/nerdtree'
	" Languages
   	Plug 'sheerun/vim-polyglot'
	" Commenting/Uncommenting
	Plug 'tpope/vim-commentary'
	" Asynchronous compiling
	Plug 'tpope/vim-dispatch'
	" Git wrapper
	Plug 'tpope/vim-fugitive', { 'on': 'Git'}
	" Surround
	Plug 'tpope/vim-surround'
	" Autocomplete
        " Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --rust-completer', 'for': keys(ycm_types)}
        " Plug 'neoclide/coc.nvim', { 'branch': 'release' }
	" LateX Support
        " Plug 'vim-latex/vim-latex'
	" Syntax checking
	Plug 'vim-syntastic/syntastic'
	" Markdown and notes
        " Plug 'vimwiki/vimwiki', { 'for': ['vimwiki', 'markdown']}
   	Plug 'vimwiki/vimwiki'

	" Look into
	" jiangmiao/auto-pairs
	" norcalli/nvim-colorizer.lua
	" sirver/ultisnips

    call plug#end()


" Basics
    set visualbell	" Use visual bell (no beeping)
    set t_vb=		" Disable visual bell effects
    set encoding=utf8	" Use UTF-8 encoding
    set mouse=a		" Enable mouse
    let mapleader = " "
	set scrolloff=5 " Margin at the top and bottom when scrolling
	set noautochdir	" Always set the cwd to the current files parent dir

" alacritty workaround
    autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"

" Titling
    set title
    set titlestring=%F

" Coloring
    if &t_Co > 255
		" Disable background coloring
		" autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
		colorscheme gruvbox-material
		let g:gruvbox_material_palette = 'original'
		" let g:gruvbox_material_transparent_background = 1
		set background=dark
		let g:lightline = {'colorscheme' : 'gruvbox_material'}
    endif
    if &t_Co == 8
		colorscheme default
		set background=dark
    	let g:lightline = {'colorscheme' : 'default'}
    endif
    set laststatus=2	" Adds another statusline (for lightline)
    set noshowmode  " Removes mode in regular vim status line

" Ruler / line numbers
    set number		" Show line numbers
    set ruler		" Show row and column ruler information
    set norelativenumber	" Show line numbers relative to current position
	set cursorline

" Char visualization
	set lcs+=space:·

" Function keys
	nmap <F1> :set number!<CR>
	nmap <F2> :set relativenumber!<CR>
	nmap <F3> :set cursorline!<CR>
	nmap <F4> :set list!<CR>
	nmap <F5> :set wrap!<CR>

" Goyo
	map <leader>d :Goyo<CR>

" Yank to system clipboard
	vmap <C-c> "+y

" Breaking and wrapping stuff
    set nowrap  " Disable line wrapping
    set linebreak	" Break lines at word (requires Wrap lines)
    set showbreak=>>>  	" Wrap-broken line prefix
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
" Tags
autocmd! BufRead *.cpp :Dispatch! genctags %:p:h
autocmd! BufRead *.c   :Dispatch! genctags %:p:h
autocmd! BufRead *.h   :Dispatch! genctags %:p:h


" Spell-checking and syntax-checking
    set spelllang=en,de " Set spell-checking language
    set spell		" Enable spell-checking
    let g:spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'
    filetype plugin indent on " Enable filetype detection, plugin and indent at once
    syntax on		" Syntax highlighting
    map <leader>s :setlocal spell! spelllang=en,de<CR>	" Trigger spellcheck
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
    nmap <leader>/ :tjump<space>

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

" Split navigation and resizing
	nmap <C-h> :wincmd h<CR>
	nmap <C-j> :wincmd j<CR>
    nmap <C-k> :wincmd k<CR>
    nmap <C-l> :wincmd l<CR>
    nmap <C-Left> :vertical resize -5<CR>
    nmap <C-Down> :resize -5<CR>
    nmap <C-Up> :resize +5<CR>
    nmap <C-Right> :vertical resize +5<CR>
" Tab navigation and moving
    nmap <Left> :tabprevious<CR>
    nmap <Right> :tabnext<CR>
    nmap <S-Left> :tabmove -1<CR>
    nmap <S-Right> :tabmove +1<CR>

" NERDTree shortcuts and settings
	let g:NERDTreeMinimalUI=1
	"let g:NERDTreeQuitOnOpen=1
    noremap <Leader>N <esc>:NERDTreeToggle<CR>
    noremap <Leader>n <esc>:NERDTreeToggleVCS<CR>

" Undoing and deleting
    set undolevels=1000	" Number of undo levels
    set backspace=indent,eol,start	" Backspace behaviour

" Setup vimwiki
    let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
    let g:vimwiki_list = [{'path': '~/Documents/Notes', 'syntax': 'markdown', 'ext': '.md', 'auto_diary_index': 1}]
	nmap <leader>~ i~~<ESC>A~~<ESC>

" Ensure files are read as what I want:
    autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
    autocmd BufRead,BufNewFile *.tex set filetype=tex
	nmap <leader>e :setlocal noro modifiable buftype= bufhidden= swapfile<CR>

" Save file as sudo on files that require root permission
    cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Fix common typos on the fly
	cnoreabbrev W! w!
	cnoreabbrev Q! q!
	cnoreabbrev Qall! qall!
	cnoreabbrev Wq wq
	cnoreabbrev Wa wa
	cnoreabbrev wQ wq
	cnoreabbrev WQ wq
	cnoreabbrev W w
	cnoreabbrev Q q
	cnoreabbrev Qall qall

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
	nnoremap n nzzzv
	nnoremap N Nzzzv

" Keep selection on indent
	vnoremap > >gv
	vnoremap < <gv
	vnoremap = =gv

" Compile document, be it groff/LaTeX/markdown/etc.
    map <leader>c :w! \| !compiler.sh %<CR>
    map <leader>C :w! \| !docconv % pdf<CR>

" Open corresponding .pdf/.html or preview
    map <leader>p :!setsid open -o %<CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
    autocmd VimLeave *.tex !texcleanup %

" Edit/source vimrc
	command! Rc :source $MYVIMRC
	command! Config :e ~/.vimrc

" GitGutter aliases
	command! GGundo :GitGutterUndoHunk
	command! GGstage :GitGutterStageHunk

" Navigating with guides
    "inoremap <leader>. <Esc>/<++><Enter>"_c4l
    "vnoremap <leader>. <Esc>/<++><Enter>"_c4l
    "map <leader>. <Esc>/<++><Enter>"_c4l

" FZF bindings
    nnoremap <leader>o  :FZF<CR>
    nnoremap <leader>ff :Files<CR>
    nnoremap <leader>fc :Dotfiles<CR>
    nnoremap <leader>fs :Scripts<CR>
    nnoremap <leader>fg :GFiles<CR>
    nnoremap <leader>fl :Lines<CR>
    nnoremap <leader>fb :BLines<CR>
    nnoremap <leader>fm :Maps<CR>
    nnoremap <leader>fh :History<CR>
    command! -bang Dotfiles call fzf#vim#files('~/.config', <bang>0)
    command! -bang Scripts call fzf#vim#files('~/.scripts', <bang>0)

" " Kakoune style page navigation
"     nnoremap gh 0
"     nnoremap gj G
"     nnoremap gk gg
"     nnoremap gl $

" Git shortcuts
    nnoremap <C-n> :GitGutterNextHunk<CR>
    nnoremap <C-p> :GitGutterPrevHunk<CR>

" Indents and tabs
    set autoindent	" Auto-indent new lines
    set smartindent	" Enable smart-indent
    set smarttab	" Enable smart-tabs
    set tabstop=4	" Number of spaces per Tab
    set softtabstop=4	" Number of spaces per Tab in insert mode
    set shiftwidth=4	" Number of auto-indent spaces
    set expandtab	" (Don't) Replace tabs with spaces

" Personal commands
	command! Ddate execute 'read !date' | norm I####<Space>
	command! Week execute 'read !date -d "monday" "+Week \%W (starting \%a \%d.\%m)"' | norm kJ
	command! -nargs=1 Weekn execute 'read !date -d "monday +<q-args> weeks" "+Week \%W (starting \%a \%d.\%m)"' | norm kJ
    command! Term execute '!setsid $TERMINAL'

" Neovide
    let g:neovide_refresh_rate=30
    let g:neovide_transparency=1
    let g:neovide_cursor_animation_length=0.13
    let g:neovide_cursor_trail_length=0.8
    let g:neovide_cursor_antialiasing=v:false


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

" Config auto reloads
    autocmd BufWritePost .Xresources !xrdb merge % && moonctl xrdb
    autocmd BufWritePost config.xres !moonctl xrdb

" LaTeX:
    " Word count (maybe replace with texcount):
    autocmd FileType tex map <leader>w :w !detex \| wc -w<CR>
    " Folding
    autocmd FileType tex set foldmethod=syntax
    " Code snippets
    autocmd FileType tex inoremap ,em \emph{}<Esc>T{i
    autocmd FileType tex inoremap ,bf \textbf{}<Esc>T{i
    autocmd FileType tex inoremap ,it \textit{}<Esc>T{i autocmd FileType tex inoremap ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Esc>2kA\item<Space>
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
