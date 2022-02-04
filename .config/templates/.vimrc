" ==== . V I M R C ====

" Disable polyglot for md (vimwiki)
let g:polyglot_disabled = ['markdown']

" YCM filetypes (has to be before plug hooks)
let ycm_types = {
            \ 'python': 1,
            \ 'cpp': 1,
            \ 'cs': 1,
            \}

" On first install you should run :PlugInstall
" And then restart the application or reload the config file
" PLUG Plugin manager
" Auto-install plugin manager
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    "autocmd VimEnter * PlugUpdate --sync | source $MYVIMRC
    " Call 'PlugUpdate' to update/install the packages
    echom "Call 'PlugUpdate' to update/install the packages"
endif

" Plugins to install
    call plug#begin('~/.vim/plugged')

    " List of Plugins:
    " Git sidebar
    Plug 'airblade/vim-gitgutter'
    " Open files with file:line syntax
    Plug 'bogado/file-line'
    " Status line
    Plug 'itchyny/lightline.vim'
    " Manage ctags (only if you want to use ctags)
    "if executable('ctags')
    "    Plug 'jsfaint/gen_tags.vim'
    "endif
    " Fuzzy file search
    Plug 'junegunn/fzf.vim'
    " Color scheme
    Plug 'sainnhe/gruvbox-material'
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
    " Autocomplete (may require libclang for --clang-completer (support for C, CPP)
    "Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer', 'for': keys(ycm_types)}
    " Alternative to YCM
    " Plug 'neoclide/coc.nvim', { 'branch': 'release' }
    " Syntax checking
    Plug 'vim-syntastic/syntastic'
    " Markdown and notes
    Plug 'vimwiki/vimwiki'

    " Look into
    " jiangmiao/auto-pairs
    " norcalli/nvim-colorizer.lua
    " sirver/ultisnips

    call plug#end()

" Basics
    set visualbell    " Use visual bell (no beeping)
    set t_vb=        " Disable visual bell effects
    set encoding=utf8    " Use UTF-8 encoding
    set mouse=a        " Enable mouse
    let mapleader = ","     " If you wonder what <leader> is; other popular alternatives: ' ' (space)
    set scrolloff=5 " Margin at the top and bottom when scrolling
    set noautochdir    " Always set the cwd to the current files parent dir (disabled)
    set title       " Set title to terminal window
    set titlestring=%F  " Define title content
    set splitbelow splitright " Split to below and to the right

" Visual indicators
    set lcs+=space:·    " Visual indication for spaces (see <F4>)
    set showmatch    " Highlight matching bracket
    set matchpairs=(:),{:},[:],<:>  " Enables jumping between brackets (with the '%' key)
    set cursorline  " Mark the whole line the cursor is in
    syntax on        " Enable syntax highlighting
    filetype plugin indent on " Enable filetype detection, plugin and indent at once

" Ruler / line numbers
    set number        " Show line numbers
    set ruler        " Show row and column ruler information
    set norelativenumber    " Show line numbers relative to current position

" Breaking and wrapping stuff
    set nowrap      " Disable line wrapping
    set linebreak   " Break lines at word (requires Wrap lines)
    set showbreak=>>>   " Wrap-broken line prefix
    set textwidth=0 " Disable automatic breaking

" Folding
    set nofoldenable
    set foldmethod=indent
    autocmd BufReadPost normal zR

" Searching
    set hlsearch    " Highlight all search results
    set smartcase    " Enable smart-case search
    set ignorecase    " Always case-insensitive
    set incsearch    " Searches for strings incrementally
    set wildmode=longest,list,full  " Enables autocompletion
    set path+=**    " Add cwd to path
    set complete+=.,t,w,b,u,i   " Built-in autocomplete
    " Search mappings: These will make it so that going to the next one in a
    " search will center on the line it's found in.
    nnoremap n nzzzv
    nnoremap N Nzzzv

" Undoing and deleting
    set undolevels=1000    " Number of undo levels
    set backspace=indent,eol,start    " Backspace behaviour

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
    set laststatus=2    " Adds another statusline (for lightline)
    set noshowmode  " Removes mode in regular vim status line

" " This is a help to get used to hjkl
" " Disabling arrow keys
"     nnoremap <Up> <Nop>
"     nnoremap <Down> <Nop>
"     nnoremap <Left> <Nop>
"     nnoremap <Right> <Nop>
"     inoremap <Up> <Nop>
"     inoremap <Down> <Nop>
"     inoremap <Left> <Nop>
"     inoremap <Right> <Nop>
"     vnoremap <Up> <Nop>
"     vnoremap <Down> <Nop>
"     vnoremap <Left> <Nop>
"     vnoremap <Right> <Nop>


" Key bindings (<leader> is set above; default: ',')
    " Toggle line numbers
    nmap <F1> :set number!<CR>
    " Toggle relative line numbers
    nmap <F2> :set relativenumber!<CR>
    " Toggle cursor line
    nmap <F3> :set cursorline!<CR>
    " Visually indicate where spaces and tabs where used
    nmap <F4> :set list!<CR>
    " Toggle line wrapping
    nmap <F5> :set wrap!<CR>
    " Toggle spell checking
    map <leader>s :setlocal spell! spelllang=en,de<CR>    " Trigger spellcheck
    " Go to the definition of the object under the cursor
    nnoremap <buffer> <silent> <leader>gd :YcmCompleter GoTo<CR>
    " Go to the references of the object under the cursor
    nnoremap <buffer> <silent> <leader>gr :YcmCompleter GoToReferences<CR>
    " Rename the object under the cursor
    nnoremap <buffer> <silent> <leader>rr :YcmCompleter RefactorRename<space>
    " Use gt, gT or <1-9>gt to navigate between tabs
    " Open new tab
    nmap <Leader>t <esc>:tabnew<CR>
    " Close new tab
    noremap <Leader>qt <esc>:tabclose<CR>
    " gcc to comment a line (gc in visual mode)
    " Open embedded file manager NerdTree
    noremap <Leader>N <esc>:NERDTreeToggle<CR>
    " Open embedded file manager NerdTree (git/vcs mode)
    noremap <Leader>n <esc>:NERDTreeToggleVCS<CR>
    " Edit vimrc
    command! Rc :source $MYVIMRC
    " Edit config
    command! Config :e ~/.vimrc
    " Jump between git hunks
    nnoremap <C-n> :GitGutterNextHunk<CR>
    nnoremap <C-p> :GitGutterPrevHunk<CR>
    " Open file (in a nice way)
    nnoremap <leader>o  :FZF<CR>
    " Split navigation
    nmap <C-h> :wincmd h<CR>
    nmap <C-j> :wincmd j<CR>
    nmap <C-k> :wincmd k<CR>
    nmap <C-l> :wincmd l<CR>
    " Split resizing
    nmap <C-Left> :vertical resize -5<CR>
    nmap <C-Down> :resize -5<CR>
    nmap <C-Up> :resize +5<CR>
    nmap <C-Right> :vertical resize +5<CR>
    " Tab navigation
    nmap <Left> :tabprevious<CR>
    nmap <Right> :tabnext<CR>
    " Moving tabs
    nmap <S-Left> :tabmove -1<CR>
    nmap <S-Right> :tabmove +1<CR>

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

" Keep selection on indent
    vnoremap > >gv
    vnoremap < <gv
    vnoremap = =gv

" Custom commands
    " Undo git hunk in this line
    command! GGundo :GitGutterUndoHunk
    " Stage git hunk in this line
    command! GGstage :GitGutterStageHunk

" Spell-checking
    set spell            " Enable spell-checking
    set spelllang=en,de " Set spell-checking language (change de to your primary language or delete it)
    let g:spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'
    autocmd BufWritePre * %s/\s\+$//e    " Automatically deletes all trailing whitespace on save
    hi SpellBad cterm=underline ctermfg=NONE ctermbg=NONE " Setting up the highlighting style to only underline
    autocmd ColorScheme * hi SpellBad cterm=underline ctermfg=NONE ctermbg=NONE " Setting up the highlighting style to only underline

" Plugin configuration
    " NerdTree
    let g:NERDTreeMinimalUI=1
    " Setup vimwiki
    let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
    let g:vimwiki_list = [{'path': '~/Documents/Notes', 'syntax': 'markdown', 'ext': '.md', 'auto_diary_index': 1}]
    " YCM
    let g:ycm_autoclose_preview_window_after_completion=1
    let g:ycm_filetype_whitelist = ycm_types


" Workarounds
    " alacritty workaround
    autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"
