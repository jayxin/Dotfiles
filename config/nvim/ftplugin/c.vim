" [cscope] {{{
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=1
    set cst
    set nocsverb
    " add any database in current dir
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set csverb
endif

set cscopequickfix=s-,c-,d-,i-,t-,e-

nmap <silent> <F5> :cs find s <C-R>=expand("<cword>")<cr><cr>
nmap <silent> <F6> :cs find t <C-R>=expand("<cword>")<cr><cr>
nmap <silent> <F7> :cs find c <C-R>=expand("<cword>")<cr><cr>

" }}}

