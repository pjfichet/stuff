"Draw maps

syn match   mapWall			'#'
syn match   mapForest		'f'
syn match   mapPlain		'p'
syn match   mapCascade		'"'
syn match   mapWater		'w'
syn match	mapMountain		'm'
syn match	mapCultivated	'c'
syn match	mapBuilding 	/[MCEF]/
syn match	mapSwamp		's'
syn match	mapUnderground	'u'
syn match	mapRiver		'r'
syn match	mapRoad			'\.'


hi mapWall			ctermfg=grey
hi mapForest		ctermfg=darkgreen
hi mapPlain			ctermfg=darkyellow
hi mapCascade		ctermfg=cyan
hi mapWater			ctermfg=blue
hi mapMountain		ctermfg=white
hi mapCultivated	ctermfg=yellow
hi mapBuilding		ctermfg=magenta
hi mapSwamp			ctermfg=green
hi mapUnderground	ctermfg=cyan
hi mapRiver			ctermfg=cyan
hi mapRoad			ctermfg=yellow



let b:current_syntax = 'map'

