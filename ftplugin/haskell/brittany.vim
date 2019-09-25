" Brittany (Haskell formatter)

if !exists("g:brittany_on_save")
    let g:brittany_on_save = 1
endif
if !exists("g:brittany_command") && executable("brittany")
    let g:brittany_command = "brittany"
endif


function! brittany#BrittanyEnable()
    let g:brittany_on_save = 1
endfunction
function! brittany#BrittanyDisable()
    let g:brittany_on_save = 0
endfunction
function! brittany#BrittanyToggle()
    let g:brittany_on_save = !g:brittany_on_save
endfunction


function! brittany#Brittany() range
    if !exists("g:brittany_command")
        echomsg "Brittany not found in $PATH, did you install it?
                    \ (stack install brittany)"
        return
    endif
    " Write the buffer to brittany, rather than having it use the
    " file on disk, because that file might not have been created yet!
    silent! exe "w !" . g:brittany_command . " > /dev/null 2>&1"

    if v:shell_error
        echohl WarningMsg
        echo "Brittany: Parsing error\n"
        echohl None
    else
        let l:indent_opt = ""
        if exists("g:brittany_indent")
          let l:indent_opt = " --indent " . g:brittany_indent
        endif

        let l:columns_opt = ""
        if exists("g:brittany_columns")
          let l:columns_opt = " --columns " . g:brittany_columns
        endif

        silent! exe "undojoin"
        silent! exe "keepjumps " . a:firstline . "," . a:lastline . "!" . g:brittany_command . l:indent_opt . l:columns_opt
    endif

    call winrestview(b:winview)
endfunction

function! brittany#BrittanyOnSave()
    if g:brittany_on_save == 1
        let b:winview = winsaveview()
        exe "%call brittany#Brittany()"
    endif
endfunction


augroup brittany
    autocmd!
    autocmd BufWritePre *.hs call brittany#BrittanyOnSave()
augroup END


command! -range=% Brittany exe "let b:winview = winsaveview() | <line1>, <line2>call brittany#Brittany()"
command! BrittanyEnable exe "call brittany#BrittanyEnable()"
command! BrittanyDisable exe "call brittany#BrittanyDisable()"
command! BrittanyToggle exe "call brittany#BrittanyToggle()"
