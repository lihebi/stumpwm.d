(defvar *monitor* "VGA-1")
(setq *monitor* "DP-2")

(defun rotate(direction) ()
       (run-shell-command
        (concatenate 'string "xrandr --output " *monitor* " --rotate " direction)))

(defcommand rotate-left() ()
            (rotate "left"))
(defcommand rotate-right() ()
            (rotate "right"))
(defcommand rotate-normal() ()
            (rotate "normal"))
