(defcommand rotate-left () ()
            (run-shell-command "xrandr --output VGA-1 --rotate left"))

(defcommand rotate-right () ()
            (run-shell-command "xrandr --output VGA-1 --rotate right"))

(defcommand rotate-normal () ()
            (run-shell-command "xrandr --output VGA-1 --rotate normal"))
