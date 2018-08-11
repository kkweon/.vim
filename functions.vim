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
    execute "normal \<C-l>"
endfunction

" :Google how do I vim?
command! -nargs=+ Google :call MoGoogle(<f-args>)
