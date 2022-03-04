syn match gitLgLine			/^[_\*|\/\\ ]\+\(\<\x\{4,40\}\>.*\)\?$/
syn match gitLgHead			/^[_\*|\/\\ ]\+\(\<\x\{4,40\}\>\( ([^)]\+)\)\? \)\?/ contained containedin=gitLgLine
syn match gitLgRefs			/([^)]*)/ contained containedin=gitLgHead
syn match gitLgGraph		/^[_\*|\/\\ ]\+/ contained containedin=gitLgHead,gitLgCommit nextgroup=gitHashAbbrev skipwhite
hi def link gitLgGraph		Comment
hi def link gitLgRefs		gitReference
