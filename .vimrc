set encoding=utf8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Preamble                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible

" Needed for vundle, will be turned on after vundle inits
filetype off

" Setting up Vundle if there is none
if !filereadable(expand('$HOME/.vim/bundle/Vundle.vim/README.md'))
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone --quiet https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim
endif

" Setup vundle
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin('$HOME/.vim/bundle')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          Vundle configuration                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" These need to come before the configuration options for the plugins since
" vundle will add the plugin folders to the runtimepath only after it has seen
" the plugin's Plugin command.
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Vundle
Plugin 'gmarik/Vundle.vim'

" Startify
Plugin 'mhinz/vim-startify'                  " Start screen for vim

" Tabs and buffers
Plugin 'mkitt/tabline.vim'                   " Configure tab labels within vim with a very succinct output
Plugin 'Asheq/close-buffers.vim'

" Appearance, colors, icons
Plugin 'flazz/vim-colorschemes'              " One stop shop for vim colorschemes
Plugin 'bling/vim-airline'                   " Lean & mean status/tabline for vim that's light as air
Plugin 'vim-airline/vim-airline-themes'      " Themes for vim-airline plugin
Plugin 'ryanoasis/vim-devicons'              " Enble fancy icons in vim

" Surround
Plugin 'tpope/vim-surround'                  " All about surroundings: parentheses, brackets, quotes, XML tags, and more

" Comments
Plugin 'tpope/vim-commentary'                " Comment stuff in and out

" Indentation
Plugin 'yggdroot/indentline'                 " Display thin vertical lines at each indentation level

" Navigation
Plugin 'ctrlpvim/ctrlp.vim'                  " Full path fuzzy file, buffer, mru, tag, ... finder for Vim
Plugin 'scrooloose/nerdtree'                 " File system explorer for vim
Plugin 'majutsushi/tagbar'                   " Browse the tags of the file and get an overview of its structure

" YCM
Plugin 'Valloric/YouCompleteMe'              " Code completion engine for Vim

" C++
Plugin 'a.vim'                               " Alternate files quickly (.c <--> .h etc) via :A
Plugin 'octol/vim-cpp-enhanced-highlight'    " Advanced highlighting of C++ code

" Python
Plugin 'klen/python-mode'                    " Vim python-mode. PyLint, Rope, PyDoc, breakpoints from box
Plugin 'ambv/black'                          " The Uncompromising Code Formatter

" Git
Plugin 'tpope/vim-fugitive'                  " Git plugin for Vim. So awesome, it should be illegal
Plugin 'Xuyuanp/nerdtree-git-plugin'         " A plugin of NERDTree showing git status flags.

call vundle#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           reset vimrc augroup                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" We reset the vimrc augroup. Autocommands are added to this group throughout
" the file
augroup vimrc
  autocmd!
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        turn on filetype plugins                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable detection, plugins and indenting in one step
" This needs to come AFTER the Plugin commands!
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        *** General settings ***                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Choose colorschema                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if filereadable(expand('$HOME/.vim/bundle/vim-colorschemes/README.md'))
    " Default dark scheme
    colorscheme Tomorrow-Night
    " colorscheme gruvbox
    " colorscheme nordisk

    " Default light scheme
    " colorscheme PaperColor " sets the colorscheme

    set background=dark
    " set background=light
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                HJKL                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Make good habit
" nnoremap <Left> :echoe "Use h"<CR>
" nnoremap <Right> :echoe "Use l"<CR>
" nnoremap <Up> :echoe "Use k"<CR>
" nnoremap <Down> :echoe "Use j"<CR>

" Enable mouse
set mouse=a

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            BUFFERS                                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set autochdir           " Automatically change directory on buffer change
set hidden              " Allows making buffers hidden even with unsaved changes
set switchbuf=useopen,usetab  " This option controls the behavior when switching between buffers
set diffopt+=vertical   " Split buffers vertically in diff mode

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            DISPLAY SETTINGS                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set scrolloff=5         " 5 lines above/below cursor when scrolling
set showmatch           " show matching bracket (briefly jump)
set matchtime=2         " reduces matching paren blink time from the 5[00]ms def
set cursorline          " highlights the current line
set winaltkeys=no       " turns of the Alt key bindings to the gui menu

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            TAB COMPLETION                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" When you type the first tab, it will complete as much as possible, the second
" tab hit will provide a list, the third and subsequent tabs will cycle through
" completion options so you can complete the file without further keys
set wildmode=longest,list,full
set wildmenu            " completion with menu
" This changes the default display of tab and CR chars in list mode
" The "longest" option makes completion insert the longest prefix of all
" the possible matches; see :h completeopt
set completeopt=menu,menuone,longest

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            EDITOR SETTINGS                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nowrap              " Don't wrap lines longer than window width
set ignorecase          " case insensitive searching
set smartcase           " but become case sensitive if you type uppercase characters
" this can cause problems with other filetypes
" see comment on this SO question
" http://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim/234578#234578
set tabstop=4           " number of spaces a tab counts for
set shiftwidth=4        " spaces for autoindents
set expandtab           " turn a tab into spaces
set smartindent         " smart auto indenting
set autoindent          " on new lines, match indent of previous line
set copyindent          " copy the previous indentation on autoindenting
set cindent             " smart indenting for c-like code
set cino=b1,g0,N-s,t0,W0  " see :h cinoptions-values
set smarttab            " smart tab handling for indenting
set magic               " change the way backslashes are used in search patterns
set bs=indent,eol,start " Allow backspacing over everything in insert mode
set nobackup            " no backup~ files.

set softtabstop=4       " Number of spaces that a <Tab> counts for while performing editing operations
set shiftround          " makes indenting a multiple of shiftwidth
set laststatus=2        " the statusline is now always shown

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Misc settings                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set fileformat=unix     " file mode is unix
set fileformats=unix,dos,mac   " detects unix, dos, mac file formats in that order
set noswapfile          " do not store swap files

set viminfo='20,\"500   " remember copy registers after quitting in the .viminfo file -- 20 jump links, regs up to 500 lines'

set history=10000       " remember more commands and search history
set undolevels=10000    " use many levels of undo
set autoread            " auto read when a file is changed from the outside
set foldlevelstart=99   " all folds open by default

" this makes sure that shell scripts are highlighted
" as bash scripts and not sh scripts
let g:is_posix = 1
let g:vim_json_conceal = 0

" tries to avoid those annoying "hit enter to continue" messages
" if it still doesn't help with certain commands, add a second <cr>
" at the end of the map command
set shortmess+=T

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Navigation                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" none of these should be word dividers, so make them not be
set iskeyword-=_,$,@,%,#

" allow backspace and cursor keys to cross line boundaries
set whichwrap+=<,>,h,l,[,]
set hlsearch            " highlight all search results
set incsearch           " highlight-as-I-type the search string

if v:version >= 704
  " The new Vim regex engine is currently slooooow as hell which makes syntax
  " highlighting slow, which introduces typing latency.
  " Consider removing this in the future when the new regex engine becomes
  " faster.
  set regexpengine=1
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Appearance                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set textwidth=80            " this makes the color after the textwidth column highlighted
set colorcolumn=+1          " comma separated list of screen columns that are highlighted with ColorColumn
set formatoptions=croqnj    " options for formatting text; see :h formatoptions
autocmd FileType json setlocal ts=2 sts=2 sw=2   " Json files rendering
set splitright              " Open splits to the right
set number                  " Lines enumeration
set list                    " Highlight uwanted spaces, nice for tsv files viewing
set listchars=trail:·,tab:→→
set shell=/bin/bash         " set shell to use in :terminal

if &t_Co > 2 || has("gui_running")   " Switch syntax highlighting on, when the terminal has colors
  syntax on
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Typos                                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab itn int

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Tweaks                                        "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Unicode support (taken from http://vim.wikia.com/wiki/Working_with_Unicode)
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,latin1
endif

augroup vimrc
  " Automatically delete trailing DOS-returns and whitespace on file open and write.
  autocmd BufRead,BufWritePre,FileWritePre * silent! %s/[\r \t]\+$//
augroup END

" Sometimes, $MYVIMRC does not get set even though the vimrc is sourced
" properly. So far, I've only seen this on Linux machines on rare occasions.
if has("unix") && strlen($MYVIMRC) < 1
  let $MYVIMRC=$HOME . '/.vimrc'
endif

" Automatically close Quickfix window if it is the last one.
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

" cindent is a bit too smart for its own good and triggers in text files when
" you're typing inside parens and then hit enter; it aligns the text with the
" opening paren and we do NOT want this in text files!
autocmd vimrc FileType text,markdown,gitcommit setlocal nocindent

autocmd vimrc FileType markdown setlocal spell! spelllang=en_us

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Custom mappings                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" this makes vim's regex engine "not stupid"
" see :h magic
" nnoremap / /\v
" vnoremap / /\v

" Allow Tab & Shift-Tab indentation in /normal and/ visual modes
vnoremap <Tab> >
vnoremap <S-Tab> <
nnoremap <Tab> >>
nnoremap <S-Tab> <<

" Saving on F2
map <silent> <F2> :w<CR>
map! <F2> <C-o><F2>

" Nerd tree on F4
map <F4> :NERDTreeToggle<CR>
map! <F4> <C-o><F4>

" YCM fix
map <F5> :YcmCompleter FixIt<CR>
nnoremap <leader>fi :YcmCompleter FixIt<CR>

" YCM gettype
map <F6> :YcmCompleter GetType<CR>
nnoremap <leader>t :YcmCompleter GetType<CR>

" YCM goto
nnoremap <leader>gt :YcmCompleter GoTo<CR>

" YCM go to definition
nnoremap <leader>df :YcmCompleter GoToDefinition<CR>

" YCM go to declaration
nnoremap <leader>dc :YcmCompleter GoToDeclaration<CR>

" Switch between buffers on F7 and F8
map <silent> <F7> :bp<CR>
map! <F7> <C-o><F7>
map <silent> <F8> :bn<CR>
map! <F8> <C-o><F8>

" Tagbar on F9
map <F9> :TagbarToggle<CR>
map! <F9> <C-o><F9>

" switch line numeration on F12
map <silent> <F12> :set nu!<CR>
map! <F12> <C-o><F12>
map <silent> <S-F12> :set relativenumber!<CR>
map! <S-F12> <C-o><S-F12>

" replace visual selection (https://stackoverflow.com/a/676619/3066429)
" By pressing ctrl+r in visual mode, you will be prompted to enter text to replace with.
" Press enter and then confirm each change you agree with y or decline with n.
" This command will override your register h so you can choose other one (by changing h in
" the command above to another lower case letter) that you don't use.
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       ***  HERE BE PLUGINS  ***                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Vundle                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:vundle_default_git_proto = 'git'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Tagbar                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:tagbar_autoclose = 0
let g:tagbar_autofocus = 0
let g:tagbar_width = 35
let g:tagbar_ctags_bin = '~/.vim/auxilliary/ctags/ctags-exuberant'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             vim-startify                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:startify_bookmarks = [ '~/.vimrc' ]
let g:startify_custom_header = [
            \'             ',
            \   '(V)_(o_O)_(V)',
            \   '             '
            \ ]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             vim-commentary                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd FileType cmake setlocal commentstring=#\ %s

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             tabline.vim                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:tablineclosebutton=1

hi TabLine      ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineFill  ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             scrooloose/nerdtree                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:NERDTreeShowHidden=1
let g:NERDTreeGitStatusUpdateOnWrite = 1
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeGitStatusNodeColorization = 1

" Specific colors for NERDTree git symbols
let g:NERDTreeColorMapCustom = {
\ "Staged"    : "#0ee375",
\ "Modified"  : "#d9bf91",
\ "Renamed"   : "#51C9FC",
\ "Untracked" : "#FCE77C",
\ "Unmerged"  : "#FC51E6",
\ "Dirty"     : "#FFBD61",
\ "Clean"     : "#87939A",
\ "Ignored"   : "#808080"
\ }

" Specific NERDTree git symbols
let g:NERDTreeGitStatusIndicatorMapCustom = {
\ 'Modified'  :'✹',
\ 'Staged'    :'✚',
\ 'Untracked' :'✭',
\ 'Renamed'   :'➜',
\ 'Unmerged'  :'═',
\ 'Deleted'   :'✖',
\ 'Dirty'     :'✗',
\ 'Ignored'   :'☒',
\ 'Clean'     :'✔︎',
\ 'Unknown'   :'?',
\ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                vim-devicons                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" loading the plugin
let g:webdevicons_enable = 1
" adding the flags to NERDTree
let g:webdevicons_enable_nerdtree = 1
" adding to vim-airline's tabline
let g:webdevicons_enable_airline_tabline = 1
" adding to vim-airline's statusline
let g:webdevicons_enable_airline_statusline = 1
" ctrlp glyphs
let g:webdevicons_enable_ctrlp = 1
" adding to vim-startify screen
let g:webdevicons_enable_startify = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                vim-airline                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Always display statusline
" Fancy theme. Requires vim-airline-themes
let g:airline_theme = 'zenburn'

" Use fancy symbols
let g:airline_powerline_fonts = 1
" Setup dictionary for the symbols
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

" Powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'

" Setup interaction with other plugins
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#capslock#enabled = 1
let g:airline#extensions#tabline#enabled = 1

au User AirlineAfterInit  :let g:airline_section_z = airline#section#create([
\   '%p%% Ln %l/%L Col %v'
\])

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                YouCompleteMe                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_use_ultisnips_completer = 0
let g:ycm_complete_in_comments = 1
let g:ycm_error_symbol = '❌'
let g:ycm_warning_symbol = '☝'
let g:ycm_filetype_specific_completion_to_disable = {
\   'csv' : 1,
\   'diff' : 1,
\   'gitcommit' : 1,
\   'help' : 1,
\   'infolog' : 1,
\   'mail' : 1,
\   'markdown' : 1,
\   'notes' : 1,
\   'pandoc' : 1,
\   'qf' : 1,
\   'svn' : 1,
\   'tagbar' : 1,
\   'text' : 1,
\   'unite' : 1,
\   'vimwiki' : 1
\}
autocmd FileType c,cpp,python nnoremap <buffer> <C-]> :YcmCompleter GoTo<CR>
autocmd FileType c,cpp,python inoremap <buffer> <C-]> <C-o><C-]>
autocmd FileType c,cpp,python nnoremap <buffer> <F10> :YcmDiags<CR>
autocmd FileType c,cpp,python inoremap <buffer> <F10> <C-[><F10>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             vim-cpp-enhanced-highlight                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight class scope
let g:cpp_class_scope_highlight = 1

" Highlight member variables
let g:cpp_member_variable_highlight = 1

" Highlight class names in declarations
let g:cpp_class_decl_highlight = 1

" Highlight POSIX functions
let g:cpp_posix_standard = 1

" Highlight template functions (slow but more precise)
let g:cpp_experimental_simple_template_highlight = 1

" Highlight template functions (fast but less precise)
" let g:cpp_experimental_template_highlight = 1

" Highlight of library concepts
let g:cpp_concepts_highlight = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              python-mode                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:pymode_options_max_line_length=80
let g:pymode_python = 'python3'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              black                                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Specify the virtual environment path for black
let g:black_virtualenv='~/.vim/black'
let g:black_linelength = 80
" Run black on save
autocmd BufWritePre *.py execute ':Black'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             ctrlp.vim                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_depth=40
let g:ctrlp_max_files=0
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             indentline                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:indentLine_enabled = 1
