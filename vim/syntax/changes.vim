" Vim syntax file
" Filename:     changes.vim
" Language:     SuSE package changes
" Maintainer:   Michal Svec <msvec@suse.cz>
" Last change:  20.8.2003

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Keywords
syn keyword ChangesArch i386 i486 i586 i686 athlon ia64 xa86_64
syn keyword ChangesArch I386 I486 I586 I686 ATHLON IA64 XA86_64
syn keyword ChangesArch ppc axp mips armv4l s390 s390x S/390 s/390
syn keyword ChangesArch PPC AXP MIPS ARMV4L S390 S390x S390X
syn keyword sparc sparc64 Sparc Sparc64 SPARC SPARC64 noarch NOARCH

" Highlights
syn match ChangesDate "^[A-Z][a-z][a-z] [A-Z][a-z][a-z] [ 0-9][0-9] [0-9:]\{8\} [A-Z]\+ [0-9]\+"
syn match ChangesDate "^[A-Z][a-z][a-z] [A-Z][a-z][a-z] [ 0-9][0-9] [0-9:]\{8\} [0-9]\+"
syn match ChangesMail " - \<[a-zA-Z\.]\+@[a-zA-Z\.]\+\>$"
syn match ChangesMailText "\<[a-zA-Z\.]\+@[a-zA-Z\.]\+\>"
syn match ChangesSeparator "^-\{40,78\}$"
syn match ChangesBug "#[0-9]\+\>"

" Colors
hi ChangesArch ctermfg=blue ctermbg=NONE
hi ChangesDate ctermfg=darkgreen ctermbg=NONE
hi ChangesMail ctermfg=darkred ctermbg=NONE
hi ChangesMailText ctermfg=darkred ctermbg=NONE
hi ChangesSeparator ctermfg=darkgreen ctermbg=NONE
hi ChangesBug ctermfg=red ctermbg=NONE

" Syntax name
let b:current_syntax = "changes"
