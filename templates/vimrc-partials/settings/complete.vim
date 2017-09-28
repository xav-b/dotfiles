"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Autocompletion: smart autocompletion and snippets
"
" Provisioning:
"   {{ ansible_managed }}
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" UtilSnips: The ultimate snippet solution for Vim
" Github:    https://github.com/SirVer/ultisnips
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="horizontal"
let g:ultisnips_python_style = "google"
let g:ultisnips_python_quoting_style = "simple"
let g:ultisnips_python_triple_quoting_style = "double"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Deoplete: Dark powered asynchronous completion framework for neovim
" Github:   https://github.com/Shougo/deoplete.nvim
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
call deoplete#custom#set('ultisnips', 'matchers', ['matcher_fuzzy'])


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Neoformat: ✨  A (Neo)vim plugin for formatting code.
" Github:    https://github.com/sbdchd/neoformat
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" auto-format on save
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

let g:neoformat_enabled_python = ['yapf', 'autopep8']
" NOTE what about eslint_d or prettier-eslint ?
let g:neoformat_enabled_javascript = ['prettier']
" TODO add others https://github.com/sbdchd/neoformat#supported-filetypes
