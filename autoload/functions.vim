" vmachacek functions
"
"
command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>
command! -nargs=1 Silent
            \ | execute ':silent !'.<q-args>
            \ | execute ':redraw!'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""" RUN CURRENT FILE """""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Will attempt to execute the current file based on the `&filetype`
" You need to manually map the filetypes you use most commonly to the
" correct shell command.
function! functions#ValidateFile()
  let filetype_to_command = {
  \   'json': 'aws --output json cloudformation validate-template --template-body file:// %'
  \ }
  let cmd = get(filetype_to_command, &filetype, &filetype)
  call RunShellCommandOnlyShowErrors(cmd)
endfunction

function! functions#CreateStackFromFile()
  let filetype_to_command = {
  \   'json': 'bash  ~/.vim/scripts/create-stack.sh  %',
  \ }
  let cmd = get(filetype_to_command, &filetype, &filetype)
  call RunShellCommandOnlyShowErrors(cmd)
endfunction

function! functions#UpdateStackFromFile()
  let filetype_to_command = {
  \   'json': 'bash  ~/.vim/scripts/update-stack.sh  %'
  \ }
  let cmd = get(filetype_to_command, &filetype, &filetype)
  call RunShellCommandOnlyShowErrors(cmd)
endfunction


function! functions#CreateParamsFile()
  let filetype_to_command = {
  \   'json': 'python ~/.vim/scripts/gen-params.py  %'
  \ }
  let cmd = get(filetype_to_command, &filetype, &filetype)
  call RunShellCommand(cmd)
  set filetype=json
  set syntax=json
endfunction
" Enter any shell command and have the output appear in a new buffer
" For example, to word count the current file:
"
"   :Shell wc %s
"
" Thanks to: http://vim.wikia.com/wiki/Display_output_of_shell_commands_in_new_window
command! -complete=shellcmd -nargs=+ Shell call RunShellCommand(<q-args>)
function! RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, ' '.part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal bufhidden=wipe nobuflisted noswapfile nowrap
  execute ':silent $read !'. expanded_cmdline
  file #.params
endfunction 


command! -complete=shellcmd -nargs=+ Shell call RunShellCommand(<q-args>)
function! RunShellCommandOnlyShowErrors(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, ' '.part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  "call setline(3,substitute(getline(2),'.','=','g'))
  execute ':silent $read !'. expanded_cmdline
  setlocal nomodifiable
  1
  if ! (v:shell_error)
    bdelete
  endif
endfunction



