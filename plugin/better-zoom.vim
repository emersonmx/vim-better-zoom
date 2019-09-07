" Author: Emerson Max de Medeiros SIlva <http://blog.emersonmx.dev/>
" Repository: https://github.com/emersonmx/vim-better-zoom

if exists("g:loaded_better_zoom") || v:version < 700 || &cp
  finish
endif
let g:loaded_better_zoom = 1

let g:better_zoom_min_width=20
let g:better_zoom_min_height=3

function! <SID>BetterZoom()
    let old_winminwidth=&winminwidth
    let old_winminheight=&winminheight
    let old_winheight=&winheight
    let save_pos = getpos(".")

    let &winminwidth=g:better_zoom_min_width
    let &winheight=g:better_zoom_min_height
    let &winminheight=g:better_zoom_min_height

    wincmd _
    wincmd |
    execute "normal! 0"

    call setpos('.', save_pos)
    let &winminwidth=old_winminwidth
    let &winminheight=old_winminheight
    let &winheight=old_winheight
endfunction

let s:better_zoom_enabled=0
function! s:better_zoom_auto()
    if s:better_zoom_enabled == 0
        return
    endif

    call <SID>BetterZoom()
endfunction

function! <SID>BetterZoomToggle()
    let s:better_zoom_enabled=!s:better_zoom_enabled
    if s:better_zoom_enabled == 1
        echo 'BetterZoom enabled'
        call s:better_zoom_auto()
    else
        echo 'BetterZoom disabled'
        wincmd =
    end
endfunction

command! BetterZoom call <SID>BetterZoom()
command! BetterZoomToggle call <SID>BetterZoomToggle()

augroup better_zoom
    autocmd!
    autocmd WinEnter * call s:better_zoom_auto()
augroup END
