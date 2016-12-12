;; -*- mode: Lisp;-*-
;;; .stumpwmrc --- StumpWM Init File
(in-package :stumpwm)

;; (in-package :stumpwm)

;; disable welcome message
(setf *startup-message* nil)

(stumpwm:init-load-path "~/.stumpwm.d/modules/")
;; (stumpwm:add-to-load-path "~/.stumpwm.d/modules/util/ttf-fonts")
(load-module "ttf-fonts")
(load-module "cpu")
;; The "battery" will stuck on macbook
(load-module "battery-portable")
(load-module "wifi")
(load-module "amixer")


(load "~/.stumpwm.d/sudo.lisp")
(load "~/.stumpwm.d/mode-line.lisp")
(load "~/.stumpwm.d/font.lisp")
(load "~/.stumpwm.d/group.lisp")


(load "~/.stumpwm.d/frame.lisp")
(load "~/.stumpwm.d/app.lisp")
(load "~/.stumpwm.d/mac.lisp")
(load "~/.stumpwm.d/screenshot.lisp")


;; I want to disable C-t k because it got mis-shooting!
;; But, this is not working
(undefine-key *root-map* (kbd "k"))
;; I have to "define" it to do some dummy echo
(define-key *root-map* (kbd "k") "echo Zzz..")

;; The C-t k actually mapped to "delete", while C-t K mapped to "kill"

(defcommand rotate-left () ()
            (run-shell-command "xrandr --output VGA-1 --rotate left"))

(defcommand rotate-right () ()
            (run-shell-command "xrandr --output VGA-1 --rotate right"))

(defcommand rotate-normal () ()
            (run-shell-command "xrandr --output VGA-1 --rotate normal"))

(defcommand suspend () ()
            (run-shell-command "systemctl suspend"))

(defcommand shutdown () ()
            (run-shell-command "/sbin/shutdown now"))

(defcommand reboot () ()
            (run-shell-command "/sbin/reboot"))

;; Not sure which should comes first!!
;; TODO 1. make this config more robust in terms of not installing quicklisp, clx-truetype, zpng
;; TODO 2. make the setup-debian script complete by installing everything
