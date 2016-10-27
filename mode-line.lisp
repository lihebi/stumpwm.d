;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mode Line
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; default timeout
;; (setf *mode-line-timeout* 1)

;; smart modeline
(if (not (head-mode-line (current-head)))
    (toggle-mode-line (current-screen) (current-head)))

;; BG time
(defun pretty-time ()
  "Returns the date formatted as '17:19:51 Неделя, 27 Април 2014'."
  (defun stringify-dow (dow)
    (nth dow '("Monday" "Tuesday" "Wednesday" "Thurday" "Friday" "Saturday" "Sunday")))
  (defun stringify-mon (mon)
    (nth (- mon 1) '("Jan" "Feb" "March" "April"
                     "May" "Jun" "Jul" "Aug"
                     "Sep" "Oct" "Nov" "Dec")))
  (multiple-value-bind (sec min hr date mon yr dow dst-p tz)
      (get-decoded-time)
    (format NIL
            ;; "~2,'0d:~2,'0d:~2,'0d ~a, ~d ~a ~d (GMT ~@d)"
            "~2,'0d:~2,'0d:~2,'0d ~a, ~d ~a ~d"
            hr min sec
            (stringify-dow dow)
            date (stringify-mon mon)
            yr (- tz))))


;; Modeline format
(setf *screen-mode-line-format*
      (list "[^B%n^b] %W " ; groups/windows
            "^>" ; right align
            " ^7* " '(:eval (pretty-time)); date
            " %c %t" ; cpu
            ;; " %b" ; battery
            " %B" ; battery-portable
            ;; " %I" ; wifi
            ))
