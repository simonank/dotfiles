eval $(thefuck --alias)

source $HOME/.nix-profile/etc/profile.d/nix.sh

export DISPLAY=:0
export EDITOR=nvim
export DARCS_SSH="ssh -c aes256-cbc"
export GOPATH=~/.go
export GUIX_LOCPATH=$HOME/.guix-profile/lib/locale
export GUIX_PACKAGE_PATH=$HOME/pkg
export MPD_HOST=~/.mpd/socket
export TERM=xterm-256color
export XDG_CONFIG_HOME="$HOME/.config"
export _JAVA_AWT_WM_NONREPARENTING=1
export http_proxy=
export LYNX_LSS=$HOME/.lynx/lynx.lss

source "$HOME/.guix-profile/etc/profile"
export PATH="$HOME/scripts/bin:$HOME/.config/guix/current/bin:$HOME/.guix-profile/bin:$HOME/.guix-profile/sbin${PATH:+:}$PATH"

CC=gcc
CXX=g++

# [ $VIM ] || dtach -A ~/.config/nvim/session -r winch nvim -c ':te'
[ $SSH_CLIENT ] || [ $VIM ] || nvim -c ':te'
# [ $(pgrep mpd) ] || mpd
[ $ASCIINEMA_REC ] && export PS1=" rec:\${PWD##$(dirname $PWD)/} λ " \
	|| [ $GUIX_ENVIRONMENT ] && export PS1=" \${PWD##$(dirname $HOME)/} E " \
	|| export PS1=" \${PWD##$(dirname $HOME)/} λ "

#set -o vi

alias current='export PS1="\${PWD##$(dirname $PWD)/} λ "'
alias ge='guix edit'
alias gp='guix package'
alias gs='guix package -s'
alias gS='guix system'
alias gE='guix environment'
alias gP='guix pack'
alias v="dtach -A ~/.config/nvim/session -r winch nvim -c ':te'"
alias apl='apl --noColor -q'
alias iwl='sudo modprobe -r iwldvm;sudo modprobe -r iwlwifi;sudo modprobe iwlwifi'
alias bsdmount='sudo mount -t ufs -o ro,ufstype=44bsd '
alias l='ls -F'
alias manifest='guix package -m ~/dev/dotfiles/manifest.scm --no-build-hook'
alias ptc='xclip -sel primary -o | xclip -sel clip'
alias s=search
alias scap='scrot /tmp/screen.png;share /tmp/screen.png'
alias song='mpc cu >> ~/.songs'
alias torrent='aria2c -i ~/.torrents -d ~/torrent'
alias vcap='ffmpeg -video_size $(xrandr | grep primary | egrep -o "[0-9]+x[0-9]+") -framerate 10 -f x11grab -i :0.0+0,0 /tmp/screen.mp4;'
alias vim=nvim
alias wtc='curl whatthecommit.com/index.txt'
alias re='sudo -E guix system reconfigure -e "(@@ (tau packages os) laptop)"'
alias weather='curl wttr.in/goteborg'
alias rotate='xrandr --output LVDS-1 --auto --rotate'
alias ytdl="\
	youtube-dl --geo-bypass --external-downloader=aria2c --add-metadata \
		--external-downloader-args '-j 8 -c -x 8 -m 10 -k 5M -s 8 --log-level error --summary-interval 0' \
		-io '%(title)s.%(ext)s' -c"

function mkcd() {
	mkdir -p $1; cd $1 # yes I'm lazy
}

function shell() {
	nix-shell ~/env/$1.nix
}

function idr() {
	touch $1; idris -p contrib $1
}

function share() {
	curl -LF "file=@$1" https://0x0.st
}

function shorten() {
	curl -LF "shorten=$1" https://0x0.st
}

function url() {
	curl -LF "url=$1" https://0x0.st
}

function search() {
	lynx "https://searx.xyz/search?q=$(echo $@ | sed -e 's,  , ,g' -e 's, ,+,g')"
}

function towav() {
	sox -r 8000 --bits 8 --encoding unsigned-integer -t raw $1 $2
}

function asciinema-max-wait() {
	jq ".stdout |= map(.[0] |= ([., $1] | min))" $2 > $3
}

function asciinema-speedup() {
	jq ".stdout |= map(.[0] *= $1)" $2 > $3
}

# I'm too lazy to fix this
function rec() {
	FILENAME="rec-$(date +%F-%M-%S).json"
  current
	asciinema rec $FILENAME
	asciinema-max-wait 1.234 $FILENAME "imm-$FILENAME"
	asciinema-speedup 0.35 "imm-$FILENAME" $FILENAME
	rm "imm-$FILENAME"
}
