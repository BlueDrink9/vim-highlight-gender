" Highlight nouns according to gender.
" Installation: Place in runtimepath. In windows, C:\Users\%USERPROFILE%\vimfiles\syntax\vim-gender-highlight.vim
" Download dictionary and extract into single file of nouns. Use the method found at
" https://github.com/AAbouZaid/german-nouns-gender-analyzer
" Separate into separate files
" grep {m} dict.cc_nouns_with_gender.txt | sed s/\ {.}//g > masc.txt
" grep {f} dict.cc_nouns_with_gender.txt | sed s/\ {.}//g > fem.txt
" grep {n} dict.cc_nouns_with_gender.txt | sed s/\ {.}//g > neut.txt
" Place extracted dictionary files in "[scriptdir]/[language]-nouns/"
" Language can be changed by setting g:genderToHighlight. Should be the 2-letter lang code,
" eg "de", "fr", "en_nz" (but obviously not the last one, because english
" isn't gendered).

if exists("b:current_syntax")
    finish
endif

if !exists("g:genderToHighlight")
    let g:genderToHighlight = "de"
else
    let g:genderToHighlight = tolower(g:genderToHighlight)
endif

function! HighlightGenders()
    call vimHighlightGender#HighlightGenders()
endfunction
function! ClearHighlightedGenders()
    call vimHighlightGender#ClearHighlightedGenders()
endfunction

augroup gender
    autocmd!
    au OptionSet spelllang if &spell && &spelllang =~ g:genderToHighlight |
                \ call HighlightGenders() | endif
    au BufRead,BufEnter *
                \ if &spell && &spelllang =~ g:genderToHighlight |
                \ call HighlightGenders() | endif
    au OptionSet spelllang
                \ if !(&spelllang =~ g:genderToHighlight) |
                \ call ClearHighlightedGenders() | endif
    au BufRead,BufEnter *
                \ if !(&spelllang =~ g:genderToHighlight) |
                \ call ClearHighlightedGenders() | endif
augroup END
" syntax clear

let b:current_syntax = "vim-gender-highlight"
