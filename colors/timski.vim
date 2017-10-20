" modified syntax file
" Adapted from elflord.vim

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "timski"



"              228 = Light Yellow
hi Normal      ctermfg=228        guifg=#ffffaa   guibg=black

" Oranges include 208, 202, 172, 94
hi Comment     ctermfg=208        guifg=#ff9933   term=bold

hi Constant    ctermfg=Magenta    guifg=Magenta   term=underline 
"              46 = Normal Green
hi String      ctermfg=46         guifg=Magenta   term=underline 
"              36 = Turquoise
hi Character   ctermfg=36         guifg=Magenta   term=underline 
"              91 = Dark Purple
hi Number      ctermfg=39         guifg=Magenta   term=underline 
hi Boolean     ctermfg=51         guifg=Magenta   term=underline 
hi Float       ctermfg=Magenta    guifg=Magenta   term=underline 

"              75 = Lighter Blue
hi Identifier  ctermfg=75 cterm=bold guifg=#40ccff gui=bold term=bold 
"              27 = Pretty Blue
hi Function    ctermfg=27 cterm=bold guifg=#2060ff gui=bold term=bold      

"              220 = Bold Yellow
hi Statement   ctermfg=220    cterm=bold guifg=#eeee88  gui=bold  term=bold      
hi Repeat      ctermfg=White      guifg=white              term=underline 
hi Conditional ctermfg=White      guifg=white              term=underline 
hi Operator    ctermfg=Red        guifg=Red                  
hi Label       ctermfg=Yellow     guifg=#aa4444
hi Keyword     ctermfg=Yellow     guifg=#aa4444
hi Exception   ctermfg=Yellow     guifg=#aa4444

hi PreProc     ctermfg=LightBlue  guifg=#ff80ff            term=underline 
hi Include     ctermfg=LightBlue  guifg=#ff80ff            term=underline 
hi Define      ctermfg=LightBlue  guifg=#ff80ff            term=underline 
hi Macro       ctermfg=LightBlue  guifg=#ff80ff            term=underline 
hi PreCondit   ctermfg=LightBlue  guifg=#ff80ff            term=underline 

hi Type           ctermfg=LightCyan  guifg=#60ff60   gui=bold term=underline 
hi StorageClass   ctermfg=LightCyan  guifg=#60ff60   gui=bold term=underline 
hi Structure      ctermfg=LightCyan  guifg=#60ff60   gui=bold term=underline 
hi Typedef        ctermfg=LightCyan  guifg=#60ff60   gui=bold term=underline 

"                 5 = DarkMagenta
hi Special        ctermfg=5         guifg=Red             term=bold 
hi Tag            ctermfg=5         guifg=Red             term=bold 
hi SpecialChar    ctermfg=5         guifg=Red             term=bold 
"                 127 = Magenta
hi Delimiter      ctermfg=165       guifg=Red             term=bold 
hi SpecialComment ctermfg=5         guifg=Red             term=bold 
hi Debug          ctermfg=5         guifg=Red             term=bold 

"             0 = Black
hi Ignore     ctermfg=0               guifg=bg
"             15 = White  1 = Red
hi Error      ctermfg=15  ctermbg=1   guifg=White  guibg=Red    term=reverse 

"             0 = Black   11 = Yellow
hi Todo       ctermfg=0   ctermbg=11  guifg=Blue   guibg=Yellow term=standout  











