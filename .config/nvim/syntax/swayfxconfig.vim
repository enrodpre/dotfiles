" Vim syntax file
" Language: swayfx config file
" Maintainer: enrodpre 
" Latest Revision: 13 Jan 2026
"
"
if exists("b:current_syntax")
  finish
endif

runtime! syntax/swayconfig.vim

" syn keyword swayfxConfigBlurVals enable disable 
syn keyword swayfxConfigBoolean enable disable contained 
syn match swayfxConfigFloatMaxOne /\(1\(.[0]*\)\?\)\|\(0\(.[0-9]*\)\?\)/ contained
syn match swayfxConfigFloatMaxTwo /\(2\(.[0]*\)\?\)\|\([0-1]\(.[0-9]*\)\?\)/ contained
syn match swayfxConfigIntMaxTen /\(10\|[1-9]\)/ contained
syn match swayfxConfigIntTwoDigits /\<[0-9]\{1,2}\>/ contained

syn keyword swayfxConfigBlurKeyword blur skipwhite nextgroup=swayfxConfigBoolean 
syn keyword swayfxConfigBlurXrayKeyword blur_xray skipwhite nextgroup=swayfxConfigBoolean
syn keyword swayfxConfigKeyword blur_passes skipwhite nextgroup=swayfxConfigIntMaxTen
syn keyword swayfxConfigKeyword blur_radius skipwhite nextgroup=swayfxConfigIntMaxTen
syn keyword swayfxConfigKeyword blur_noise skipwhite nextgroup=swayfxConfigFloatMaxOne
syn keyword swayfxConfigKeyword blur_brightness skipwhite nextgroup=swayfxConfigFloatMaxTwo
syn keyword swayfxConfigKeyword blur_contrast skipwhite nextgroup=swayfxConfigFloatMaxTwo
syn keyword swayfxConfigKeyword blur_saturation skipwhite nextgroup=swayfxConfigFloatMaxTwo
syn keyword swayfxConfigBlurIgnoreKeyword blur_ignore_transparent skipwhite nextgroup=swayfxConfigBoolean

syn keyword swayfxConfigCornerKeyword corner_radius skipwhite nextgroup=swayfxConfigIntTwoDigits
syn keyword swayfxConfigKeyword smart_corner_radius skipwhite nextgroup=swayfxConfigBoolean

syn keyword swayfxConfigShadowsKeyword shadows skipwhite nextgroup=swayfxConfigBoolean
syn keyword swayfxConfigKeyword shadows_on_csd skipwhite nextgroup=swayfxConfigBoolean
syn keyword swayfxConfigKeyword shadow_blur_radius skipwhite nextgroup=swayfxConfigIntTwoDigits
syn keyword swayfxConfigKeyword shadow_color skipwhite nextgroup=i3ConfigColor
syn keyword swayfxConfigKeyword shadow_inactive_color skipwhite nextgroup=i3ConfigColor

syn keyword swayfxConfigKeyword default_dim_inactive skipwhite nextgroup=swayfxConfigFloatMaxOne
syn keyword swayfxConfigKeyword dim_inactive contained skipwhite nextgroup=swayfxConfigFloatMaxOne
syn keyword swayfxConfigKeyword unfocused urgent contained skipwhite nextgroup=i3ConfigColor
syn match swayfxConfigDot /\./ contained nextgroup=swayfxConfigKeyword
syn keyword swayfxConfigKeyword dim_inactive_colors nextgroup=swayfxConfigDot

syn cluster swayfxConfigLayerEffects contains=i3ConfigComment,swayfxConfigBlurIgnoreKeyword,swayfxConfigBlurKeyword,swayfxConfigBlurXrayKeyword,swayfxConfigShadowsKeyword,swayfxConfigCornerKeyword
syn region swayfxConfigModeBlock matchgroup=i3ConfigParen start=/{$/ end=/^\s*}$/ contained contains=@swayfxConfigLayerEffects fold keepend
syn match swayfxConfigModeIdent /[^ ,;]\+/ contained contains=@i3ConfigStrVar extend skipwhite nextgroup=swayfxConfigModeBlock
syn keyword swayfxConfigKeyword layer_effects skipwhite nextgroup=swayfxConfigModeIdent

syn keyword swayfxConfigResetKeyword reset

hi def link swayfxConfigBoolean i3ConfigBoolean
hi def link swayfxConfigFloatMaxOne i3ConfigNumber
hi def link swayfxConfigFloatMaxTwo i3ConfigNumber
hi def link swayfxConfigIntMaxTen i3ConfigNumber
hi def link swayfxConfigIntTwoDigits i3ConfigNumber
hi def link swayfxConfigDot i3ConfigDotOperator
hi def link swayfxConfigKeyword i3ConfigKeyword
hi def link swayfxConfigShadowsKeyword swayfxConfigKeyword
hi def link swayfxConfigBlurKeyword swayfxConfigKeyword
hi def link swayfxConfigBlurXrayKeyword swayfxConfigKeyword
hi def link swayfxConfigBlurIgnoreKeyword swayfxConfigKeyword
hi def link swayfxConfigResetKeyword swayfxConfigKeyword
hi def link swayfxConfigCornerKeyword swayfxConfigKeyword


let b:current_syntax = "swayfxconfig"
