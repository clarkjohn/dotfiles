" slf4j.vim
" Vim syntax file
if exists("b:current_syntax")
 finish
endif

syn case ignore

" log level - keywords
syn keyword log_info INFO
syn keyword log_debug DEBUG
syn keyword log_trace TRACE

"syn keyword word_fatal fatal
"syn keyword word_error error
"syn keyword word_exception exception
"syn keyword word_warning warning
"syn keyword word_warn warn

" log levels - entire line
syn match log_error '.*\(FATAL\|ERROR\).*' oneline contains=ip_with_port, email, url
syn match log_warning '.*\(WARN\).*' oneline contains=ip_with_port, email, url

" email
syn match email '\v[_=a-z\./+0-9-]+\@[a-z0-9._-]+\a{2}'

" url https://gist.github.com/tobym/584909
syn match url /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/

" ip address with optional port number
syn match ip_with_port '\([0-9]\{1,3}\.[0-9]\{1,3}\.[0-9]\{1,3}\.[0-9]\{1,3}\)\(:[0-9]\{1,5}\)\?'

" stacktrace
"syn match log_stacktrace_divide "^java.*Exception.*" oneline contains=ip_with_port, email, url
"syn match log_stacktrace_divide "^java.*Error.*" oneline contains=ip_with_port, email, url
"syn match log_stacktrace_divide "^Caused [Bb]y: .*" oneline contains=ip_with_port, email, url
"syn match log_stacktrace "^\tat .*" oneline contains=ip_with_port, email, url

syn match log_stacktrace_divide "^java.*Exception.*"
syn match log_stacktrace_divide "^java.*Error.*"
syn match log_stacktrace_divide "^Caused [Bb]y: .*"
syn match log_stacktrace "^\tat .*"

" A component is something between two characters
"syn region component_bracket start=/\[/ end=/\]/ skip=/\\./ oneline contains=ip_with_port, email, word_fatal, word_error, word_exception, word_warning, word_warn, url
"syn region component_brace start=/{/ end=/}/ skip=/\\./ oneline contains=ip_with_port, email, word_fatal, word_error, word_exception, word_warning, word_warn, url
"syn region component_double_quote start=/"/ end=/"/ skip=/\\./ oneline contains=ip_with_port, email, word_fatal, word_error, word_exception, word_warning, word_warn, url
"syn region component_single_quote start=/'/ end=/'/ skip=/\\./ oneline contains=ip_with_port, email, word_fatal, word_error, word_exception, word_warning, word_warn, url

" jdbc sql statements
syn match sql_select_statement 'Preparing: [Ss][Ee][Ll].*'
syn match sql_crud_statement 'Preparing: \([Ii][Nn][Ss][Ee][Rr][Tt]\|[Uu][Pp][Dd][Aa][Tt][Ee]\|[Dd][Ee][Ll][Ee][Tt][Ee]\).*'

" WIP Parameters
" syntax match simpleVar "Parameters:" nextgroup=simpleValue
" syntax match simpleValue ".*" contained
" hi simpleValue ctermfg=187

" WIP Key value 
"syn match slf4jAssignment "[.-_a-zA-Z0-9]*=" 
"hi slf4jAssignment ctermfg=245

" colors
hi Normal ctermfg=251

" core
hi url ctermfg=49
hi ip_with_port ctermfg=47
hi email ctermfg=13

" log levels
hi log_error ctermfg=160
hi log_warning ctermfg=220
hi log_info ctermfg=15
hi log_debug ctermfg=251
hi log_trace ctermfg=245

hi word_fatal ctermfg=160
hi word_warning ctermfg=220

" jdbc sql statements
hi sql_crud_statement ctermfg=69
hi sql_select_statement ctermfg=123

" stacktrace
hi log_stacktrace ctermfg=240
hi log_stacktrace_divide ctermfg=245

" components
hi def component_bracket ctermfg=245
hi def component_brace ctermfg=245
hi def component_double_quote ctermfg=245
hi def component_single_quote ctermfg=245