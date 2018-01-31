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
    echom s:colorInstructions.palette.normal.line_nr[0][0]
    echom s:colorInstructions.palette.normal.line_nr[0][1]
    echom s:colorInstructions.palette.normal.line_nr[0][2]
    echom s:colorInstructions.palette.normal.line_nr[0][3]
    echom s:colorInstructions.palette.normal.line_nr[0][4]
endfunction

let s:ancientRawMode = ''
let s:ancientColorMode = ''
function! UpdateColor()
    let l:currentRawMode = mode()
    if l:currentRawMode !=# s:ancientRawMode
        let s:ancientRawMode = l:currentRawMode
        let l:currentColorMode = s:getColorMode(l:currentRawMode)
        if l:currentColorMode !=# s:ancientColorMode
            let s:ancientColorMode = l:currentColorMode
            " TODO complete
        fi
    fi
endfunction


function! s:getColorMode(rawMode)
    l:modeName = get(s:colorInstructions._mode_, rawMode, 'normal')
    if has_key(s:colorInstructions.palette, l:modeName)
        return l:modeName
    else
        return get(s:colorInstructions.mode_fallback, l:modeName, 'normal')
    fi
endfunction



function! s:changeColor(mode)
	exec printf('hi LineNr %s', get(s:colorInstructions,a:mode))
endfunction


call InitColorInstr()
