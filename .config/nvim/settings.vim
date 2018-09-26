set nocompatible
set list
set ai
set cursorline
set autochdir
set backspace=eol,start,indent
set backupdir=~/.config/nvim/tmp/backup/
set conceallevel=2
set directory=~/.config/nvim/tmp/swap
set hlsearch!
set ignorecase
set incsearch
set lazyredraw
set lbr
set listchars=tab:.\ ,eol:¬,extends:❯,precedes:❮,nbsp:▩
set magic
set mat=1
set mouse=a
set nohlsearch
set number
set scrolloff=5
set shiftwidth=2
set showmatch
set si
set smartcase
set smarttab
set t_Co=256
set tabstop=2
set tags=tags;
set textwidth=100
set noshowmode
set tw=500
set undodir=~/.config/nvim/tmp/undo/
set termguicolors
set relativenumber number
set undofile
set whichwrap+=<,>,h,l
set showtabline=2
set wrap
set laststatus=2
"set background=dark
"set colorcolumn=87
"set cursorline
"set colorcolumn=+1

function! TabLine()
	let line = ''
	for i in range(tabpagenr('$'))
		if i + 1 == tabpagenr()
			let line .= '%#TabLineSel#'
		else
			let line .= '%#TabLine#'
		endif
		let line .= ' %{TabLabel(' . (i + 1) . ')}  '
	endfor
	let line .= '%#TabLineFill#%T'
	let line .= '%=%#TabLineSel#'
	if !$ASCIINEMA_REC
		let line .= '%{system("mpc cu|tr -d \"\\n\"")} '
		let line .= ' swe %{system("date +\"%H:%M\"|tr -d \"\\n\"")} '
		let line .= ' php %{system("TZ=\"Asia/Manila\" date +\"%H:%M\"|tr -d \"\\n\"")} '
		let line .= ' %{system("date +\"%d/%m/%y\"|tr -d \"\\n\"")} '
    let line .=   '%{system("acpi -b | egrep -o \"[0-9]+%\" | tr -d \"\n\"")} '
	else
		let line .= ' REC '
	endif
	return line
endfunction

function! TabLabel(n)
	let number   = (tabpagebuflist(a:n))[tabpagewinnr(a:n) - 1]
	let name     = bufname(number)
	let modified = getbufvar(number, '&mod')
	let label = ''
	if modified
		let label = '+'
	endif
	let parts = split(fnamemodify(name, ':f'), '/')
	if len(parts) == 1
		let label .= parts[0]
	elseif len(parts) > 1
		let label .= join(parts[-2:-1], '/')
	else
		let label = 'no name'
	endif
	return label
endfunction


let g:currentmode={
	\ 'n'  : 'normal',
	\ 'no' : 'normal op',
	\ 'v'  : 'visual',
	\ 'V'  : 'visual line',
	\ '^V' : 'visual block',
	\ 's'  : 'select',
	\ 'S'  : 'select line',
	\ '^S' : 'select block',
	\ 'i'  : 'input',
	\ 'R'  : 'replace',
	\ 'Rv' : 'visual replace',
	\ 'c'  : 'command',
	\ 'cv' : 'vim ex',
	\ 'ce' : 'ex',
	\ 'r'  : 'prompt',
	\ 'rm' : 'more',
	\ 'r?' : 'confirm',
	\ '!'  : 'shell',
	\ 't'  : 'terminal'
	\}

set tabline=%!TabLine()
set statusline=\ %{toupper(g:currentmode[mode()])}
set statusline+=\ \ %t
set statusline+=%=%c\ %l:%L\ \ %M%R%Y\ 

function! Redraw(timer)
	redraw
endfunction

if !$ASCIINEMA_REC
	let timer = timer_start(20000, 'Redraw', {'repeat': -1})
endif
