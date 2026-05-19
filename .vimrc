execute pathogen#infect()

set number
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set hlsearch

set autoindent
set pastetoggle=<F3>

filetype plugin indent on

syntax on

set t_Co=256

au FileType yaml setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2
au FileType jinja setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2

function! StartUp()
    if 0 == argc()
        NERDTreeToggle
    end
endfunction

au VimEnter * call StartUp()

colorscheme timski

map <C-n> :NERDTreeFocus<CR>
map <C-m> :noh<CR>

" Let airline show multiple buffers
let g:airline#extensions#tabline#enabled = 1

:nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

autocmd BufWritePre * %s/\s\+$//e

let NERDTreeShowHidden=1

command! Ghasyn
            \ let b:github_actions_workflow = 1 |
            \ setfiletype yaml |
            \ unlet! b:github_actions_yaml_syntax_loaded b:current_syntax |
            \ syntax clear |
            \ runtime! syntax/yaml.vim |
            \ runtime! after/syntax/yaml.vim |
            \ if exists('*github_actions#force_refresh_syntax') | call github_actions#force_refresh_syntax() | endif
