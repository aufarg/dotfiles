if has("autocmd")
    " auto-source files to current session after write
    aug autoso
        au!
        au BufWritePost $MYVIMRC nested source $MYVIMRC
    aug END

    " set filetype
    aug setft
        au!
        au BufRead ~/.mutt/* setlocal filetype=muttrc
    aug END

    " settings based on filetype
    aug initft
        au!
        au FileType tex call LatexInit()
        au FileType html call HTMLInit()
        au FileType mail call MailInit()
        au FileType python call PythonInit()
    aug END

    " plugins autocommand
    aug autoplug
        au!
        au FileType c,c++ RainbowParentheses
    aug END
endif
