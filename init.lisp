;; -*- mode: Lisp;-*-
;;; .stumpwmrc --- StumpWM Init File
(in-package :stumpwm)

;; Make sure quicklisp is not installing duplicated packages then
;; system level installation. Otherwise there will be "cannot define
;; meta class" like error.
;; (load "~/quicklisp/setup.lisp")

;; disable welcome message
(setf *startup-message* nil)

;; FIXME does not check if exists. Make sure this directory exists
(stumpwm:init-load-path "~/.stumpwm.d/stumpwm-contrib/")

(load-module "cpu")
(load-module "mem")
(load-module "battery-portable")
;; wifi module is also broken due to some missed packages
;; (load-module "wifi")
(load-module "amixer")
(load-module "mpd")


(load "~/.stumpwm.d/sudo.lisp")
(load "~/.stumpwm.d/mode-line.lisp")
(load "~/.stumpwm.d/group.lisp")

(load "~/.stumpwm.d/frame.lisp")
(load "~/.stumpwm.d/app.lisp")
(load "~/.stumpwm.d/xinput.lisp")
(load "~/.stumpwm.d/mac.lisp")

(load "~/.stumpwm.d/monitor.lisp")

;; (load-module "ttf-fonts")
;; (load "~/.stumpwm.d/font.lisp")

;; (load "~/.stumpwm.d/screenshot.lisp")

;; I want to disable C-t k because it got mis-shooting!
;; But, this is not working
;; (undefine-key *root-map* (kbd "k"))
;; I have to "define" it to do some dummy echo
;; (define-key *root-map* (kbd "k") "echo Zzz..")

;; (define-key *root-map* (kbd "k")
;;   (delete-window))

;; The C-t k actually mapped to "delete", while C-t K mapped to "kill"

(run-shell-command "xrdb ~/.Xresources")
(run-shell-command "xmodmap ~/.Xmodmap")
(run-shell-command "sh ~/.fehbg")

(defcommand suspend () ()
            (run-shell-command "systemctl suspend"))

(defcommand shutdown () ()
            (run-shell-command "/sbin/shutdown now"))

(defcommand reboot () ()
            (run-shell-command "/sbin/reboot"))

