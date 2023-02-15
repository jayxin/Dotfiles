" [vim versus neovim]{{{
" $HOME/.vimrc versus $HOME/.config/nvim/init.vim
" $HOME/.vim/plugged versus $HOME/.local/share/nvim/plugged
" $HOME/.vim/autoload/plug.vim versus $HOME/.config/nvim/autoload/plug.vim
" $MYVIMRC $VIMRUNTIME
" vimscript: http://learnvimscriptthehardway.stevelosh.com
" ~/.vim/ftplugin/ versus ~/.config/nvim/ftplugin/
" ftplugin is the corrent directory to place LaTeX-specific configuration(or
" in general any configuration that you wish to apply only to a single file
" type).
" }}}

" [Filetype Plugin System]{{{
" set nocompatible " for vim
" set rtp+=~/.vim " for neovim, runtimepath
" :echo &runtimepath
" :echo &packpath
" If you want a plugin to load automatically when you open vim, you must place
" the plugin in an appropriate location in your runtimepath.
filetype on " enable filetype detection
filetype plugin on " load file-specific plugins
filetype indent on " load file-specific indentation
" use :filetype to check the status
" :set filetype?
" :echo &filetype
" :h filetype :h ftplugin
" }}}

" [set runtimepath] {{{
" set runtimepath+=~/.vim/config
" runtime basic.vim
" runtime plugins.vim
" runtime bindings.vim
" for f in split(glob('~/.vim/config/*.vim'), '\n')
"     exe 'source' f
" endfor
" }}}

" set nobackup
" set nowritebackup
" set undodir=~/.vim/undodir
" if !isdirectory(&undodir)
"     call mkdir(&undodir, 'p', 0700)
" endif

set noswapfile

" set undofile

" [General settings] {{{
set enc=utf-8
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp396,latin1
set fencs=utf8,gbk,gb2312,gb18030
" set number
set relativenumber
set fdm=marker
set history=100
set showmode
set ruler
set cursorline " highlight the current line
set cursorcolumn
set showcmd " show incomplete commands
set tabstop=4 " set tab size in spaces(this is for manual indenting)
set softtabstop=4
set expandtab " convert tabs to spaces
set shiftwidth=4 " the number of spaces inserted for a tab(used for auto indenting)
set autoindent
set smartindent
set hlsearch " use :nohl to invert
set incsearch
set showmatch " highlight a matching [{()}] when cursor is placed on start/end character
set ignorecase
" set smartcase
set visualbell " ensure vim does not beep at you every time you make a mistype
set wildmenu " visual autocomplete for command menu(e.g. :e ~/path/to/file)
set lazyredraw " redraw only when we need to(i.e. don't redraw when executing a macro)
set backspace=indent,eol,start " allow backspace to delete end of line, indent and start of line chars
set nowrap " turn word wrap off
set laststatus=2 " always show status bar
set statusline=%f\ %=L:%l/%L\ %c\ (%p%%) " set the status line to something useful
" set clipboard+=unnamed " use system clipboard
set clipboard=unnamedplus
set autoread " autoread files that have changed outside of vim
set shortmess+=I " do not show intro
" get rid of the delay when pressing O(for example)
set timeout timeoutlen=1000 ttimeoutlen=100
" highlight tailing whitespace
set list listchars=tab:\ \ ,trail:·
filetype on
syntax on
syntax enable
" set selection=exclusive
set selectmode=mouse,key
set shiftround
" set listchars=tab:>-,eol:$

" better splits(new windows appear below and to the right)
set splitbelow
set splitright

" Always highlight column 80 so it's easier to see where
" cutoff appears on longer screens
autocmd BufWinEnter * highlight ColorColumn ctermbg=darkgreen
set colorcolumn=80

" A buffer is marked as 'hidden' if it has unsaved changes, and it's not
" currently loaded in a window if you try and quit Vim while there are hidden
" buffers, you will raise an error:
" E162: No write since last changed for buffer "a.txt"
set hidden

" }}}

" [Key mappings] {{{

" :map j gg(j will be mapped to gg)
" :map Q j(Q will also mapped to gg,because j will be expanded(recursive mapping)
" :noremap W j(W will be mapped to j not to gg(non-recursive mapping))

" map jk to <esc> in insert mode
inoremap jk <esc>
" map <space> to : in normal mode
nnoremap <space> :
" clear search buffer
" :nnoremap $ :nohlsearch<cr>

" saving a read-only file edited in vim
cnoremap w!! w !sudo tee > /dev/null %
" :w isn't modifying your file in this case but sends the current buffer
" contents to a substituted shell command. !sudo call the shell sudo command
" tee the output of the vim write command is redirected.
" > /dev/null throws away the standard output.
" % expands to the path of the current file.

let mapleader = ','

" set built-in file explorer to use layout similar to the NERDTree plugin
let g:netrw_liststyle=3

" File system explorer(in horizontal split)
noremap <leader>. :Sexplore<cr>

" Make handling vertical/linear Vim windows easier
noremap <Leader>w- <C-W>- " decrease height
noremap <Leader>w+ <C-W>+ " increase height
noremap <Leader>w] <C-W>_ " maximize height
noremap <Leader>w[ <C-W>= " equalize all windows

nnoremap <Leader>f :NERDTreeToggle<cr>
nnoremap <Leader>t :TagbarToggle<cr>

noremap <F2> GoDate: <esc>:read !date<cr>kJ

nnoremap <Leader>ev :vsplit $MYVIMRC<cr>
nnoremap <Leader>sv :source $MYVIMRC<cr>

nnoremap <Leader>" viw<esc>a"<esc>bi"<esc>lel

nnoremap <Leader>w <C-W>v
nnoremap <Leader>gw <C-W>s

" }}}

" [Command] {{{
fun! StripTrailingWhitespace()
    " do not strip on these filetypes
    if &ft =~ 'markdown'
        return
    endif
    %s/\s\+$//e
endfun
" autocmd BufWritePre * call StripTrailingWhitespace()

" Rainbow parenthesis always on
if exists(':RainbowParenthesesToggle')
    autocmd VimEnter * RainbowParenthesesToggle
    autocmd Syntax * RainbowParenthesesLoadRound
    autocmd Syntax * RainbowParenthesesLoadSquare
    autocmd Syntax * RainbowParenthesesLoadBraces
endif

" Change colorscheme when diffing
fun! SetDiffColors()
    highlight DiffAdd cterm=bold ctermfg=white ctermbg=DarkGreen
    highlight DiffDelete cterm=bold ctermfg=white ctermbg=DarkGray
    highlight DiffChange cterm=bold ctermfg=white ctermbg=DarkBlue
    highlight DiffText cterm=bold ctermfg=white ctermbg=DarkRed
endfun
autocmd FilterWritePre * call SetDiffColors()

" specify syntax highlighting for specific files
autocmd BufRead,BufNewFile *.md set filetype=markdown
" vim interprets .md as 'modula2' otherwise

" Close all folds when opening a new buffer
autocmd BufRead * setlocal foldmethod=marker
autocmd BufRead * normal zM

" jump to last cursor
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" Create a 'scratch buffer' which is a temporary buffer Vim wont ask to save
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
    echo a:cmdline
    let expanded_cmdline = a:cmdline
    for part in split(a:cmdline, ' ')
        if part[0] =~ '\v[%#<]'
            let expanded_part = fnameescape(expand(part))
            let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
        endif
    endfor
    botright new
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
    call setline(1, 'You entered:   '. a:cmdline)
    call setline(2, 'Expanded Form:    '.expanded_cmdline)
    call setline(3, substitute(getline(2), '.', '=', 'g'))
    execute '$read !'. expanded_cmdline
    setlocal nomodifiable
    1
endfunction

" Highlight words to avoid in tech writing
highlight TechWordsToAvoid ctermbg=red ctermfg=white
match TechWordsToAvoid /\cobviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however\|so,\|easy/
autocmd BufWinEnter * match TechWordsToAvoid /\cobviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however,\|so,\|easy/
autocmd InsertEnter * match TechWordsToAvoid /\cobviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however,\|so,\|easy/
autocmd InsertLeave * match TechWordsToAvoid /\cobviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however,\|so,\|easy/
autocmd BufWinLeave * call clearmatches()

" Reset spelling colors when reading a new buffer
" This works around an issue where the colorscheme is changed by .local.vimrc
fun! SetSpellingColors()
    highlight SpellBad cterm=bold ctermfg=white ctermbg=red
    highlight SpellCap cterm=bold ctermfg=red ctermbg=white
endfun
autocmd BufWinEnter * call SetSpellingColors()
autocmd BufNewFile * call SetSpellingColors()
autocmd BufRead * call SetSpellingColors()
autocmd InsertEnter * call SetSpellingColors()
autocmd InsertLeave * call SetSpellingColors()

autocmd Filetype gitcommit setlocal spell textwidth=72
autocmd FileType markdown setlocal wrap linebreak nolist textwidth=0 wrapmargin=0

" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

autocmd FileType c,cpp,cc :set cindent
autocmd BufRead *.cc,*.cpp,*.c :setlocal fdm=syntax

" }}}

" [Plugin] {{{

" vim-plug plugin manager
" call plug#begin(expand('~/.vim/plugged'))
call plug#begin()

" LaTeX
Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-dispatch'
" Plug 'honza/vim-snippets'
Plug 'KeitaNakamura/tex-conceal.vim'

" Conquer of Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" nerd
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'

" vim-airline
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" colorschemes
Plug 'flazz/vim-colorschemes'
Plug 'vim-scripts/peaksea'
Plug 'vim-scripts/xoria256.vim'

Plug 'vim-scripts/Auto-Pairs'
Plug 'preservim/tagbar'
Plug 'kien/ctrlp.vim'
Plug 'vim-scripts/grep.vim'
Plug 'vim-scripts/gdbmgr'
Plug 'Yggdroot/indentLine'
Plug 'vim-syntastic/syntastic'
Plug 'mbbill/undotree'
Plug 'bling/vim-bufferline'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'mhinz/vim-startify'
" Plug 'ycm-core/YouCompleteMe'
" Plug 'Valloric/YouCompleteMe'
" Plug 'tpope/vim-fugitive'
" Plug 'ervandew/supertab'

" tabular must come before vim-markdown
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

" Plug 'tpope/vim-commentary'

" Plug 'skywind3000/vim-auto-popmenu'
" Plug 'skywind3000/vim-dict'

call plug#end()

" [Plug:UltiSnips] {{{
let g:UltiSnipsExpandTrigger = ',a'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
" let g:UltiSnipsSnippetDirectories = ["snips", "something"] " search runtimepath
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/snips'] " for neovim
" let g:UltiSnipsSnippetDirectories = [$HOME.'/.vim/snips'] " for vim

" The general form of an UltiSnips snippet is:
" snippet {trigger} ["description" [options]]
" {snippet body}
" endsnippet
" The options can be included only if a "description" is also provided.
" See also :h UltiSnips-basic-syntax and :h UltiSnips-authoring-snippets
" :h UltiSnips-snippet-options

" Some options for ultisnips
" A : enables automatic expansion, i.e. a snippet with the A option will
" expand immediately after trigger is typed, witout you having to press the
" g:UltiSnipsExpandTrigger key.

" r : allows the use of regular expandsions in the snippet's trigger

" b : expands snippets only if trigger is typed at the beginning of a line

" i : expands snippets regardless of where trigger is typed.(By default
" snippets expand only if trigger begins a new line or is preceded by
" whitespace.)

" # is for comment.
"
" Including the following line
" extends filetype
" anywhere in a *.snippets file will load all snippets from filetype.snippets
" into the snippets file containing "extends filetype".

" The line "priority {N}", where N is an integer, placed anywhere in .snippets
" file on its own line will set the priority of all snippets below that line
" to N. When multiple snippets have the same trigger, only the highest snippet
" is expanded. Using priority can be useful to override global snippets
" defined in all.snippets. The default priority is zero.

" Tabstops
" Tabstops are predefined positions within a snippet body to which you can
" move pressing the key mapped to g:UltiSnipsJumpForwardTrigger. Tabstops
" allow you to efficiently navigate through a snippet's variable content while
" skipping the positions of static content. You navigate through tabstops by
" pressing, in insert mode, the keysmapped to g:UltiSnipsJumpForwardTrigger
" and g:UltiSnipsJumpBackwardTrigger. See also :h UltiSnips-tabstops
" You create a tabstop with a dollar sign followed by a number, e.g. $1 or $2.
" Tabstops should start at $1 and proceed in sequential order.
" The $0 tabstop is special. It's always the last tabstop in the snippet no
" matter how many tabstops are defined.
" If $0 is not explicitly defined, it is implicitly placed at the end of the
" snippet.

" Refreshing snippets
" The function UltiSnips#RefreshSnippets refreshes the snippets in the current
" vim instance to reflect the contents of your snippets directory.
" Problem: You're editing myfile.tex in one vim instance, make some changes to
" tex.snippets in a separate vim instance, and want the updates to be
" immdediately available in myfile.tex without having to restart vim.
" Solution: call UltiSnips#RefreshSnippets using
" :call UltiSnips#RefreshSnippets()
" Use <leader>u in normal mode to refresh UltiSnips snippets
nnoremap <leader>u <Cmd>call UltiSnips#RefreshSnippets()<cr>

" Practical tips for fast editing
" 1. Use automatic completion whenever possible. This technically makes UltiSnips
" use more computing resources -- see the warning in :h UltiSnips-autotrigger.
" 2. Use short snippet triggers.
" 3. Repeated-character triggers offer a good balance between efficiency and
" good semantics.
" 4. Use math-context expansion and regular expressions to free up short,
" convenient triggers that would otherwise conflict with common words.
" 5. Use ergonomic triggers on or near the home row. Depending on your
" capacityto develop muscle memory, you can dramatically improve efficiency if
" you sacrifice meaningful trigger names for convenient trigger locations.
" }}}

" [Plug:Airline] {{{

" AirlineTheme cool
let g:airline_theme = 'supernova'
let g:airline_powerline_fonts = 1

" }}}

" [Plug:NERD tree] {{{

" autocmd StdinReadPre * let s:std_in = 1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeWinSize = 25
let NERDTreeShowlineNumbers = 1
let NERDTreeAutoCenter = 1
let NERDTreeShowBookmarks = 0

" }}}

" [Plug:NERD commenter] {{{

" Comment/uncomment in programming lang
let mapleader = ","
let NERDCreateDefaultMappings = 0 " disable default mapping
let NERDCommentWholeLinesInVMode = 1 " always comment whole line
map <Leader>c <Plug>NERDCommenterComment
map <Leader>x <Plug>NERDCommenterUncomment

" }}}

" [Plug:tagbar] {{{
let g:tagbar_width = 25
autocmd BufReadPost *.cpp,*.c,*.h,*.cc,*.cxx call tagbar#autoopen()
" }}}

" [Plug:vim-markdown] {{{
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_math = 1
" }}}

" [Plug:vim-auto-popmenu] {{{
let g:apc_enable_ft = {'*':1}
set cpt=.,k,w,b
set completeopt=menu,menuone,noselect
set shortmess+=c
" }}}

" [Plug:vim-dict] {{{
"let g:vim_dict_config = {'tex': 'tex,text'}
"let g:vim_dict_dict = [$HOME.'.config/nvim/snips/']
" }}}

" [Plug:CtrlP] {{{
"map <leader>t <C-p>
"map <leader>y :CtrlPBuffer<cr>
"let g:ctrlp_show_hidden=1
"let g:ctrlp_working_path_mode=0
"let g:ctrlp_max_height=30

" Override <C-o> to provide options for how to open files
"let g:ctrlp_arg_map = 1

" Files matched are ignored when expanding wildcards
"set wildignore+=*/.git/*,*/.hg/*,*/.svn/*.,*/.DS_Store

" Use Ag for searching instead of VimScript
" (might not work with ctrlp_show_hidden and ctrlp_custom_ignore)
"let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" Directories to ignore when fuzzy finding
"let g:ctrlp_custom_ignore = '\v[\/]((node_modules)|\.(git|svn|grunt|sass-cache))$'

" Ack (uses Ag behind the scenes)
"let g:ackprg = 'ag --nogroup --nocolor --column'
" }}}

" [Plug:Tabularize] {{{
" map <Leader>e :Tabularize /=<cr>
" map <Leader>c :Tabularize /:<cr>
" map <Leader>es :Tabularize /=\zs<cr>
" map <Leader>cs :Tabularize /:\zs<cr>
" }}}

" }}}

" mouse {{{
if has('mouse')
    if has('gui_running') || (&term =~ 'xterm' && !has('mac'))
        set mouse=a " active
    else
        set mouse=nvi " normal/visual/insert
    endif
endif
" set visualbell t_vb=
" }}}

" [Abbrev] {{{
:iabbrev mm <!-- [] {{{ --> <cr><cr><!-- }}} --><cr>
" }}}

set guioptions-=T " hide the toolbar

" [Colorscheme] {{{
set bg=dark" background(dark/light)
" coloscheme Tomorrow-Night " colorscheme
" colo Monokai
" colo matrix
" colo happy_hacking
" colo cool
" colo Tomorrow-Night-Bright
" colo Tomorrow-Night-Eighties
" colo peaksea
colo gruvbox
" colo xoria256
" colo solarized
" colo zephyr
" set guifont=Source\ Code\ Pro\ 14
" }}}

" [A true vimer] {{{
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
" }}}

" set tags=...
