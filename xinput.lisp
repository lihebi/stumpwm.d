;; run this to map all input pointers for natural scrolling
(require "cl-ppcre")

(defun xinput-id-cmd (&rest rests)
  (concat "xinput list"
          ;; "|" "egrep \"slave.*pointer\""
          (apply #'concat rests)
          "|" "grep -v XTEST"
          "|" "sed -e 's/^.*id=//' -e 's/\\s.*$//'"))

(defun get-pointer-ids ()
  (mapcar #'parse-integer
          (cl-ppcre:split "\\s+"
                          (run-shell-command
                           (xinput-id-cmd "| egrep \"slave.*pointer\"") t))))
;; (get-pointer-ids)
(defun get-touchpad-ids ()
  (mapcar #'parse-integer
          (cl-ppcre:split "\\s+"
                          (run-shell-command
                           (xinput-id-cmd "| egrep \"TouchPad\"") t))))
;; (get-touchpad-ids)

(defun xinput-set-natural-scroll (id)
  (run-shell-command
   (format nil
           "xinput set-prop ~a \"~a\" ~a"
           id "libinput Natural Scrolling Enabled" 1)
   t))
(defun xinput-disable (id)
  (run-shell-command
   (format nil "xinput disable ~a" id) t))


(defcommand natural-scrolling () ()
  (mapcar #'xinput-set-natural-scroll (get-pointer-ids)))
(defcommand disable-touchpad () ()
  (mapcar #'xinput-disable (get-touchpad-ids)))

;; I actually want to run it when I start stumpwm
(natural-scrolling)
(disable-touchpad)
;; this does not work for newly added device by hot plug, so I need to
;; manually call this command. Is there a way to automatically do
;; this?
