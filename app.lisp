(defcommand screenshot-area () ()
            (run-shell-command "gnome-screenshot -a"))

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

(defcommand run-atom () ()
            "Atom"
            (run-or-raise "atom" '(:class "Atom")))
(define-key *root-map* (kbd "a") "run-atom")



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
             ;; "chromium --enable-remote-extensions"
             "CHROMIUM_ENABLE_WEB_STORE=yes chromium"
             '(:class "Chromium")))

(define-key *root-map* (kbd "w") "browser")

;; I actually do not need to install from chrome webstore. I just need
;; one extension: videospeed controller, and I can install from
;; source: https://github.com/igrigorik/videospeed
(defcommand browser-new () ()
            "run a new instance of browser"
            (run-shell-command "chromium --enable-remote-extensions"))

(defcommand chrome-app (url) ((:rest "URL (with https!): "))
            "run a new instance of browser"
            ;; currently the best option is to open a url in --app
            ;; mode, such that Ctrl-N is not captured by Chrome. For
            ;; jupyterlab, currently you need:
            ;; https://github.com/kpe/jupyterlab-emacskeys
            (run-shell-command (concat "google-chrome --app=" url)))

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

(defcommand vncviewer () ()
            (run-or-raise
             "vncviewer"
             '(:class "Vncviewer")))
(define-key *root-map* (kbd "v") "vncviewer")



;; (require :swank)
;; (defcommand swank-server () ()
;;             ;; create server for live debugging
;;             ;; (require 'swank)
;;             ;; (swank:create-server)
;;             (swank-loader:init)
;;             (swank:create-server :port 4004
;;                                  :style swank:*communication-style*
;;                                  :dont-close t))


;; :STRING will function incorrect when used NOT interactively
;;    where it only get the first word
;; need to install translate-shell from AUR
(defcommand dict (word) ((:REST "Look Up: "))
            (echo (concat "looking up .." word))
            ;; if starting with xdm, stumpwm will not have the $PATH variable
            ;; set up! Thus the full path to "trans" program needs to be
            ;; specified
            (let ((chinese (string-trim (string #\Newline)
                                        (run-shell-command
                                         (concat "trans"
                                                 ;; " -show-original-phonetics Y"
                                                 ;; " -show-translation-phonetics n"
                                                 ;; " -show-languages n"
                                                 ;; " -show-prompt-message n"
                                                 ;; " -show-dictionary n"
                                                 ;; " -no-theme"
                                                 ;; " -no-ansi"
                                                 " -b"
                                                 " :zh"
                                                 " "
                                                 word)
                                         t))))
              ;; set to x-selection
              (set-x-selection chinese)
              (echo chinese)))



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

