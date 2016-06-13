"Set Shell - Needed for pathogen
set shell=/bin/bash

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

"Theming
:colorscheme lucius
:LuciusDarkLowContrast

"KeyMappings
nnoremap <F5> :call functions#ExecuteFile()<CR>
map <C-j> :%!python -m json.tool <CR>

nnoremap <silent> <C-s> :SyntasticCheck <CR>
nmap <C-N><C-N> :set invnumber<CR>

nnoremap <silent> <C-e> :lopen<CR>
