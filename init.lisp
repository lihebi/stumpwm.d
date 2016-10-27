;; -*- mode: Lisp;-*-
;;; .stumpwmrc --- StumpWM Init File
(in-package :stumpwm)

;; If using multiple files, load them like this:
;; (load "~/.stumpwm.d/init.lisp")

;; https://github.com/ivoarch/.dot-org-files/blob/master/stumpwm.org

;; (in-package :stumpwm)

;; set contrib dir
;; (set-contrib-dir "~/.stumpwm.d/contrib/util")

;; disable welcome message
(setf *startup-message* nil)


;; I have to add this for each one? the info page says the *MODULE-DIR* variable is set to make all the modules avaiable,
;; but it seems the variable is unset
(stumpwm:init-load-path "~/.stumpwm.d/modules/")
;; (stumpwm:add-to-load-path "~/.stumpwm.d/modules/util/ttf-fonts")
(load-module "ttf-fonts")
(load-module "cpu")
;; The "battery" will stuck on macbook
(load-module "battery-portable")
(load-module "wifi")
(load-module "amixer")


(load "sudo.lisp")

(load "mode-line.lisp")
(load "font.lisp")
(load "group.lisp")
;; TODO
;; (define-key *top-map* (kbd "XF86AudioLowerVolume") "amixer-Front-1-")
;; (define-key *top-map* (kbd "XF86AudioRaiseVolume") "amixer-Front-1+")
;; (define-key *top-map* (kbd "XF86AudioMute") "amixer-Master-toggle pulse")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sudo
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-sudo-command lsroot "ls /")

(define-sudo-command brightness-chown "chown hebi:hebi /sys/class/backlight/intel_backlight/brightness")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Commands
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; run-or-raise - emacs
;; run-or-raise - conkeror
;; run-or-raise - urxvt/screen
;; show dropbox status
;; toggle on=|=off modeline


;; I want to disable C-t k because it got mis-shooting!
;; But, this is not working
(undefine-key *root-map* (kbd "k"))
;; I have to "define" it to do some dummy echo
(define-key *root-map* (kbd "k") "echo Zzz..")


(undefine-key *root-map* (kbd "f"))
(undefine-key *root-map* (kbd "o"))
(defvar *frame-map*
  (let ((m (stumpwm:make-sparse-keymap)))
    (stumpwm:define-key m (stumpwm:kbd "f") "curframe")
    (stumpwm:define-key m (stumpwm:kbd "n") "fnext")
    m))

(stumpwm:define-key stumpwm:*root-map* (stumpwm:kbd "f") '*frame-map*)
(define-key *root-map* (kbd "o") "fother")
(define-key *root-map* (kbd "C-o") "fother")





(defcommand emacs-with-server () ()
            "run-or-raise emacs"
            (run-or-raise "emacsclient -ca emacs" '(:class "Emacs")))
(define-key *root-map* (kbd "e") "emacs-with-server")

(defcommand emacs-with-server-new () ()
            "run-shell-command emacsclient"
            (run-shell-command "emacsclient -ca emacs"))

(define-key *root-map* (kbd "C-e") "emacs-with-server-new")

(defcommand browser () ()
            "run or raise conkeror"
            (run-or-raise "conkeror" '(:class "Conkeror")))

;; (defcommand browser () ()
;;             "run or raise chromium"
;;             (run-or-raise "chromium" '(:class "chromium")))
(define-key *root-map* (kbd "w") "browser")

(defcommand terminal () ()
            "run or raise urxvt"
            (run-or-raise "urxvt -e tmux" '(:class "URxvt")))
(define-key *root-map* (kbd "c") "terminal")

(defcommand xselyank () ()
            "Paste X Sel not using shift-insert"
            ;; (echo "what?")
            (window-send-string (get-x-selection)))

(define-key *root-map* (kbd "y") "xselyank")



;; :STRING will function incorrect when used NOT interactively
;;    where it only get the first word
(defcommand dict (word) ((:REST "Look Up: "))
            (echo (concat "looking up .." word))
            ;; if starting with xdm, stumpwm will not have the $PATH variable set up! Thus the full path to "trans" program needs to be specified
            (echo (run-shell-command (concat "/home/hebi/bin/trans -b :zh " word) t)))

(defcommand dict-xsel () ()
            (let ((word (get-x-selection)))
              (dict word)))

(define-key *root-map* (kbd "d") "dict-xsel")

;; speech
(defcommand speech (word) ((:REST "Speech: "))
            (echo (concat "speaking out " word))
            (run-shell-command (concat "espeak \"" + word + "\"")))

(defcommand speech-xsel () ()
            (let ((word (get-x-selection)))
              (speech word)))

(defcommand speech-festival (word) ((:REST "Speech by festival: "))
            (echo (concat "speaking out " word))
            (run-shell-command (concat "echo \"" word "\" | festival --tts")))

(defcommand speech-kill () ()
            (echo "killing speech")
            (run-shell-command (concat
                                "for pid in `ps -ef | grep 'espeak' | awk '{print $2}'`; do kill $pid; done")))






;; TODO the file will be reset to root, and max brightness
(defcommand brightness-inc () ()
            "Increase brightness by 100"
            ;; /sys/class/backlight/intel_backlight/brightness
            (let ((brightness-file "/sys/class/backlight/intel_backlight/brightness"))
              ;; get current brightness
              (let ((cur-val
                     (values (parse-integer (run-shell-command (concat "cat " brightness-file) t)))))
                ;; add 100 to it
                (setq cur-val (+ cur-val 300))
                ;; (echo cur-val)
                (echo (concat "echo " (write-to-string cur-val) " > " brightness-file))
                (run-shell-command (concat "echo " (write-to-string cur-val) " > " brightness-file))
                )
              )
            )


(defcommand brightness-dec () ()
            "Decrease brightness by 100"
            ;; /sys/class/backlight/intel_backlight/brightness
            (let ((brightness-file "/sys/class/backlight/intel_backlight/brightness"))
              ;; get current brightness
              (let ((cur-val
                     (values (parse-integer (run-shell-command (concat "cat " brightness-file) t)))))
                ;; add 100 to it
                (setq cur-val (- cur-val 300))
                ;; (echo cur-val)
                (echo (concat "echo " (write-to-string cur-val) " > " brightness-file))
                (run-shell-command (concat "echo " (write-to-string cur-val) " > " brightness-file))
                )
              )
            )

;; (define-key *root-map* (kbd "b") "brightness-inc")
;; (define-key *root-map* (kbd "C-b") "brightness-dec")
(define-key *root-map* (kbd "XF86MonBrightnessUp") "brightness-inc")
(define-key *root-map* (kbd "XF86MonBrightnessDown") "brightness-dec")


(defcommand suspend () ()
            (run-shell-command "systemctl suspend"))

;; (defcommand chown-brightness () ()
;;             (let ((brightness-file "/sys/class/backlight/intel_backlight/brightness"))
;;               (set-x-selection (concat "chown hebi:hebi " brightness-file))))

(defcommand rotate-left () ()
            (run-shell-command "xrandr --output HDMI-0 --rotate left"))

(defcommand rotate-right () ()
            (run-shell-command "xrandr --output HDMI-0 --rotate right"))

(defcommand rotate-normal () ()
            (run-shell-command "xrandr --output HDMI-0 --rotate normal"))

(defcommand shutdown () ()
            (run-shell-command "/sbin/shutdown now"))


(defcommand reboot () ()
            (run-shell-command "/sbin/reboot"))






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Key bindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (define-key *root-map* (kbd "o") "only")
;; (define-key *root-map* (kbd "z") "windows")

;; (define-key *root-map* (kbd "C-Up") "move-window up")
;; (define-key *root-map* (kbd "C-Left") "move-window left")
;; (define-key *root-map* (kbd "C-Down") "move-window down")
;; (define-key *root-map* (kbd "C-Right") "move-window right")

(stumpwm:define-key stumpwm:*root-map* (stumpwm:kbd "C-z") "echo Zzzzz...")

