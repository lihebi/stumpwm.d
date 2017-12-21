;; direction: left, right, normal
(defun rotate-display (monitor direction)
  (run-shell-command
   (concatenate 'string "xrandr --output " monitor " --rotate " direction)))

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
            (rotate-display *left-monitor* "left")
            (left-of *left-monitor* *right-monitor*)
            (144-hz *right-monitor*))
;; (adjust-display)
;; (adjust-display)
