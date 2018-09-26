function! Tab_Or_Complete()
	if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
		return "\<C-x>\<C-o>"
	else
		return "\<Tab>"
	endif
endfunction

function! TextEdit(type)
	if (a:type == 0)
		let text = 0 < a:0 ? a:1 : inputdialog("text: ")
		return repeat(' ',50 - (strlen(text) / 2)) . text
	elseif (a:type == 1)
		return '  ' . repeat('-',98)
	elseif (a:type == 2)
		:mc100A<esc>01001DgelD`cP
	endif
endfunction


function! HaskellDivider(type)
	let name = 0 < a:0 ? a:1 : inputdialog("name: ")
	if ((&filetype == "haskell") || (&filetype == "idris"))
		return "-- " . name . " " . repeat('-', 80 - (strlen(name) - 2)) . "\n"
	endif
endfunction

function! IdrisDivider(type)
  let name = 0 < a:0 ? a:1 : inputdialog("name: ")
  if (1 == a:type)
    return "-- "
          \ . name
          \ . " "
          \ . repeat('-', 76 - strlen(name))
          \ . "\n"
  elseif (2 == a:type)
    return "{- "
          \ . repeat(' ', 37 - strlen(name)/2)
          \ . name
          \ . repeat(' ', 37 - strlen(name)/2 + (strlen(name)%2 == 0 ? 1 : 0))
          \ . "-}\n"
  endif
endfunction

function! DeadKeys()
	echo "Dead Keys: on"
	let g:DeadKeysOn=1
	imap "o ö
	imap "O Ö
	imap "a ä
	imap "A Ä
	imap 'a å
	imap 'A Å
endfunction

function! DeadKeysOff()
	if !exists("g:DeadKeysOn") || !g:DeadKeysOn
		echo "Dead Keys not on."
		return
	endif
	echo "Dead Keys: off"
	let g:DeadKeysOn=0
	iunmap "o
	iunmap "O
	iunmap "a
	iunmap "A
	iunmap 'a
	iunmap 'A
endfunction

function! Pointfree()
	call setline('.', split(system('pointfree '.shellescape(join(getline(a:firstline, a:lastline), "\n"))), "\n"))
endfunction

function! Pointful()
	call setline('.', split(system('pointful '.shellescape(join(getline(a:firstline, a:lastline), "\n"))), "\n"))
endfunction

function! BirdStyle()
	if (&filetype == "idris")
		:%s,^\(\(\-\-\)\@!.\),> \1,
		:%s,^\-\- ,,
		setf lidris
	endif
endfunction

function! UnBirdStyle()
	if (&filetype == "lidris")
		:%s,^\(\(>\)\@!.\),-- \1,
		:%s,^> ,,
		setf idris
	endif
endfunction

"let g:centerscreen_active = 0

function! ToggleCenterScreen(width)
"  if g:centerscreen_active == 0
    let l:wwidth = winwidth(winnr())
    let l:sidewidth = (l:wwidth - a:width) / 2
    exec("silent leftabove " . l:sidewidth . "vsplit new")
    wincmd l
    exec("silent rightbelow " . l:sidewidth . "vsplit new")
    wincmd h
"    let g:centerscreen_active = 1
"  else
"    wincmd h
"    close
"    wincmd l
"    close
"    let g:centerscreen_active = 0
"  endif
endfunction

function! TabularMap()
	if (&filetype == "haskell" || &filetype == "idris")
		vm a= :Tabularize /=<CR>
		vm a< :Tabularize /<-<CR>
		vm ai :Tabularize /\C[A-Z].*/<CR>
		vm ac :s,^\(.\),-- \1,<CR>
    vm a\| :Tabularize /\|
		vm ax :s,^-- ,,<CR>
		if (&filetype == "haskell")
			vm a; :Tabularize /::<CR>
			vm a> :Tabularize /-><CR>
			vm a- :Tabularize /-<<CR>
		else
			vm a; :Tabularize /:<CR>
			vm a> :Tabularize /=><CR>
		endif
	elseif (&filetype == "dats")
		vm a> :Tabularize /=><CR>
		vm a= :Tabularize /=<CR>
		vm a; :Tabularize /of<CR>
	elseif (&filetype == "coq")
		vm a= :Tabularize /=<CR>
		vm a; :Tabularize /:<CR>
		vm a> :Tabularize /=><CR>
	endif
endfunction
