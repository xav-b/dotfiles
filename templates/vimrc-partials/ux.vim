"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" UX: improve the overwhole usage experience
"
" Provisioning:
"   {{ ansible_managed }}
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Design:
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable                              " Turn on syntax highlighting allowing local overrides
set list                                   " show invisible characters
set nonumber                               " hide line numbers by default"
set ruler                                  " always show cursor coordinates
set lcs=tab:\|\ ,trail:·,extends:#,nbsp:_  " Show “invisible” characters
let g:indentLine_char = '|'                " see https://github.com/Yggdroot/indentLine
set cursorline                             " highlight current line"
set background=dark
" No annoying sound on errors
set noerrorbells
set novisualbell
" Neovim disallow changing 'enconding' option after initialization
" see https://github.com/neovim/neovim/pull/2929 for more details
if !has('nvim')
  set encoding=utf-8 nobomb                " Set default encoding to UTF-8
endif

try
  colorscheme {{ editor.colorscheme }}
catch
  " in case it's not installed
endtry

function! ToggleBG()
  let s:tbg = &background
  " inversion
  if s:tbg == "dark"
    set background=light
  else
    set background=dark
  endif
endfunction


function! s:HighlightLongLines(width)
    let targetWidth = a:width != '' ? a:width : 79
    if targetWidth > 0
        exec 'match Todo /\%>' . (targetWidth) . 'v/'
    else
        echomsg "Usage: HighlightLongLines [natural number]"
    endif
endfunction
" define :HighlightLongLines command to highlight the offending parts of
" lines that are longer than the specified length (defaulting to 80)
command! -nargs=? HighlightLongLines call s:HighlightLongLines('<args>')


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" StatusLine:
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set cmdheight=1
set showcmd                     " Show incomplete cmds down the bottom
set showmode                    " Show current mode down the bottom
set laststatus=2                          " always show the status line

" Make the command line two lines high and change the statusline display to
" something that looks useful.
function! CWD()
    let curdir = substitute(getcwd(), '{{ ansible_env.HOME }}', '~', 'g')
    return curdir
endfunction

set statusline+=%{fugitive#statusline()}\ (%{&ff})\ %{ALEGetStatusLine()}
