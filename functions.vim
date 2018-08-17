function! TrimEndLines()
    let save_cursor = getpos(".")
    :silent! %s#\($\n\s*\)\+\%$##
    call setpos('.', save_cursor)
endfunction

function! MoGoogle(...)
    let l:platform = system('uname')
    let l:base_google = "https://www.google.com/search?q="
    " type of a:000 is string[] (e.g., ["how", "do", "I", "vim?"])
    let l:search_term = join(a:000, ' ')
    let l:google_url = l:base_google . l:search_term
    if l:platform =~? "Darwin"
        let l:osx_base_cmd = "!open -a '/Applications/Google Chrome.app' '"
        let l:google_cmd =  l:osx_base_cmd .  l:google_url . "'"
    else
        let l:google_cmd = "!chrome '" . l:google_url . "'"
    end
    silent execute l:google_cmd
    silent! execute ":redraw!"
endfunction

" :Google how do I vim?
command! -nargs=+ Google :call MoGoogle(<f-args>)


function! s:MoIsExtension(...)
    let l:current_filename_extension = expand('%:e')
    for extension in a:000
        if l:current_filename_extension ==# extension
            return 1
        endif
    endfor
endfunction

function! s:MoIsJSFile()
    return s:MoIsExtension('js', 'jsx', 'ts', 'tsx')
endfunction

function! s:MoIsHTMLFile()
    return s:MoIsExtension('html', 'tmpl', 'tml')
endfunction

function! s:MoGoToFileByExtensions(extensions)
    let l:current_filename = expand('%:t:r')
    for extension in a:extensions
        let l:command = 'git ls-files --full-name | rg /'.  shellescape(l:current_filename) . '.' . extension
        let l:files = substitute(system(l:command), '\n\+$', '', '')
        if (l:files =~ '^\s*$')
            continue
        endif
        execute 'edit '. l:files
        return
    endfor
    echomsg 'No matching files.'
endfunction

function! s:MoGoToJSFile()
    call s:MoGoToFileByExtensions(['tsx', 'ts', 'jsx', 'js'])
endfunction

function! s:MoGoToHTMLFile()
    call s:MoGoToFileByExtensions(['html', 'tmpl', 'tml'])
endfunction

function! MoToggleViewFile()
    if s:MoIsJSFile()
        call s:MoGoToHTMLFile()
    elseif s:MoIsHTMLFile()
        call s:MoGoToJSFile()
    end
endfunction


augroup js_file_commands
    au!
    au FileType javascript,typescript,html,htmlcheetah nnoremap <buffer> <LocalLeader>tt :call MoToggleViewFile()<cr>
augroup END
