(define (print t x)
  (let ((h (date-hour x))
        (m (date-minute x)))
      (format
        (if (and (> h 9) (< h 23))
          "#[fg=colour235]~A #[fg=colour238]~D:~D#[fg=colour235]"
          "~A ~D:~D")
        t h m)))

(let ((swe (current-date))
      (eng (current-date  3600))
      (php (current-date 28800))
      (bat (* 100 (/ (with-input-from-file "/sys/class/power_supply/BAT0/energy_now" read)
                     (with-input-from-file "/sys/class/power_supply/BAT0/energy_full" read)))))
  (display
    (string-append
      (print "eng" eng)
      " "
      (print "swe" swe)
      " "
      (print "php" php)
      " "
      (format "battery ~D% " (round (inexact bat))))))
