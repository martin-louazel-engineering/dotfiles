syn match gitLgLine			/^[_\*|\/\\ ]\+\(\<\x\{4,40\}\>.*\)\?$/
syn match gitLgHead			/^[_\*|\/\\ ]\+\(\<\x\{4,40\}\>\( ([^)]\+)\)\? \)\?/ contained containedin=gitLgLine
syn match gitLgHeadPtr		/HEAD ->/ contained containedin=gitLgRefs
syn match gitLgTag			/tag: [^,)]*/ contained containedin=gitLgRefs
syn match gitLgRemote		/[^,()]*\/[^,)]*/ contained containedin=gitLgRefs
syn match gitLgRefs			/([^)]*)/ contained containedin=gitLgHead
syn match gitLgGraph		/^[_\*|\/\\ ]\+/ contained containedin=gitLgHead,gitLgCommit nextgroup=gitHashAbbrev skipwhite
hi def link gitLgGraph		Comment
hi def link gitLgRefs		gitReference
hi def link gitLgHeadPtr	Type
hi def link gitLgRemote		Keyword
hi def link gitLgTag		String
