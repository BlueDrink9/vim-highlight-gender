# vim-highlight-gender
Highlight gender of nouns in a language, defined by a dictionary file. Designed for German.

## Requirements

3 files, `masc.txt`, `fem.txt` and `neut.txt`, which contain a single noun on each line of the gender specified by the file.
How to generate such files is covered in **installation**.

## Installation

1. Place in runtimepath.
<!-- In windows, C:\Users\%USERPROFILE%\vimfiles\syntax\vim-gender-highlight.vim -->
2. Download dictionary and extract into single file of nouns. Use the method found at
[AAbouZaid/german-nouns-gender-analyzer](https://github.com/AAbouZaid/german-nouns-gender-analyzer).
3. Separate into separate files  
  ```bash
  grep {m} dict.cc_nouns_with_gender.txt | sed s/\ {.}//g > masc.txt
  grep {f} dict.cc_nouns_with_gender.txt | sed s/\ {.}//g > fem.txt
  grep {n} dict.cc_nouns_with_gender.txt | sed s/\ {.}//g > neut.txt
  ```
4. Place extracted dictionary files in `[scriptdir]/[language]-nouns/`

## Config

Language can be changed by setting g:genderToHighlight. Should be the 2-letter lang code (e.g. "de").

Only tested with german using the dict.cc dictionary.
