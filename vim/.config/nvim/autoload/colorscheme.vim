function! theme#highlight()
    echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
         \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
         \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"
endfunction
