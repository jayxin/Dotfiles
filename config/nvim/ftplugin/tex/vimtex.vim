" [Help] {{{
" Once you have installed VimTeX, you can check that VimTeX has loaded by
" opening a file with the .tex extension and issuing the command :VimtexInfo.
" If this opens a window with various system status information. VimTeX has
" loade and you're good to go.
" :h vimtex :h g:vimtex_fold_enabled :h g:vimtex_format_enabled
" :h vimtex-features
" :h vimtex-default-mappings
" :h vimtex-commands
" :h vimtex-mappings
" :helptags ALL
" VimTeX overrides Vim's internal ftplugin, i.e. the one in
" $VIMRUNTIME/ftplugin, but respects any user-defined LaTeX configuration in
" ftplugin/tex.vim
" }}}

" dse : delete surrounding environments(<Plug>vimtex-env-delete)
" cse : change surrounding environments(<Plug>vimtex-env-change)
" dsc : delete surrounding commands(<Plug>vimtex-cmd-delete)
" csc : change surrounding commands while preserving the command's arguments
" (<Plug>vimtex-cmd-change)
" Delete a LaTeX command while preserving the command's argument(s).
" dsd : Delete surrounding delimiters(e.g. (),[],{} and any of their \left \right
" variants) without changing the enclosed content.(<Plug>vimtex-delim-delete)
" csd : change surrounding delimiters(<Plug>vimtex-delim-change-math)
" ds$ : delete surrounding math environments without changing the math
" contents.(<Plug>vimtex-env-delete-math)
" cs$ : change surrounding math env(<Plug>vimtex-env-change-math)

" [Toggle-style mappings]{{{
" Toggle back and forth between states of various LaTeX envs and commands.

" Toggle starred commands and environments using "tsc" and "tse".
" (<Plug>vimtex-env-toggle-star)

" Toggle between inline and display math "ts$"(<Plug>vimtex-env-toggle-math)

" Toggle surrounding delimiters using
" "tsd".(<Plug>vimtex-delim-toggle-modifier). Change between plain and
" \left/\right versions of delimiters.
" Delimiters other than \left\right(e.g. \big\Big etc.) can be added to the
" toggle list by configuring the g:vimtex_delim_toggle_mod_list variable.

" "tsD" works like tsd, but searches in reverse through the delimiter
" list.(<Plug>vimtex-delim-toggle-modifier-reverse)

" tsf : Toggle surrounding fractions. Toggle betwwen inline and \frac versions
" of fractions.(<Plug>vimtex-cmd-toggle-frac)

" }}}

" [Motion mappings] {{{
" All of the following motions accept a count and work in Vim's normal,
" operator-pending, and visual modes.

" Navigate matching content using "%": Move between matching delimiters,
" inline-math delimiters and LaTeX envs.(<Plug>vimtex-%)

" Navigate sections using "]]" and its variants: Jump to the beginning of the
" next \section \subsection or \subsubsection, whichever comes
" first.(<Plug>vimtex-]])
" Use "[[" to jump to the begninning of the current \section,\subsection or
" \subsubsection.
" See also :h <Plug>(vimtex-][) and <Plug>(vimtex-[])

" Navigate environments using "]m" and its variants: Jump to the next or
" previous environment "\begin" command using "]m" and "[m".
" <Plug>(vimtex-[m) <Plug>(vimtex-]m)
" See also :h <Plug>(vimtex-]M) and <Plug>(vimtex-[M)

" Navigate math zones using "]n" and its variants: Jump to the beggining of
" the next or previous math zone using "]n" and "[n".
" <Plug>(vimtex-]n) <Plug>(vimtex-[n)
" These motions apply to $$ \[\] and environments(including from the amsmath
" package) etc.
" See also :h <Plug>(vimtex-]N) <Plug>(vimtex-[N)

" Navigate Beamer frames using "]r" and its variants: Jump to the beggining of
" the next of previous frame environment(useful in slide show documents using
" the beamer document class) using "]r" and "[r".
" <Plug>(vimtex-]r) <Plug>(vimtex-[r)
" See also :h <Plug>(vimtex-]R) and <Plug>(vimtex-[R)
" }}}

" [Customization] {{{

" Setting a custom shortcut to trigger the delete surrounding math action.
" 1. The action's <Plug> map is <Plug>(vimtex-env-delete-math)
" 2. The action works in normal mode, so we'll use nmap for remaping it(xmap
" for visual mode, omap for operator-pending mode, etc.)
" 3. We'll replace the default mapping "ds$" with the more convenient "dsm".
nmap dsm <Plug>(vimtex-env-delete-math)
" VimTeX won't apply the default LHS shortcut to any <Plug> mapping you map to
" manually(the behaviour is explained in :h vimtex-default-mappings).

" }}}

" [Text objects] {{{

" VimTeX provides a lot of useful LaTeX-specific text objects.
" :h text-objects :h vimtex-text-objects
" VimTeX's text objects are listed in the table in :h vimtex-default-mappings
" and described in more detail in :h vimtex-mappings.
" The text objects behave exactly like Vim's built-in text objects and work in
" both operator-pending and visual mode.

" Some VimTex text objects
" ac,ic : LaTeX commands
" ad,id : Paired delimiters
" ae,ie : LaTeX environments
" a$,i$ : Inline math
" aP,iP : Sections
" am,im : Items in itemize and enumerate environments.
" The ad and id delimiter text objects convers all of (), [], {}, etc. and
" their \left\right, \big\big, etc. variants.

" Changing a default text object mapping
omap am <Plug>(vimtex-a$)
xmap am <Plug>(vimtex-a$)
omap im <Plug>(vimtex-i$)
xmap im <Plug>(vimtex-i$)

omap ai <Plug>(vimtex-am)
xmap ai <Plug>(vimtex-am)
omap ii <Plug>(vimtex-im)
xmap ii <Plug>(vimtex-im)

" }}}

" Disabling all defualt mappings and selectively defining your own
" You may do this for eaxample, to avoid cluttering the mapping namespace with
" mappings you won't use.
" An example of disabling all default VimTeX mappings, then selectively
" defining your own. This code cound go in ftplugin/tex.vim.

" Disable VimTeX's default mappings
" let g:vimtex_mappings_enabled = 0

" Manually redefine only the mappings you wish to use
" omap ac <Plug>(vimtex-ac)
" omap id <Plug>(vimtex-id)
" omap ae <Plug>(vimtex-ae)
" xmap ac <Plug>(vimtex-ac)
" xmap id <Plug>(vimtex-id)
" xmap ae <Plug>(vimtex-ae)
" map % <Plug>(vimtex-%)
" map ]] <Plug>(vimtex-]])
" map [[ <Plug>(vimtex-[[)
" nmap <localleader>li <Plug>(vimtex-info)
" nmap <localleader>ll <Plug>(vimtex-compile)

" [Insert mode mappings] {{{

" VimTeX provides a lot of insert mode mappings, which are described in :h
" vimtex-imaps. Its mappings provide a similar but less feature-rich
" functionality to snippets. If you use a snippets plugin, you can probably
" safely disable VimTeX's insert mode mappings without any loss of
" functionality.
" This mappings are enabled by default.
" let g:vimtex_imaps_enabled = 0
" :VimtexImapsList : list all active VimTeX-provided insert mode mappings.
" Insert mode mappings are stored in the global variable in
" g:vimtex_imaps_list.
" VimTeX's insert mode mappings are triggered with the prefix defined in the
" variable g:vimtex_imaps_leader, which is the backtick` by default.
" See also :h vimtex-imaps for more detail.

" }}}

" [Options] {{{

" :h vimtex-options

" Disabling default features
let g:vimtex_indent_enabled = 0 " turn off indentation
let g:vimtex_imaps_enabled = 0 " disable insert mode mappings
let g:vimtex_complete_enabled = 0 " turn off completion
let g:vimtex_syntax_enabled = 0 " disable syntax conceal

" Changing the default delimiter toggle list
" let g:vimtex_delim_toggle_mod_list = [
"   \ ['\left', '\right'],
"   \ ['\big', '\big'],
"   \]
" See also :h g:vimtex_delim_toggle_mod_list

" }}}

" [Commands] {{{

" This plugin provides a lot user-defined commands and these are listed and
" described in the documentation section :h vimtex-commands.
" The commands mostly cover compilation, PDF reader integration and system and
" plugin status.

" As a side note, most but not all VimTeX commands can be triggered by default
" using a shortcut in the LHS of the 3-column list in :h
" vimtex-default-mappings. For those commands without a default shortcut
" mapping, defining one can be as simple as a single line of VimScript.
noremap <leader>wc <Cmd>VimtexCountWords<CR>
" :h map-cmd

" }}}

" [Syntax highlighting] {{{

" VimTeX provides system highlighting that improves on Vim's built-in syntax
" plugin for LaTeX. For most use cases VimTeX's syntax features should "just
" work" out of the box and you won't need to do any configuration.

" :h vimtex-syntax
" :h vimtex-syntax-packages
" :h g:vimtex_syntax_packages

" VimTeX's syntax engine is "context_aware"(e.g. can distinguish regular text
" from LaTeX's math mode). The feature makes possible math-sensitive snippet
" expansion.

" VimTeX provides a features called "syntax-concealment", which replaces
" various commands such as math-mode commands for Greek letters, with a
" shorter Unicode equivalent.
" :h vimtex-syntax-conceal

" }}}

" [Other features] {{{
" VimTeX offers a ready-to-go complilation interface.
" VimTeX also offers ready-to-go PDF viewer internal.
" VimTeX provides completion of citations and reference labels, together with
" integration with common autocompletion plugins. :h vimtex-completion
" VimTeX's code-folding features are covered at :h vimtex-folding.
" VimTeX provides indentation features that improve on Vim's default
" indentation plugin for LaTeX. See :h vimtex-indent. VimTeX's indentation is
" enabled by default and should "just work" for most use cases.
" " Solutions for linting and grammar checking are described at :h vimtex-lint
" and vimtex-grammar, respectively.
" VimTeX offers a few useful navigation features. :h vimtex-navigation
" 1. You can navigate a LaTeX document from within Vim via a table of
" contents, which VimTeX builds by parsing the document for \section commands
" and variations. ":h vimtex-toc"
" 2. You can jump to the TeX source code of packages, style files and
" documents included with \include and \input using the "gf" shortcut.
" :h vimtex-includeexpr
" 3. You can access the documentation of LaTeX packages imported with
" \usepackage using the ":VimtexDocPackage" command, which is mapped to "K" by
" default. ":h vimtex-latexdoc".

" }}}

" VimTeX wont load if you set the VimScript variable "let g:did_ftplugin = 1"
" in your user-defined "tex" plugin(~/.vim/ftplugin/tex.vim).
" VimTeX alsouses the variable "b:did_ftplugin" to avoid loading twice in the
" same Vim buffer. User-defined filetype plugins load before VimTeX, so if you
" set "let b:did_ftplugin = 1", then VimTeX will see "b:did_ftplugin=1" and
" not load.
" If you want to use both VimTeX and your own tex filetype plugin and
" currently have "let b:did_ftplugin = 1" in your own plugin, just change to a
" variable name like "b:did_my_ftplugin" instead, which wont conflict with
" VimTeX's use of "b:did_ftplugin".
" The "let b:did_ftplugin = 1" business is a standard safety mechanism
" described in the Vim documentation at :h ftplugin that gives the user
" control over loading filetype plugins.

let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_view_method = 'zathura'

let g:tex_flavor = 'latex'

" let g:vimtex_quickfix_mode = 0
" let g:vimtex_quickfix_open_on_warning = 0

let g:vimtex_compiler_progname = 'nvr'

let g:vimtex_toc_enabled = 1

let g:vimtex_toc_config = {
    \ 'name': 'TOC',
    \ 'layers': ['content', 'todo', 'include'],
    \ 'split_width': 25,
    \ 'todo_sorted': 0,
    \ 'show_help': 1,
    \ 'show_numbers': 1,
\}

let g:vimtex_compiler_latexmk = {
        \ 'build_dir' : '',
        \ 'callback' : 1,
        \ 'continuous' : 1,
        \ 'executable' : 'latexmk',
        \ 'hooks' : [],
        \ 'options' : [
        \   '-verbose',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \   '-xelatex',
        \   '-halt-on-error'
        \ ],
        \}

let g:vimtex_compiler_latexmk_engines = {
        \ '_'                : '-xelatex',
        \ 'pdfdvi'           : '-pdfdvi',
        \ 'pdfps'            : '-pdfps',
        \ 'pdflatex'         : '-pdf',
        \ 'luatex'           : '-lualatex',
        \ 'lualatex'         : '-lualatex',
        \ 'xelatex'          : '-xelatex',
        \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
        \ 'context (luatex)' : '-pdf -pdflatex=context',
        \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
        \}

let g:vimtex_fold_enabled = 1

noremap <localleader>c <Cmd>update<CR><Cmd>VimtexCompileSS<CR>
noremap <leader>v <Plug>(vimtex-view)

