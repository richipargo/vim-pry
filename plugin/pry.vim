if exists("g:loaded_pry") || &cp || v:version < 700
  finish
endif

let g:loaded_pry = 1

nmap <leader>d :call pry#insert()<CR>

let g:pry_map = {
\ 'ruby' : "binding.pry",
\ 'javascript' : 'debugger;',
\ 'javascript.jsx' : 'debugger;',
\ 'typescript' : 'debugger;',
\ 'vue' : 'debugger;',
\ 'html.handlebars' : '{{debugger}}',
\ 'php' : 'eval(\Psy\sh());',
\}

function! pry#insert()
  if has_key(g:pry_map, &filetype)
    let text = get(g:pry_map, &filetype)
    call feedkeys('o', 'i')
    call feedkeys(text)
    call feedkeys("\<Esc>")
  else
    echo 'No mapping defined for filetype: ' . &filetype
  endif
endfunction
