map <F6> :call CR()<cr>
func! CR()
    exec "w"
    exec "!g++ -D RE_IO % -o %<"
    exec "! ./%<"
endfunc

