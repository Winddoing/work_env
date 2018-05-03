" $Id: apparmor.vim.in,v 1.6 2008/09/25 00:13:43 cb Exp $
"
" ----------------------------------------------------------------------
"    Copyright (c) 2005 Novell, Inc. All Rights Reserved.
"    Copyright (c) 2006-2008 Christian Boltz. All Rights Reserved.
"      
"    This program is free software; you can redistribute it and/or
"    modify it under the terms of version 2 of the GNU General Public
"    License as published by the Free Software Foundation.
"      
"    This program is distributed in the hope that it will be useful,
"    but WITHOUT ANY WARRANTY; without even the implied warranty of
"    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"    GNU General Public License for more details.
"      
"    You should have received a copy of the GNU General Public License
"    along with this program; if not, contact Novell, Inc.
"      
"    To contact Novell about this file by physical or electronic mail, 
"    you may find current contact information at www.novell.com.
"
"    To contact Christian Boltz about this file by physical or electronic
"    mail, you may find current contact information at www.cboltz.de/en/kontakt.
" ----------------------------------------------------------------------
"
" stick this file into ~/.vim/syntax/ and add these commands into your .vimrc 
" to have vim automagically use this syntax file for these directories:
"
" autocmd BufNewFile,BufRead /etc/apparmor.d/*        set syntax=apparmor
" autocmd BufNewFile,BufRead /etc/apparmor/profiles/* set syntax=apparmor

" profiles are case sensitive
syntax case match

" color setup...

" adjust colors according to the background

" switching colors depending on the background color doesn't work
" unfortunately, so we use colors that work with light and dark background.
" Patches welcome ;-)

"if &background == "light"
" light background
	hi sdProfileName ctermfg=lightblue
	hi sdHatName ctermfg=darkblue
	hi sdExtHat ctermfg=darkblue
"	hi sdComment2 ctermfg=darkblue
	hi sdGlob       ctermfg=darkmagenta
	hi sdAlias      ctermfg=darkmagenta
	hi sdEntryWriteExec     ctermfg=black ctermbg=yellow
	hi sdEntryUX     ctermfg=darkred cterm=underline
	hi sdEntryUXe     ctermfg=darkred
	hi sdEntryIX     ctermfg=darkcyan
	hi sdEntryM     ctermfg=darkcyan
	hi sdEntryPX     ctermfg=darkgreen cterm=underline
	hi sdEntryPXe     ctermfg=darkgreen
	hi sdEntryW     ctermfg=darkyellow
	hi sdCap	ctermfg=lightblue
	hi sdSetCap     ctermfg=black ctermbg=yellow
	hi sdNetwork	ctermfg=lightblue
	hi sdNetworkDanger ctermfg=darkred
	hi sdCapKey	cterm=underline ctermfg=lightblue
	hi sdCapDanger ctermfg=darkred
	hi sdRLimit ctermfg=lightblue
	hi def link sdEntryR Normal
	hi def link sdEntryK Normal
	hi def link sdFlags Normal
	hi sdEntryChangeProfile     ctermfg=darkgreen cterm=underline
"else 
" dark background
"	hi sdProfileName ctermfg=white
"	hi sdHatName ctermfg=white
"	hi sdGlob       ctermfg=magenta
"	hi sdEntryWriteExec     ctermfg=black ctermbg=yellow
"	hi sdEntryUX     ctermfg=red cterm=underline
"	hi sdEntryUXe     ctermfg=red
"	hi sdEntryIX     ctermfg=cyan
"	hi sdEntryM     ctermfg=cyan
"	hi sdEntryPX     ctermfg=green cterm=underline
"	hi sdEntryPXe     ctermfg=green
"	hi sdEntryW     ctermfg=yellow
"	hi sdCap	ctermfg=lightblue
"	hi sdCapKey	cterm=underline ctermfg=lightblue
"	hi def link sdEntryR Normal
"	hi def link sdFlags Normal
"	hi sdCapDanger ctermfg=red
"endif

hi def link sdInclude     Include
high def link sdComment     Comment
"high def link sdComment2     Comment
high def link sdFlagKey     TODO
high def link sdError      ErrorMsg


" always sync from the start.  should be relatively quick since we don't have
" that many rules and profiles shouldn't be _extremely_ large...
syn sync fromstart

syn keyword	sdFlagKey	complain audit debug

" highlight invalid syntax
syn match sdError /{/ contained
syn match sdError /}/
syn match sdError /^.*$/ contains=sdComment "highlight all non-valid lines as error
" TODO: do not mark lines containing only whitespace as error

" TODO: the sdGlob pattern is not anchored with ^ and $, so it matches all lines matching ^@{...}.*
" This allows incorrect lines also and should be checked better.
syn match sdGlob /\v\?|\*|\{.*,.*\}|[[^\]]\+\]|\@\{[a-zA-Z_]*\}/

syn match sdAlias /\v^alias\s+(\/|\@\{\S*\})\S*\s+-\>\s+(\/|\@\{\S*\})\S*\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdGlob

"syn match sdComment /#.*/

syn cluster sdEntry contains=sdEntryWriteExec,sdEntryR,sdEntryW,sdEntryIX,sdEntryPX,sdEntryPXe,sdEntryUX,sdEntryUXe,sdEntryM,sdCap,sdSetCap,sdExtHat,sdRLimit,sdNetwork,sdNetworkDanger,sdEntryChangeProfile


" TODO: support audit and deny keywords for all rules (not only for files)
" TODO: higlight audit and deny keywords everywhere

" Capability line

" normal capabilities - really keep this list? syn match sdCap should be enough... (difference: sdCapKey words would loose underlining)
syn keyword  sdCapKey          chown dac_override dac_read_search fowner fsetid kill setgid setuid setpcap linux_immutable net_bind_serv»ice net_broadcast net_admin net_raw ipc_lock ipc_owner sys_module sys_rawio sys_chroot sys_ptrace sys_pacct sys_boot sys_nice sys_resou»rce sys_time sys_tty_config mknod lease

" dangerous capabilities - highlighted separately
syn keyword sdCapDanger	       sys_admin

" full line. Keywords are from sdCapKey + sdCapDanger
syn match  sdCap /\v^\s*capability\s+(chown|dac_override|dac_read_search|fowner|fsetid|kill|setgid|setuid|setpcap|linux_immutable|net_bind_serv»ice|net_broadcast|net_admin|net_raw|ipc_lock|ipc_owner|sys_module|sys_rawio|sys_chroot|sys_ptrace|sys_pacct|sys_boot|sys_nice|sys_resou»rce|sys_time|sys_tty_config|mknod|lease|sys_admin)\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdCapKey,sdCapDanger,sdComment nextgroup=@sdEntry,sdComment,sdError,sdInclude
syn match  sdSetCap /\v^\s*set\s+capability\s+(chown|dac_override|dac_read_search|fowner|fsetid|kill|setgid|setuid|setpcap|linux_immutable|net_bind_serv»ice|net_broadcast|net_admin|net_raw|ipc_lock|ipc_owner|sys_module|sys_rawio|sys_chroot|sys_ptrace|sys_pacct|sys_boot|sys_nice|sys_resou»rce|sys_time|sys_tty_config|mknod|lease|sys_admin)\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdCapKey,sdCapDanger,sdComment nextgroup=@sdEntry,sdComment,sdError,sdInclude


" Network line
" Syntax: network domain (inet, ...) type (stream, ...) protocol (tcp, ...)
syn match  sdNetwork         /\v^\s*network(\s+(inet|ax25|ipx|appletalk|netrom|bridge|atmpvc|x25|inet6|rose|netbeui|security|key|packet|ash|econet|atmsvc|sna|irda|pppox|wanpipe|bluetooth))?(\s+(stream|dgram|seqpacket|rdm|packet))?(\s+(tcp|udp|icmp))?\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdComment nextgroup=@sdEntry,sdComment,sdError,sdInclude
" network rules containing 'raw'
syn match  sdNetworkDanger         /\v^\s*network(\s+(inet|ax25|ipx|appletalk|netrom|bridge|atmpvc|x25|inet6|rose|netbeui|security|key|packet|ash|econet|atmsvc|sna|irda|pppox|wanpipe|bluetooth))?(\s+(raw))(\s+(tcp|udp|icmp))?\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdComment nextgroup=@sdEntry,sdComment,sdError,sdInclude
" 'all networking' includes raw -> mark as dangerous
syn match  sdNetworkDanger         /\v^\s*network\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdComment nextgroup=@sdEntry,sdComment,sdError,sdInclude


" Change Profile
syn match   sdEntryChangeProfile    /\v^\s*change_profile\s+-\>\s+\S+\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdGlob,sdComment nextgroup=@sdEntry,sdComment,sdError,sdInclude


" rlimit
"
"syn match sdRLimit /\v^\s*rlimit\s+()\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdComment
syn match sdRLimit /\v^\s*rlimit\s+(nofile|locks|sigpending|nproc|rtprio)\s+[0-9]+\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdComment
syn match sdRLimit /\v^\s*rlimit\s+(fsize|data|stack|core|rss|as|memlock|msgqueue)\s+\<\=\s+[0-9]+([KMG])?\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdComment
syn match sdRLimit /\v^\s*rlimit\s+nice\s+(-1?[0-9]|-20|1?[0-9])\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdComment

" link rules
syn match sdEntryW /\v^\s+link\s+(subset\s+)?(\/|\@\{\S*\})\S*\s+-\>\s+(\/|\@\{\S*\})\S*\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdGlob


" file permissions
"
" write + exec/mmap - danger!
" known bug: accepts 'aw' to keep things simple
syn match  sdEntryWriteExec /\v^\s*((owner\s+)|(audit\s+)|(deny\s+))*(\/|\@\{\S*\})\S*\s+(l|r|w|a|m|k|[iuUpPcC]x)+(\s+-\>\s+\S+)?\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdGlob,sdComment nextgroup=@sdEntry,sdComment,sdError,sdInclude

" ux(mr) - unconstrained entry, flag the line red
syn match  sdEntryUX /\v^\s*((owner\s+)|(audit\s+)|(deny\s+))*(\/|\@\{\S*\})\S*\s+(r|m|k|ux)+(\s+-\>\s+\S+)?\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdGlob,sdComment nextgroup=@sdEntry,sdComment,sdError,sdInclude
" Ux(mr) - like ux + clean environment
syn match  sdEntryUXe /\v^\s*((owner\s+)|(audit\s+)|(deny\s+))*(\/|\@\{\S*\})\S*\s+(r|m|k|Ux)+(\s+-\>\s+\S+)?\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdGlob,sdComment nextgroup=@sdEntry,sdComment,sdError,sdInclude
" px/cx/pix/cix(mrk) - standard exec entry, flag the line blue
syn match  sdEntryPX /\v^\s*((owner\s+)|(audit\s+)|(deny\s+))*(\/|\@\{\S*\})\S*\s+(r|m|k|px|cx|pix|cix)+(\s+-\>\s+\S+)?\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdGlob,sdComment nextgroup=@sdEntry,sdComment,sdError,sdInclude
" Px/Cx/Pix/Cix(mrk) - like px/cx + clean environment
syn match  sdEntryPXe /\v^\s*((owner\s+)|(audit\s+)|(deny\s+))*(\/|\@\{\S*\})\S*\s+(r|m|k|Px|Cx|Pix|Cix)+(\s+-\>\s+\S+)?\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdGlob,sdComment nextgroup=@sdEntry,sdComment,sdError,sdInclude
" ix(mr) - standard exec entry, flag the line green
syn match  sdEntryIX /\v^\s*((owner\s+)|(audit\s+)|(deny\s+))*(\/|\@\{\S*\})\S*\s+(r|m|k|ix)+\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdGlob,sdComment nextgroup=@sdEntry,sdComment,sdError,sdInclude
" mr - mmap with PROT_EXEC
syn match  sdEntryM /\v^\s*((owner\s+)|(audit\s+)|(deny\s+))*(\/|\@\{\S*\})\S*\s+(r|m|k)+\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdGlob,sdComment nextgroup=@sdEntry,sdComment,sdError,sdInclude

" if we've got u or i without x, it's an error
" rule is superfluous because of the '/.*/ is an error' rule ;-)
"syn match  sdError /\v^\s*((owner\s+)|(audit\s+)|(deny\s+))*(\/|\@\{\S*\})\S*\s+(l|r|w|k|u|p|i)+\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdGlob,sdComment nextgroup=@sdEntry,sdComment,sdError,sdInclude

" write + append is an error also
"syn match  sdError /\v^\s*((owner\s+)|(audit\s+)|(deny\s+))*(\/|\@\{\S*\})\S*\s+(\S*r\S*a\S*|\S*a\S*w\S*)\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdGlob,sdComment nextgroup=@sdEntry,sdComment,sdError,sdInclude
syn match  sdError /\v^\s*((owner\s+)|(audit\s+)|(deny\s+))*(\/|\@\{\S*\})\S*\s+\S*(w\S*a|a\S*w)\S*\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdGlob,sdComment nextgroup=@sdEntry,sdComment,sdError,sdInclude

" write entry, flag the line yellow
syn match  sdEntryW /\v^\s*((owner\s+)|(audit\s+)|(deny\s+))*(\/|\@\{\S*\})\S*\s+(l|r|w|k)+\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdGlob,sdComment nextgroup=@sdEntry,sdComment,sdError,sdInclude
" append entry, flag the line yellow
syn match  sdEntryW /\v^\s*((owner\s+)|(audit\s+)|(deny\s+))*(\/|\@\{\S*\})\S*\s+(l|r|a|k)+\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdGlob,sdComment nextgroup=@sdEntry,sdComment,sdError,sdInclude

" read entry + locking, currently no highlighting
syn match  sdEntryK /\v^\s*((owner\s+)|(audit\s+)|(deny\s+))*(\/|\@\{\S*\})\S*\s+[rlk]+\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdGlob,sdComment nextgroup=@sdEntry,sdComment,sdError,sdInclude
" read entry, no highlighting
syn match  sdEntryR /\v^\s*((owner\s+)|(audit\s+)|(deny\s+))*(\/|\@\{\S*\})\S*\s+[rl]+\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdGlob,sdComment nextgroup=@sdEntry,sdComment,sdError,sdInclude

syn match sdExtHat  /\v^\s+(\^|profile\s+)\S+\s*,(\s*$|(\s*#.*$)\@=)/ contains=sdComment " hat without {...}




syn match sdProfileName /\v^((profile\s+)?\/\S+|profile\s+\S+)\s+(flags\=\((complain|audit)\)\s+)=\{/ contains=sdProfileStart,sdHatName,sdFlags,sdComment
syn match sdProfileStart /{/ contained 
syn match sdProfileEnd /^}\s*(#.*)?$/ contained " TODO: syn region does not (yet?) allow usage of comment in end=
                                                " TODO: Removing the $ mark from end= will allow non-comments also :-(
syn match sdHatName /\v^\s+(\^|profile\s+)\S+\s+(flags\=\((complain|audit)\)\s+)=\{/ contains=sdProfileStart,sdFlags,sdComment
syn match sdHatStart /{/ contained 
syn match sdHatEnd /}/ contained " TODO: allow comments + [same as for syn match sdProfileEnd]
syn match sdFlags /\vflags\=\((complain|audit)\)/ contained contains=sdFlagKey

syn match sdComment /\s*#.*$/
syn match sdInclude /\s*#include.*$/

" basic profile block...
" \s+ does not work in end=, therefore using \s\s*
syn region Normal start=/\v^(profile\s+)?\S+\s+(flags\=\(\S+\)\s+)=\{/ matchgroup=sdProfileEnd end=/^}\s*$/ contains=sdProfileName,Hat,@sdEntry,sdComment,sdError,sdInclude
syn region Hat start=/\v^\s+(\^|profile\s+)\S+\s+(flags\=\(\S+\)\s+)=\{/ matchgroup=sdHatEnd end=/^\s\s*}\s*$/ contains=sdHatName,@sdEntry,sdComment,sdError,sdInclude


