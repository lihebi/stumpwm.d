;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mode Line
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; default timeout
;; (setf *mode-line-timeout* 1)

;; smart modeline
;; (if (not (head-mode-line (current-head)))
;;     (toggle-mode-line (current-screen) (current-head)))

(defun start-mode-line (head)
  (enable-mode-line (current-screen) head t))
;; start mode line for all heads on the current screen
(map nil 'start-mode-line (screen-heads (current-screen)))

;; toggle mode line for all heads
;; (defcommand toggle-all-mode-line () ()
;;             (map nil (lambda (head) (toggle-mode-line (current-screen) head))
;;                  (screen-heads (current-screen))))

;; (map nil '1+ '(2 3))
;; ((lambda (head) (enable-mode-line (current-screen) head t)) (first (screen-heads (current-screen))))

;; (toggle-mode-line)
;; (screen-heads (group-screen (current-group)))
;; (screen-heads (current-screen))

;; BG time
(defun pretty-time ()
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




;; (add-screen-mode-line-formatter #\g 'fmt-graphic-temp)
(defun graphic-temp()
  (if (string/= (nvidia-temp) "")
      (concatenate 'string "NVIDIA: "
                   (string-trim '(#\Newline #\Space) (nvidia-temp)))
      ;; AMD
      (string-trim '(#\Space #\Newline #\Backspace #\Tab #\Linefeed #\Page #\Return #\Rubout)
                   (run-shell-command
                    "sensors | awk '/PCI/ {ok=1}; /temp/ && ok==1 {print $2; exit;}'" t))
      ;; "no"
      ))

(defcommand hebi-graphic-temp()()
            (graphic-temp))


;; enable to use this, you need also set the user to have permision to
;; use sudo for this command without password. To do that, edit
;; sudoers file and use
;; %wheel ALL=(ALL) ALL
;; %wheel ALL=(ALL) NOPASSWD: /usr/bin/iwconfig
;; both of them should present
;; I don't need this field, it is buggy
;; (setq wifi:*iwconfig-path* "sudo /sbin/iwconfig")

;; (load "~/.stumpwm.d/patch-wifi.lisp")

(defun nvidia-temp()
  (run-shell-command "nvidia-settings -q gpucoretemp | grep Attribute | awk '{print $4}'" t))

;; (defun fmt-graphic-temp (ml)
;;   "Returns a string representing the current CPU frequency (especially useful for laptop users.)"
;;   (declare (ignore ml))
;;   (graphic-temp))


;; %S: status: playing, paused, stopped
;; %s: shuffle
;; %r: repeat
;; %F: crossfade?
;; %a: artist
;; %t: title
;; %n: number
;; %p: total playlist length

(setq mpd:*mpd-modeline-fmt* "%S [%s;%r;%F]: %a - %t (%n/%p)")

;; commands
;; mpd-toggle-pause (SPC)
;; mpd-toggle-repeat (r)
;; mpd-toggle-random (s)
;; mpd-toggle-xfade (f)
;; mpd-stop (o)
;; mpd-play (p)
;; mpd-next (m)
;; mpd-prev (l)
(define-key *root-map* (kbd "m") nil)
(define-key *root-map* (kbd "m") mpd:*mpd-map*)

;; Modeline format
(setf *screen-mode-line-format*
      (list "[^B%n^b] %W "              ; groups/windows
            "^>"                        ; right align
            "%m"
            " ^2* " '(:eval (pretty-time)) ; date
            ;; " ^6%c %f %t" ; cpu
            " ^6%c"                     ; cpu
            " %M"
            ;; " ^6%i"                     ; wifi
            '(:eval (string-trim '(#\Space #\Newline)
                     (stumpwm:run-shell-command
                      "iw dev | awk '/ssid/ {print $2}'" t)))
            " ^2*%B"                    ; battery-portable
            ))

