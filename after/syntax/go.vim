
" 设置 goCapitalizedWord 高亮组的颜色为蓝色
hi MyHighlight ctermfg=red guifg=red

hi link goCapitalizedWor MyHighlight

" 定义一个 syn 的高亮组叫 goCapitalizedWord
syn match goCapitalizedWor "\v<[A-Z]\w*>" contains=ALL
