"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Bundles:
"   load plugins with vim-plug
"
" Provisioning:
"   {{ ansible_managed }}
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

  " UI
{% for plugin in vim_plugins_ui %}
  Plug {{ plugin }}
{% endfor %}

  " syntax/languages
{% for plugin in vim_plugins_languages %}
  Plug {{ plugin }}
{% endfor %}

  " Essential plugins
{% for plugin in vim_plugins %}
  Plug {{ plugin }}
{% endfor %}

  " development focused plugins
{% for plugin in vim_plugins_dev %}
  Plug {{ plugin }}
{% endfor %}

  " auto-completion plugins
{% for plugin in vim_plugins_completion %}
  Plug {{ plugin }}
{% endfor %}

" Add plugins to &runtimepath
call plug#end()
