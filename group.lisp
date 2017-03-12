;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Window format
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Group/window format
(setf *group-format* "%s [%n] %t ")
(setf *window-format* "%m%n%s%c")

;; Window gravity
;; (setf *message-window-gravity* :top-right)
;; (setf *input-window-gravity* :top-right)

;; Default border style
;; (setq *window-border-style* :thin)

;; I like 3 seconds for messages.
;; (setf *timeout-wait* 5)

;; Mouse focus by click.
(setf *mouse-focus-policy* :click)
;; Create groups
(setf (group-name (first (screen-groups (current-screen)))) "Default")
(gnewbg "Default-2")
(gnewbg-float "Float")

;; Shell program used by run-shell-command
;; (setq *shell-program* (stumpwm::getenv "SHELL"))

