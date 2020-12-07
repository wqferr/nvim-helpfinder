if exists('g:loaded_helpfinder')
    finish
endif

function! helpfinder#search(term)
    execute 'lhelpgrep \*.*\c\V'.a:term.'\v.*\*'
    lopen
    helpc
endfunction

function! helpfinder#expand_cword()
    let pat = '\(\[[:alnum:]._#]\)\@!'

    let cword_start = searchpos('\V'.pat.'\.', 'cbn', line('.'))
    if cword_start[0] == 0
        return v:null
    else
        let cword_start = cword_start[1]
    endif

    let cword_end = searchpos('\V\.'.pat, 'cn', line('.'))
    if cword_end[0] == 0
        return v:null
    else
        let cword_end = cword_end[1]
    endif

    return strcharpart(getline('.'), cword_start, cword_end-cword_start)
endfunction

function! helpfinder#cursor_lookup()
    let cword = helpfinder#expand_cword()
    call helpfinder#search(cword)
endfunction

if !exists('g:helpfinder_nodefine_maps')
    nmap <silent> <leader>K <cmd>call helpfinder#cursor_lookup()<cr>
endif

let g:loaded_helpfinder = 1
