execute pathogen#infect()

set number
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set autoindent
set pastetoggle=<F3>

filetype plugin indent on

syntax on

set t_Co=256

au FileType yaml setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2

function! StartUp()
    if 0 == argc()
        NERDTreeToggle
    end
endfunction

au VimEnter * call StartUp()

colorscheme timski

map <C-n> :NERDTreeFocus<CR>

" Let airline show multiple buffers
let g:airline#extensions#tabline#enabled = 1

:nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

autocmd BufWritePre * %s/\s\+$//e

