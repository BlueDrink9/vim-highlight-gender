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

if exists("b:current_syntax")
    finish
endif

augroup gender
    autocmd!
    au BufRead,BufEnter,InsertChange * if &spelllang =~ g:genderToHighlight | call HighlightGenders | else call ClearHightlightedGenders | endif
augroup END
" syntax clear

if !exists(g:genderToHighlight)
    let g:genderToHighlight = "de"
else
    let g:genderToHighlight = tolower(g:genderToHighlight)
endif

function! HighlightGenders()
    echom "Loaded gender highlighting"
    let s:cwd = getcwd()
    let s:dictPath = expand('<sfile>:p:h') . expand("/" . g:genderToHighlight . "-nouns/")
    exec 'lcd ' . s:dictPath
    setlocal iskeyword+=-
    " let s:oldSynCaseMatch = &syn case
    syn case match

    " Currently unused. May eventually be used for plurals, endings, etc so more
    " nouns are recognised.
    let s:possibleEndings = ['en', 's', 'e']

    let s:mascWords = join(readfile('masc.txt'))
    exec 'syn keyword masculine ' . s:mascWords
    let s:femWords = join(readfile('fem.txt'))
    exec 'syn keyword feminine ' . s:femWords
    " let s:neutWords = join(readfile('neut.txt'))
    " exec 'syn keyword neuter ' . s:neutWords

    " For some reason, neuter's file isn't playing nice with the one-line method.
    let s:neutWords = readfile('neut.txt')
    for wor in s:neutWords
        exec 'syn keyword neuter ' . wor
    endfor

    " solarized: Constant is more of a cyan, directory is semi-consistently blue, even outside of sol.
    " highlight link masculine Constant
    highlight link masculine Directory
    " sol: helpnote is pink.
    highlight link feminine helpNote
    " sol: statement is green.
    highlight link neuter Statement

    exec 'lcd ' . s:cwd
endfunction

function! ClearHighlightedGenders()
    syntax clear masculine
    syntax clear feminine
    syntax clear neuter
endfunction

let b:current_syntax = "vim-gender-highlight"
