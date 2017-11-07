(defcommand emacs-with-server () ()
            "run-or-raise emacs"
            (run-or-raise "emacsclient -ca emacs" '(:class "Emacs")))
(define-key *root-map* (kbd "e") "emacs-with-server")

(defcommand emacs-with-server-new () ()
            "run-shell-command emacsclient"
            (run-shell-command "emacsclient -ca emacs"))

(define-key *root-map* (kbd "C-e") "emacs-with-server-new")

(defcommand emacs-start-server() ()
            "Run emacs server"
            (run-shell-command "emacs --daemon"))


;; run this to map all input pointers for natural scrolling
(require "cl-ppcre")
(defcommand natural-scrolling() ()
            (let* ((cmd (concat "xinput list"
                                "|" "egrep \"slave.*pointer\""
                                "|" "grep -v XTEST"
                                "|" "sed -e 's/^.*id=//' -e 's/\\s.*$//'"))
                   (str (run-shell-command cmd t))
                   (sp (cl-ppcre:split "\\s+" str))
                   (cmds (mapcar (lambda (d)
                              (concatenate
                               'string
                               "xinput set-prop "
                               d
                               " \"libinput Natural Scrolling Enabled\" 1")) 
                                 sp)))
              (mapcar (lambda (cmd) (run-shell-command cmd)) cmds)))
;; I actually want to run it when I start stumpwm
(natural-scrolling)
;; this does not work for newly added device by hot plug, so I need to
;; manually call this command. Is there a way to automatically do
;; this?

;; (defcommand browser () ()
;;   "run or raise conkeror"
;;   (run-or-raise "conkeror" '(:class "Conkeror")))


(defcommand reset-bg () ()
            (run-shell-command "sh ~/.fehbg"))

(define-sudo-command wifi-connect "iw dev wlp3s0 connect \"IASTATE\"")

(defcommand browser () ()
            "run or raise chromium"
            (run-or-raise
             ;; "chromium"
             ;; for bypassing the chromium restriction in the recent update
             "chromium --enable-remote-extensions"
             '(:class "Chromium")))

(define-key *root-map* (kbd "w") "browser")

(defcommand browser-new () ()
            "run a new instance of browser"
            (run-shell-command "chromium --enable-remote-extensions"))
;; (undefine-key *root-map* (kbd "C-w"))
(define-key *root-map* (kbd "C-w") "browser-new")


(defcommand firefox () ()
            "run or raise firefox"
            (run-or-raise
             "firefox"
             '(:class "Firefox")))
(define-key *root-map* (kbd "u") "firefox")

(defcommand terminal () ()
            "run or raise urxvt"
            (run-or-raise "urxvt -e tmux" '(:class "URxvt")))
(define-key *root-map* (kbd "c") "terminal")


(defcommand terminal-without-tmux () ()
            "run shell command urxvt, and get the tmux"
            (run-shell-command "urxvt"))

(define-key *root-map* (kbd "C-c") "terminal-without-tmux")

(defcommand xselyank () ()
            "Paste X Sel not using shift-insert"
            ;; (echo "what?")
            (window-send-string (get-x-selection)))

(define-key *root-map* (kbd "y") "xselyank")




;; :STRING will function incorrect when used NOT interactively
;;    where it only get the first word
;; need to install translate-shell from AUR
(defcommand dict (word) ((:REST "Look Up: "))
            (echo (concat "looking up .." word))
            ;; if starting with xdm, stumpwm will not have the $PATH variable set up! Thus the full path to "trans" program needs to be specified
            (echo (run-shell-command (concat "trans -b :zh " word) t)))

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

