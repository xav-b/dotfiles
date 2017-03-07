"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Filetypes:
"   customize setup depending on the filetype
"
" Provisioning:
"   {{ ansible_managed }}
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Customize settings for vim-template
let g:username = "hackliff"
let g:email = "xavier.bruhiere@gmail.com"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

filetype plugin on
filetype indent on      " load filetype-specific indent files

"  they are wrapped in an augroup as this ensures the autocmd's are only
"  applied once
augroup configgroup

  " TODO check what the two first line do
  autocmd!
  autocmd VimEnter * highlight clear SignColumn
  " FIXME autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
    \:call <SID>DeleteTrailingWS()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Filetype: Misc
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  autocmd BufRead,BufNewFile *.pde setfiletype arduino
  autocmd BufRead,BufNewFile *.ino setfiletype arduino
  autocmd FileType matlab setlocal keywordprg=info\ octave\ --vi-keys\ --index-search

  " In Makefiles, use real tabs, not tabs expanded to spaces
  autocmd FileType make setlocal noexpandtab

  " Make sure all mardown files have the correct filetype set and setup wrapping
  autocmd BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown
  if !exists("g:disable_markdown_autostyle")
    autocmd FileType markdown setlocal wrap linebreak textwidth=72 nolist
  endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Filetype: Python
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  autocmd FileType python setlocal commentstring=#\ %s
  " make Python follow PEP8 for whitespace
  " (http://www.python.org/dev/peps/pep-0008/)
  autocmd FileType python setlocal tabstop=4 shiftwidth=4

  " uses `isort` to automatically sort imports
  " so it requires `pip install isort` to work
  " https://github.com/timothycrosley/isort
  autocmd FileType python nnoremap <leader>i :!isort %<CR><CR>

  " uses `yapf` to automatically fmt python file
  " so it requires `pip install yapf` to work
  " https://github.com/google/yapf
  autocmd FileType python nnoremap <leader>= :0,$!yapf<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Filetype: Ruby
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " This actually might be confusing, but the plugin +ruby+ already does this,
  " so we want to do it only if the plugin +ruby+ is disabled for some reason
  " Set the Ruby filetype for a number of common Ruby files without .rb
  autocmd BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,Guardfile,config.ru,*.rake} set ft=ruby
  autocmd FileType ruby setlocal commentstring=#\ %s


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Filetype: Go
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  au FileType go nmap <Leader>gd <Plug>(go-doc)
  au FileType go nmap <Leader>i <Plug>(go-info)

augroup END

let g:go_fmt_command = "goimports"
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }
