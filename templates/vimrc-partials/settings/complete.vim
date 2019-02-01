"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Autocompletion: smart autocompletion and snippets
"
" Provisioning:
"   {{ ansible_managed }}
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" cool abreviations
abbrev rtfm read the fine manual
abbrev ipdb import ipdb; ipdb.set_trace()
" TODO a snippet with parameter
abbrev iose import os; os._exit(0)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" LanguageClient: Language Server Protocol (LSP) support for vim and neovim.
" Github:         https://github.com/autozimu/LanguageClient-neovim
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NOTE not sure if this is already the standard assume
" set tags=tags;/

" A few installation steps required
" pip install futures configparser isort
" pip install python-language-server
" pip install pyls-mypy

" Required for operations modifying multiple buffers like rename.
set hidden

" FIXME need to install that outside
let g:LanguageClient_serverCommands = {
  \ 'python': ['/Users/xav/.virtualenvs/alexandrie/bin/pyls'],
  \ }

nnoremap <silent> gm :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" UtilSnips: The ultimate snippet solution for Vim
" Github:    https://github.com/SirVer/ultisnips
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NOTE now using neosnippet - it seems to integrate better with deoplete but
" to be fair, beyond that, I prefer UltiSnips. Yet we could use UltiSnips
" snippets with neosnippets engine.
"let g:UltiSnipsExpandTrigger       = '<leader>e'
"let g:UltiSnipsJumpForwardTrigger  = '<c-K>'
"let g:UltiSnipsJumpBackwardTrigger = '<c-L>'

" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="horizontal"
"let g:ultisnips_python_style = 'google'
"let g:ultisnips_python_quoting_style = 'simple'
"let g:ultisnips_python_triple_quoting_style = 'double'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Neosnippets: The Neosnippet plug-In adds snippet support to Vim
" Snippets:    https://github.com/Shougo/neosnippet-snippets
" Github:      https://github.com/Shougo/neosnippet.vim
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" let g:AutoPairsMapCR=0
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Deoplete: Dark powered asynchronous completion framework for neovim
" Github:   https://github.com/Shougo/deoplete.nvim
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
call deoplete#custom#set('ultisnips', 'matchers', ['matcher_fuzzy'])

" additional completion for rust
let g:racer_experimental_completer = 1


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
  "autocmd BufWritePre,TextChanged,InsertLeave * | Neoformat
augroup END

let g:neoformat_python_black = {
  \ 'exe': 'black',
  \ 'replace': 1,
  \ 'args': ['--line-length 100', '--skip-string-normalization', '--py36'],
\ }

" TODO move to black
let g:neoformat_enabled_python = ['black']
" NOTE what about eslint_d or prettier-eslint ?
let g:neoformat_enabled_javascript = ['prettier']
" TODO add others https://github.com/sbdchd/neoformat#supported-filetypes
