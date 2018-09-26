nm <F2> :TagbarToggle<CR>
nm <F3> :NERDTreeToggle<CR>
nm <F4> :RainbowToggle<CR>
nm <F5> :call DeadKeys()<CR>
nm <F6> :call DeadKeysOff()<CR>
nm <F7> :Limelight<CR>
nm <F8> :Limelight!<CR>
nm <F10> :AsyncRun make<CR>
" DIVIDER
nm <silent> __p "=IdrisDivider(1)<CR>gp
nm <silent> __P "=IdrisDivider(2)<CR>gp
" TEXT DOCUMENTS
nm <silent> __t "=TextEdit(0)<CR>gp"
nm <silent> __d "=TextEdit(1)<CR>gp"
" RESIZE
nm <S-h> <C-w><
nm <S-j> <C-w>-
nm <S-k> <C-w>+
nm <S-l> <C-w>>
" PANE MOVEMENT
nm <Up> <C-w>k
nm <Left> <C-w>h
nm <Right> <C-w>l
nm <Down> <C-w>j
nm <Leader>= :exec ToggleCenterScreen(87)<CR>
" TAB MOVEMENT
nm <C-Left> :tabprevious<CR>
nm <C-Right> :tabnext<CR>

tno <Esc> <C-\><C-n>
tno <C-b><Esc> <Esc>

nm <C-t> :te<CR>
nm <C-n> :tabnew<CR>

vn <silent> <leader>h> :call Pointful()<CR>
vn <silent> <leader>h. :call Pointfree()<CR>

ino <Tab> <C-R>=Tab_Or_Complete()<CR>
ino <Up> <NOP>
ino <Down> <NOP>
ino <Right> <NOP>
ino <Left> <NOP>

nno <expr> v:count ? :echo "use jumps"<CR> : 'gj'
nno <expr> v:count ? :echo "use jumps"<CR> : 'gj'
vno <expr> v:count ? :echo "use jumps"<CR> : 'gj'
vno <expr> v:count ? :echo "use jumps"<CR> : 'gj'
