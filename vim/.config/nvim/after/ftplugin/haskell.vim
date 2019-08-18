setlocal et sw=4

setlocal include=import
setlocal includeexpr=substitute(v:fname,'\\.','/','g')\ .\ '.hs'

set path+=src/**,app/**

setlocal comments=fb:--

