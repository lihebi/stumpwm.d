;; direction: left, right, normal
(defun turn-on (monitor)
  (run-shell-command
   (concatenate 'string "xrandr --output " monitor " --auto")))

(defun rotate-display (monitor direction)
  (run-shell-command
   (concatenate 'string "xrandr --output " monitor " --auto --rotate " direction)))

(defun left-of (l r)
  (run-shell-command
   (concatenate 'string "xrandr --output " l " --left-of " r)))

(defun 144-hz (monitor)
  (run-shell-command
   (concatenate 'string "xrandr --output " monitor " --mode 2560x1440 " " --rate 144")))

;; xrandr --output DP-0 --rotate left --left-of DP-2
;; xrandr --output DP-2 --mode 2560x1440 --rate 144

(defvar *left-monitor* "DP-0")
(defvar *right-monitor* "DP-2")

(defcommand adjust-display () ()
            (turn-on *left-monitor*)
            (turn-on *right-monitor*)
            (rotate-display *left-monitor* "left")
            (left-of *left-monitor* *right-monitor*)
            (144-hz *right-monitor*))
;; (adjust-display)
;; (adjust-display)
