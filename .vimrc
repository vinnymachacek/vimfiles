"Set Shell - Needed for pathogen
set shell=/bin/bash
set mouse=vi
set clipboard=unnamed

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

filetype plugin indent on
syntax on

"for status bar on bottom
set laststatus=2

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"Turn on line numbering
set number

"for Filetree sidebar
map <C-n> :NERDTreeToggle<CR>

"autocomplete
set complete+=k~/.vim/dictionaries/cfn.dict.txt
set complete+=k~/.vim/dictionaries/cfn-snippets.dict.txt

set iskeyword+=:
set iskeyword+=-

"Indent
set shiftwidth=4
set cindent
set expandtab
set autoindent
set smartindent

"Prevent annoying comments on new lines
set formatoptions-=cro

let g:syntastic_json_checkers=['jsonlint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height=5

let g:airline#extensions#syntastic#enabled = 1

let g:SuperTabContextDefaultCompletionType = "<c-n>"
let g:SuperTabDefaultCompletionType = "<c-n>"


"Theming
:colorscheme lucius
:LuciusDarkLowContrast

"KeyMappings
"nnoremap <F5> :call functions#ExecuteFile()<CR>
map <C-j><C-j> :%!python -m json.tool <CR>

nnoremap <C-j><C-v> :call functions#ValidateFile()<CR>
nnoremap <C-j><C-b> :call functions#CreateStackFromFile()<CR>
nnoremap <C-j><C-u> :call functions#UpdateStackFromFile()<CR>
nnoremap <C-j><C-p> :call functions#CreateParamsFile()<CR>


nnoremap <silent> <C-s> :SyntasticCheck <CR>
nmap <C-N><C-N> :set invnumber<CR>

nnoremap <silent> <C-e> :lopen<CR>

au BufRead,BufNewFile *.params setfiletype json
au BufRead,BufNewFile *.params set filetype=json
