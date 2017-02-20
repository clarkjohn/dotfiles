" log2.vim
" Vim syntax file
" Based on messages.vim - syntax file for highlighting kernel messages
if exists("b:current_syntax")
 finish
endif

" log levels
syn match log_error '.*] \(FATAL\|ERROR\).*'
syn match log_warning '.*] \(WARN\).*'

syn case ignore

" log level keywords
syn keyword log_info INFO
syn keyword log_debug DEBUG
syn keyword log_trace TRACE

" todo
syn keyword word_fatal fatal
syn keyword word_error error
syn keyword word_exception exception
syn keyword word_warning warning
syn keyword word_warn warn

" jdbc sql statements
syn match sql_select_statement 'Preparing: [Ss][Ee][Ll].*'
syn match sql_cud_statement 'Preparing: \([Ii][Nn][Ss][Ee][Rr][Tt]\|[Uu][Pp][Dd][Aa][Tt][Ee]\|[Dd][Ee][Ll][Ee][Tt][Ee]\).*'

" stacktrace
syn match log_stacktrace_divide "^java.*Exception.*"
syn match log_stacktrace_divide "^java.*Error.*"
syn match log_stacktrace_divide "^Caused [Bb]y: .*"
syn match log_stacktrace "^\tat .*"

" email
syn match email '\v[_=a-z\./+0-9-]+\@[a-z0-9._-]+\a{2}'

" URL todo
"syn match mailURL /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/
" syn match mailURL /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/
" syn match mailURL '\v\c%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+\@[a-z]+.[a-z]+:)%(\.'%([&:#*@~%_\-=?!+;/.0-9A-Za-z]*%(%([.,][&:#*@~%_\-=?!+;/0-9A-Za-z]+)+|:\d+))?\.'%(\([&:#*@~%_\-=?!+;/.0-9A-Za-z]*\))?%(\[[&:#*@~%_\-=?!+;/.0-9A-Za-z]*\])?\.'%(\{%([&:#*@~%_\-=?!+;/.0-9A-Za-z]*|\{[&:#*@~%_\-=?!+;/.0-9A-Za-z]*\})\})?\.')*[-/0-9A-Za-z]*'
"syntax match  mailURL /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/
"syn match mailURL /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/
syn match mailURL /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?/  "works
" syn match  mailURL /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/

" Match IP addresses and optional port number
syn match ip_with_port '\([0-9]\{1,3}\.[0-9]\{1,3}\.[0-9]\{1,3}\.[0-9]\{1,3}\)\(:[0-9]\{1,5}\)\?'

" A component is something between brackets
syn match component '\[[^\]]*\]' oneline contains=ip_with_port, email, word_fatal, word_error, word_exception, word_warning, word_warn
syn region component2 start='{' end='}' oneline contains=ip_with_port, email, word_fatal, word_error, word_exception, word_warning, word_warn
syn region component3 start=/"/ end=/"/ skip=/\\./ oneline contains=ip_with_port, email, word_fatal, word_error, word_exception, word_warning, word_warn
syn region component4 start=/'/ end=/'/ skip=/\\./ oneline contains=ip_with_port, email, word_fatal, word_error, word_exception, word_warning, word_warn

" color
hi Normal ctermfg=251

hi mailURL ctermfg=70
hi email ctermfg=13

hi log_error ctermfg=160
hi log_warning ctermfg=220
hi log_info ctermfg=15
hi log_debug ctermfg=251
hi log_trace ctermfg=245

hi word_fatal ctermfg=160
hi word_warning ctermfg=220

hi sql_cud_statement ctermfg=69
hi sql_select_statement ctermfg=123

hi log_stacktrace ctermfg=240
hi log_stacktrace_divide ctermfg=245

hi ip_with_port ctermfg=47
hi def log_date guifg=#bbbbbb
hi def component ctermfg=245
hi def component2 ctermfg=245
hi def component3 ctermfg=245
hi def component4 ctermfg=245