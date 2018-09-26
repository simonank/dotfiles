; string-period : string -> maybe int
(define (string-period s)
  (let ((len (string-length s)))
    (let loop ((i (- len 1)))
      (cond ((char=? (string-ref s i) #\.) i)
            ((= i 0) #f)
            (else (loop (- i 1)))))))

; string-split-period : string -> maybe (string, string)
(define (string-split-period s)
  (let ((i (string-period s)))
    (if i
      (cons (substring s 0 i)
            (substring s i (string-length s)))
      #f)))

(define (identity x) x)

; music-directories : IO (list string)
(define (music-directories)
  (define (lst? x) (if x (string=? (cdr x) ".lst") #t))
  (let ((dirs (filter lst? (map string-split-period (directory-list ".")))))
    (filter identity dirs)))

(define (youtube-dl lst)
  (system
    (string-append "youtube-dl"
                   " -xio '%(title)s.%(ext)s'"
                   " --geo-bypass"
                   " --external-downloader=aria2c"
                   " --add-metadata"
                   " --external-downloader-args='-j 8 -c -x 8 -m 10 -k 5M -s 8'"
                   " -a " lst)))

; update : (string, string) -> IO (maybe bool)
(define (update directory)
  (let ((dir (car directory))
        (ext (cdr directory)))
    (cond ((not (file-exists? dir))
           (mkdir dir)
           (update directory))
          ((time>? (file-change-time (string-append dir ext))
                   (file-change-time dir))
           (let ((cur (current-directory)))
             (cd dir)
             (youtube-dl (string-append "../" dir ext))
             (cd cur)))
          (else #f))))

(for-each update (music-directories))
