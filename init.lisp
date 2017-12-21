;; -*- mode: Lisp;-*-
;;; .stumpwmrc --- StumpWM Init File
(in-package :stumpwm)

;; (in-package :stumpwm)

;; disable welcome message
(setf *startup-message* nil)

;; Not sure which should comes first!!
;; TODO 1. make this config more robust in terms of not installing quicklisp, clx-truetype, zpng
;; TODO 2. make the setup-debian script complete by installing everything
;; (stumpwm:init-load-path "~/.stumpwm.d/modules/")


(stumpwm:init-load-path "~/quicklisp/dists/quicklisp/software/")
(stumpwm:init-load-path "/usr/share/common-lisp/source")

;; when installing stumpwm-contrib and quicklisp via AUR, these two pathes needs to be added
(stumpwm:init-load-path "/usr/lib/quicklisp/dists/quicklisp/software/")
(stumpwm:init-load-path "/usr/share/stumpwm/contrib/")


;; (stumpwm:init-load-path "~/.stumpwm.d/modules/")
;; (stumpwm:add-to-load-path "~/.stumpwm.d/modules/util/ttf-fonts")

;; FIXME does not check if exists
(stumpwm:init-load-path "~/.stumpwm.d/contrib/")

(load-module "ttf-fonts")
(load-module "cpu")
(load-module "mem")
;; The "battery" will stuck on macbook
(load-module "battery-portable")
(load-module "wifi")
(load-module "amixer")
(load-module "mpd")


(load "~/.stumpwm.d/sudo.lisp")
(load "~/.stumpwm.d/mode-line.lisp")
(load "~/.stumpwm.d/group.lisp")


(load "~/.stumpwm.d/frame.lisp")
(load "~/.stumpwm.d/app.lisp")
(load "~/.stumpwm.d/xinput.lisp")
(load "~/.stumpwm.d/mac.lisp")

;; causing errors with stumpwm-git version from AUR
(load "~/.stumpwm.d/monitor.lisp")



;; These two lines requires cl packages, remove so that I can get a smooth boot
(load "~/.stumpwm.d/font.lisp")
;; (load "~/.stumpwm.d/screenshot.lisp")



;; I want to disable C-t k because it got mis-shooting!
;; But, this is not working
(undefine-key *root-map* (kbd "k"))
;; I have to "define" it to do some dummy echo
(define-key *root-map* (kbd "k") "echo Zzz..")

;; The C-t k actually mapped to "delete", while C-t K mapped to "kill"


(defcommand suspend () ()
            (run-shell-command "systemctl suspend"))

(defcommand shutdown () ()
            (run-shell-command "/sbin/shutdown now"))

(defcommand reboot () ()
            (run-shell-command "/sbin/reboot"))

;; create server for live debugging
;; (require 'swank)
;; (swank:create-server)
(require :swank)
(swank-loader:init)
(swank:create-server :port 4004
                     :style swank:*communication-style*
                     :dont-close t)
