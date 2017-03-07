"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Misc: Various micro settings
"
" Provisioning:
"   {{ ansible_managed }}
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Gundo:   Graph your Vim undo tree in style
" Github:  https://github.com/sjl/gundo.vim
" Website: http://sjl.bitbucket.org/gundo.vim/
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" open on the right so as not to compete with the nerdtree
let g:gundo_right = 1
" let g:gundo_width = 60
" let g:gundo_preview_height = 40
" let g:gundo_right = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" YankRing: Maintains a history of previous yanks, changes and deletes
" Github:   https://github.com/vim-scripts/YankRing.vim
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:yankring_max_history = 50
let g:yankring_persist = 1
nnoremap <leader>yr :YRShow<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" EasyAlign: A Vim alignment plugin
" Github:    https://github.com/junegunn/vim-easy-align
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TODO test
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" CtrlP:  A Vim alignment plugin
" Github: https://github.com/kien/ctrlp.vim
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set runtimepath^=~/.vim/plugged/ctrlp.vim
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git$\|\.hg$\|\.svn$'
" Default to filename searches
let g:ctrlp_by_filename = 1
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_height = 20
if executable("ag")
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
endif

" We don't want to use Ctrl-p as the mapping because
" it interferes with YankRing (paste, then hit ctrl-p)
let g:ctrlp_map = '<leader>v'
nnoremap <silent> <leader>v :CtrlPMixed<CR>

"Ctrl-m is not good - it overrides behavior of Enter
nnoremap <silent> <C-M> :CtrlPBufTag<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Syntastic:  Syntax checking hacks for vim
" Github:     https://github.com/scrooloose/syntastic
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Linters
let g:syntastic_python_checkers=['pylint']
let g:syntastic_javascript_checkers = ['eslint', 'jscs']"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Gitgutter:  A Vim plugin which shows a git diff in the gutter (sign column)
" Github:     https://github.com/airblade/vim-gitgutter
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:gitgutter_enabled=0
nnoremap <silent> <leader>d :GitGutterToggle<cr>
