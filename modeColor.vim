let s:colorInstructions = {
      \   '_mode_': {
      \     'n': 'normal', 'i': 'insert', 'R': 'replace', 'v': 'visual', 'V': 'visual', "\<C-v>": 'visual',
      \     'c': 'command', 's': 'select', 'S': 'select', "\<C-s>": 'select', 't': 'terminal'
      \   },
      \   'mode_fallback': { 'replace': 'insert', 'terminal': 'insert', 'select': 'visual' },
      \   'palette': {
      \       'normal': {
      \           'line_nr': [['white', 'brightred','bold'], ['brightred', 'white']],
      \           'tabline': [['darkred', 'brightoranget']]
      \       },
      \       'insert': {
      \           'line_nr': [['white', 'brightred','bold'], ['brightred', 'white']],
      \           'tabline': [['darkred', 'brightoranget']]
      \       },
      \       'visual': {
      \           'line_nr': [['white', 'brightred','bold'], ['brightred', 'white']],
      \           'tabline': [['darkred', 'brightoranget']]
      \       }
      \   }
  	  \}

function! InitColorInstr()
    let s:colorInstructions.palette =
                \   lightline#colorscheme#fill(get(s:colorInstructions, 'palette', ''))
endfunction

let s:ancientRawMode = ''
let s:ancientColorMode = ''
function! ModeColor()
    echom "abc"
    let l:currentRawMode = mode()
    if l:currentRawMode !=# s:ancientRawMode
        let s:ancientRawMode = l:currentRawMode
        let l:currentColorMode = s:getColorMode(l:currentRawMode)
        if l:currentColorMode !=# s:ancientColorMode
            let s:ancientColorMode = l:currentColorMode
            call s:changeColor(l:currentColorMode)
        endif
    endif
endfunction


function! s:getColorMode(rawMode)
    let l:modeName = get(s:colorInstructions._mode_, a:rawMode, 'normal')
    if has_key(s:colorInstructions.palette, l:modeName)
        return l:modeName
    else
        return get(s:colorInstructions.mode_fallback, l:modeName, 'normal')
    endif
endfunction


function! s:changeColor(mode)
    let l:currentPalette = get(s:colorInstructions.palette, a:mode, 'normal')
	exec printf('hi LineNr guifg=%s guibg=%s ctermfg=%s ctermbg=%s cterm=%s gui=%s',
                \   l:currentPalette.line_nr[0][0],
                \   l:currentPalette.line_nr[0][1],
                \   l:currentPalette.line_nr[0][2],
                \   l:currentPalette.line_nr[0][3],
                \   len(l:currentPalette.line_nr[0]) > 3 ? l:currentPalette.line_nr[0][4] : 'NONE',
                \   len(l:currentPalette.line_nr[0]) > 3 ? l:currentPalette.line_nr[0][4] : 'NONE')
endfunction


call InitColorInstr()
