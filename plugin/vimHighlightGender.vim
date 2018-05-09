" Highlight nouns according to gender.
" Installation: Place in runtimepath. In windows, C:\Users\%USERPROFILE%\vimfiles\syntax\vim-gender-highlight.vim
" Download dictionary and extract into single file of nouns. Use the method found at
" https://github.com/AAbouZaid/german-nouns-gender-analyzer
" Separate into separate files
" grep {m} dict.cc_nouns_with_gender.txt | sed s/\ {.}//g > masc.txt
" grep {f} dict.cc_nouns_with_gender.txt | sed s/\ {.}//g > fem.txt
" grep {n} dict.cc_nouns_with_gender.txt | sed s/\ {.}//g > neut.txt
" Place extracted dictionary files in "[scriptdir]/[language]-nouns/"
" Language can be changed by setting g:genderToHighlight. Should be the 2-letter lang code.
"
"

" if exists("b:current_syntax")
"     finish
" endif

" let g:genderToHighlight = "de"
if !exists("g:genderToHighlight")
    let g:genderToHighlight = "de"
else
    let g:genderToHighlight = tolower(g:genderToHighlight)
endif

function! _HighlightGenders()
    call vimHighlightGender#HighlightGenders()
endfunction
function! _ClearHighlightedGenders()
    call vimHighlightGender#ClearHightlightedGenders()
endfunction

" augroup gender
"     autocmd!
"     " au BufRead,BufEnter,InsertChange * if &spelllang =~ g:genderToHighlight | call vim-highlight-gender#HighlightGenders | else echo "hi" | endif
"     au BufRead,BufEnter,InsertChange * if &spelllang =~ g:genderToHighlight |
"                 \ call _HighlightGenders() |
"                 \else |
"                 \ echo "Fuuuuck" |
"                 \endif
" augroup END
" syntax clear


let b:current_syntax = "vim-gender-highlight"
