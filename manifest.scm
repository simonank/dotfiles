(use-modules
  ((guix licenses) #:prefix license:)
  (guix build-system gnu)
  (guix build-system haskell)
  (guix download)
  (guix packages)
  (tau packages fonts)
  (tau packages emacs)
  (tau packages kitty)
  (srfi srfi-1)
  (tau packages ocaml))

(use-package-modules
  admin agda algebra aspell assembly audio base base bittorrent chez cmake commencement
  compression compton curl elixir emacs erlang fonts fontutils games gimp gnupg gnuzilla
  gprolog graphviz gtk guile guile guile-wm haskell haskell-check haskell-web idris image-viewers imagemagick
  inkscape irc java kde libreoffice linux man maths messaging mono mpd multiprecision
  ncurses node ocaml package-management pdf perl pkg-config pv python ruby scheme screen
  sdl suckless syndication terminals tex tls version-control video vim virtualization web web-browsers
  gnunet gl game-development libedit rsync readline webkit gstreamer graphics
  wm xdisorg xorg)

(define-public st-custom
  (package
    (inherit st)
    (version "0.8.1")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://dl.suckless.org/st/st-"
                           version ".tar.gz"))
       (patches (list
                  (origin
                    (method url-fetch)
                    (uri "https://st.suckless.org/patches/hidecursor/st-hidecursor-0.8.diff")
                    (sha256
                      (base32
                        "1hfzlcwfrk9x50lzsfij1vnqx7bdbm5xpj3bcd4pan1lk4ysyc5k")))
                  (origin
                    (method url-fetch)
                    (uri "https://st.suckless.org/patches/solarized/st-no_bold_colors-0.8.1.diff")
                    (sha256
                      (base32
                        "0fqy06r8p1sf6r1mig2iskk58w5cwca45s741s724ikpbis2nvjs")))))
                  ; (origin
                  ;   (method url-fetch)
                  ;  (uri "https://st.suckless.org/patches/solarized/st-solarized-both-0.8.1.diff")
                  ;  (sha256
                  ;    (base32
                  ;      "1gq3i92hy84ckbxiwa1kyprxhvivf7rdlh8xw4qsx06g27j7x3k9")))))
       (sha256
        (base32
         "09k94v3n20gg32xy7y68p96x9dq5msl80gknf9gbvlyjp3i0zyy4"))))
    (arguments
     '(#:tests? #f ; no tests
       #:make-flags (list "CC=gcc"
                          (string-append "PREFIX=" %output))
       #:phases
       (modify-phases %standard-phases
         (delete 'configure)
         (add-after 'unpack 'inhibit-terminfo-install
                    (lambda _
                      (substitute* "Makefile"
                        (("\ttic -sx st.info") ""))
                      #t))
         (add-after 'unpack 'patch-configuration
                    (lambda _
                      (substitute* "config.def.h"
                        (("Liberation Mono:pixelsize=12") "Hack:pixelsize=9"))
                      (substitute* "config.def.h"
                        (("static int borderpx = 2") "static int borderpx = 0"))
                      (substitute* "config.def.h"
                        (("\"#555555\"") "\"#555555\",\"#0c1014\""))
                      (substitute* "config.def.h"
                        (("unsigned int defaultbg = 0") "unsigned int defaultbg = 258"))
                      #t)))))))

(packages->manifest
  (map
    (lambda (x) x)
    ; (package-input-rewriting
    ;  `((,openssl . ,libressl))))
    (list
  ;;; Books
    sicp
  ;;; GAMES
    gnugo
    chess
    gnushogi
    0ad
  ;;; COMPILERS & INTERPRETERS
    ; agda
    ; chicken
    ; clojure
    ; coq
    ; idris
    ; mono
    ; octave
    ; yasm
    bc
    chez-scheme
    elixir
    erlang
    gcc-toolchain
    gnuplot
    gprolog
    graphviz
    jq
    node
    ghc-8
    ocaml
    ocaml-utop
    racket
    ; stalin
    texlive texlive-generic-pdftex
  ;;; DEVELOPMENT
    gnu-make
    ; nix
    ; darcs
    git
    pkg-config
    guix
    man-pages
  ;;; LIBS
    ;ocaml-lablgl
    ocaml-batteries
    ocaml-core
    ocaml-async
    ocaml-base64
    ocaml-lwt
    ocaml-ssl
    ocaml-ocurl
    ;ocaml-delimcc
    ; artanis
    ; artanis
    ; chez-irregex
    ; chez-matchable
    ; chez-scmutils
    ; chez-sockets
    ; chez-srfi
    ; guile-commonmark
    ; guile-gnome
    ; guile-reader
    ; guile-sly
    ;chickadee
    ; libedit
    csound
    gmp
    guile-8sync
    guile-aspell
    guile-cairo
    ; guile-chickadee
    guile-curl
    guile-dsv
    guile-fibers
    guile-git
    guile-gnome
    guile-irregex
    guile-json
    guile-minikanren
    guile-ncurses
    guile-opengl
    guile-readline
    ; tdlib
    guile-sqlite3
    guile-wisp
    guile-wisp
    guile-xcb
  ;;; GRAPHICS
    krita
    imagemagick
    feh
    gimp
    blender
    inkscape
  ;;; NET
    ; icecat
    ; toxic
    aria2
    gnunet
    lynx
    curl
    darkhttpd
    newsboat
    nmap
    surf
    weechat
    rsync
    youtube-dl
  ;;; VIDEO & AUDIO
    ffmpeg
    mpd
    mpd-mpc
    mpv
    ncmpc
    sox
  ;;; EDITORS
    neovim
    emacs
    ;;; MODES
      geiser
      emacs-guix
      flycheck
      emacs-pdf-tools
      emacs-racket-mode
      emacs-sx
      emacs-git-gutter
      emacs-tuareg
      emacs-scheme-complete
      emacs-slime
      paredit
      emacs-rainbow-delimiters
      emacs-rainbow-blocks
      emacs-rainbow-mode
      emacs-evil-quickscope
      emacs-evil
      emacs-evil-collection
      emacs-evil-org
      emacs-evil-magit
      emacs-neotree
      emacs-gnuplot
      emacs-org-edit-latex
      emacs-idris-mode
      ; emacs-no-easy-keys
      emacs-gotham-theme
      ; emacs-telega
      git-modes
      ; haskell-mode
      emms
      emacs-graphviz-dot-mode
  ;;; X11
    libreoffice
    ; qemu
    ; xbacklight
    xev
    bspwm
    setxkbmap
    xlsfonts
    dzen
    compton
    dmenu
    redshift
    scrot
    sent
    st-custom
    kitty
    sxhkd
    xclip
    xf86-input-wacom
    xkill
    xmodmap
    xrandr
    xsetroot
    zathura
    zathura-cb
    zathura-djvu
    zathura-pdf-mupdf
    zathura-ps
  ;;; FONTS
    font-dejavu
    font-fira-code
    font-fira-code-symbols
    font-google-noto
    font-hack
    font-inconsolata
    font-liberation
  ;;; UTILS
    ; cmake
    ; haunt
    inotify-tools
    acpi
    alsa-utils
    asciinema
    aspell
    powertop
    aspell-dict-en
    coreutils
    dtach
    rlwrap
    glibc-locales glibc-utf8-locales
    gnutls
    gnupg
    pinentry
    htop
    pv
    thefuck
    thinkfan
    tree
    unzip)))
