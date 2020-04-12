if exists('g:loaded_textobj_php')
  finish
endif

augroup method_textobjs
    autocmd!
    autocmd FileType php call textobj#user#plugin('method', {
            \   '-': {
            \     'select-a-function': 'textobj#php#select_method_a',
            \     'select-a': 'am',
            \     'select-i-function': 'textobj#php#select_method_i',
            \     'select-i': 'im',
            \   },
            \ })

    function! textobj#php#select_method_a()
        if search('[ ]\+\(private\|public\|protected\) function [a-zA-Z0-9_]\+(', 'bcW') == 0
            return 0
        endif
        let head_pos = getpos('.')
        if search('{', 'cW') == 0
            return 0
        endif
        normal! %
        let tail_pos = getpos('.')
        return ['v', head_pos, tail_pos]
    endfunction

    function! textobj#php#select_method_i()
        if search('[ ]\+\(private\|public\|protected\) function [a-zA-Z0-9_]\+(', 'bcW') == 0
            return 0
        endif
        let head_pos = getpos('.')
        if search('{', 'cW') == 0
            return 0
        endif
        normal! j
        normal! ^
        let head_pos = getpos('.')
        normal! k
        normal! %
        normal! k
        normal! $
        let tail_pos = getpos('.')
        return ['v', head_pos, tail_pos]
    endfunction
augroup END

let loaded_textobj_php = 1
