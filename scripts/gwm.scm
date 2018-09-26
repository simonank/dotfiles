(define-module (xcb xml gwm)
  #:use-module (system repl server)
  #:use-module (xcb xml xproto)
  #:use-module (xcb event-loop)
  #:use-module (xcb xml))

(define xcb-conn (xcb-connect!))

(event-loop-prepare!
  xcb-conn
  (lambda (cc err)
    (format (current-error-port) "E: ~a\n" err)
    (cc)))

(loop-with-connection xcb-conn
  (define setup  (xcb-connection-setup xcb-conn))
  (define screen (xref setup 'roots 0))
  (define root   (xref screen 'root))
  (define action (make-parameter 'none))
  (define win    (make-parameter #f))

  (define (on-motion-notify motion-notify)
    (with-replies ((pointer query-pointer root)
                   (geom get-geometry (win)))
      (define (new-coord p g s) (if (> (+ p g) s) (- s g) p))
      (if (eq? (action) 'move)
          (configure-window
            (win)
            #:x (new-coord (xref pointer 'root-x)
                           (xref geom 'width)
                           (xref screen 'width-in-pixels))
            #:y (new-coord (xref pointer 'root-y)
                           (xref geom 'height)
                           (xref screen 'height-in-pixels)))
          (configure-window
            (win)
            #:width (- (xref pointer 'root-x) (xref geom 's))
            #:height (- (xref pointer 'root-y) (xref geom 'y))))))

  (define (on-button-release
