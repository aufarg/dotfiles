function! util#argparse(query)
    return matchlist(a:query, "\\v('.{-1,}'|[^' ][^ ]*)( ('.{-1,}' ?|[^' ].* ?))?")
endfunction
