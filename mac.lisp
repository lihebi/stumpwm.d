
;; TODO the file will be reset to root, and max brightness
;; require alsa-utils package for amixer command
;; require also pulseaudio-alsa
(define-key *top-map* (kbd "XF86AudioLowerVolume") "amixer-Master-1-")
(define-key *top-map* (kbd "XF86AudioRaiseVolume") "amixer-Master-1+")
(define-key *top-map* (kbd "XF86AudioMute") "amixer-Master-toggle pulse")

;; require installation of xorg-xbacklight or acpilight (aur)
;; also require to set permision for video group users
(defcommand bl-u () ()
  (run-shell-command "xbacklight -inc 10" t)
  (echo (run-shell-command "xbacklight -get" t)))
(defcommand bl-d () ()
  (run-shell-command "xbacklight -dec 10" t)
  (echo (run-shell-command "xbacklight -get" t)))

(define-key *top-map* (kbd "XF86MonBrightnessUp") "bl-u")
(define-key *top-map* (kbd "XF86MonBrightnessDown") "bl-d")

;; need to chown first in order to adjust brightness
(define-sudo-command brightness-chown "chown hebi:hebi /sys/class/backlight/intel_backlight/brightness")
;; (define-key *root-map* (kbd "b") "brightness-inc")
;; (define-key *root-map* (kbd "C-b") "brightness-dec")
