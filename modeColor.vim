let s:colorInstructions = {
	\ 'n' : 'ctermfg=1',
	\ 'v' : 'ctermfg=2',
	\ 'i' : 'ctermfg=3'
	\}
function! ChangeColor(mode)
	exec printf('hi LineNr %s', get(s:colorInstructions,a:mode))
endfunction

" au CursorMoved * :call ChangeColor(mode())
