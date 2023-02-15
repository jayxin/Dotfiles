"function! Synctex()
"    execute "silent !zathura --syntex-forward " . line('.') .":". col('.') .":". bufname('%') ." ". g:syncpdf
"    redraw!
"endfunction
"map <C-enter> :call Synctex()<cr>

" Spell checking and correcting spelling mistakes
"setlocal spell
"set spelllang=en_us
"inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
" Jump to the previous spelling mistake [s, then pick
" the first suggestion 1z=, and then jump back `]a.
" The <c-g>u make it possible to undo the spelling correcting quickly.

