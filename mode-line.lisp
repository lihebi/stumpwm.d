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




(add-screen-mode-line-formatter #\g 'fmt-graphic-temp)
(defun graphic-temp()
  (string-trim '(#\Space #\Newline #\Backspace #\Tab #\Linefeed #\Page #\Return #\Rubout)
               (run-shell-command "sensors | awk '/PCI/ {ok=1}; /temp/ && ok==1 {print $2; exit;}'" t)))
(defcommand get-graphic-temp()()
            (graphic-temp))

(defun fmt-graphic-temp (ml)
  "Returns a string representing the current CPU frequency (especially useful for laptop users.)"
  (declare (ignore ml))
  (graphic-temp))
  ;; (let ((mhz (parse-integer (get-proc-file-field "/proc/cpuinfo" "cpu MHz")
  ;;                           :junk-allowed t)))
  ;;   (if (>= mhz 1000)
  ;;       (format nil "~,2FGHz" (/ mhz 1000))
  ;;       (format nil "~DMHz" mhz))))


;; Modeline format
(setf *screen-mode-line-format*
      (list "[^B%n^b] %W " ; groups/windows
            "^>" ; right align
            " ^2* " '(:eval (pretty-time)); date
            " ^6%c %f %t" ; cpu
            " ^3GPU: %g"
            " ^6%M"
            ;; " %b" ; battery
            ;; " %B" ; battery-portable
            ;; " %I" ; wifi
            ))
