set nocompatible
filetype off                   " required!
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/Vundle.vim'

" My Plugins here:
"
" original repos on github
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'
Plugin 'groenewege/vim-less'
Plugin 'ap/vim-css-color'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'sophacles/vim-bundle-mako'
Plugin 'klen/python-mode'
Plugin 'tpope/vim-abolish'
Plugin 'chriskempson/base16-vim'
Plugin 'bling/vim-airline'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'luochen1990/rainbow'
Plugin 'KabbAmine/zeavim.vim'
Plugin 'tpope/vim-obsession'
Plugin 'altercation/vim-colors-solarized'

" vim-scripts
Plugin 'L9'
Plugin 'TaskList.vim'
Plugin 'Latex-Text-Formatter'

call vundle#end()
filetype plugin indent on

set background=dark
colorscheme solarized

set modeline
set smartindent
set tabstop=4
set shiftwidth=4
set textwidth=79
set backspace=indent,eol,start
set softtabstop=4
set expandtab
set clipboard=unnamed
set go+=a
set number
set laststatus=2
set foldenable
set foldmethod=syntax
set foldopen=block,hor,percent,quickfix,tag
set foldlevel=1

" Backup
set noswapfile
set backupdir=~/.vim/tmp

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,latin1
endif

" Now, make python work with virtualenvs:
if has("python") && !empty($VIRTUAL_ENV)
  python << EOF
import os
import sys
a = os.environ['VIRTUAL_ENV'] + '/bin/activate_this.py'
execfile(a, dict(__file__ = a))
if 'PYTHONPATH' not in os.environ:
    os.environ['PYTHONPATH'] = ''
    os.environ['PYTHONPATH'] += os.getcwd()+":"
    os.environ['PYTHONPATH'] += ":".join(sys.path)
EOF
endif

syntax enable

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

" Make syntastic work nicer
let g:syntastic_enable_balloons = 1
" pylint gives me the shits.
let g:syntastic_python_checkers = ['flake8', 'pyflakes']
" Don't whinge about c++11, you brat!
let g:syntastic_cpp_compiler_options = '-I${HOME}/openmpi/env/include -std=c++11'
let g:syntastic_auto_loc_list=1

" Map f8 for Tagbar
nmap <F8> :TagbarToggle<CR>

" Remap ctrl+arrows to move between window splits
nmap <silent> <C-Up> :wincmd k<CR>
nmap <silent> <C-Down> :wincmd j<CR>
nmap <silent> <C-Left> :wincmd h<CR>
nmap <silent> <C-Right> :wincmd l<CR>

" QuickFix close function; :q should close a window *and* the accompanying
" quickfix
aug QFClose
  au!
  " if |q| doesn't work use |cclose| ?
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

" Javascript folding that doesn't suck
let javaScript_fold=1
au FileType javascript call JavaScriptFold()

" Conceal
set conceallevel=2
hi Conceal ctermbg=234 ctermfg=81
fu! SetCppConceals()
    syntax match cppSmartPtr "\(std::\)\?unique_ptr" conceal cchar=●
    syntax match cppSmartPtr "\(std::\)\?shared_ptr" conceal cchar=◆
    syntax match cppSmartPtr "\(std::\)\?weak_ptr" conceal cchar=▲
endfunction
au FileType cpp call SetCppConceals()

let g:rainbow_active = 1
let g:rainbow_conf = {
   \ 'ctermfgs': ['Darkblue', 'darkgreen', 'darkcyan', 'darkred', 'darkmagenta', 'brown', 'grey', 'lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
   \ 'separately': {
   \   'cpp': {
   \     'parentheses': [
   \       'start=/(/ end=/)/ fold',
   \       'start=/\[/ end=/\]/ fold',
   \       'start=/{/ end=/}/ fold',
   \       'start=/\(\(\<operator\>\)\@<!<\)\&[a-zA-Z0-9_]\@<=<\ze[^<]/ end=/>/']
   \   }
   \ }
\ }

" eclim for Java code :(
let g:EclimCompletionMethod = 'omnifunc'
au FileType java set noexpandtab

" I'm going to break this god damn habit
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
