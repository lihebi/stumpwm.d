
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

(define-key *top-map* (kbd "XF86AudioLowerVolume") "amixer-Front-1-")
(define-key *top-map* (kbd "XF86AudioRaiseVolume") "amixer-Front-1+")
(define-key *top-map* (kbd "XF86AudioMute") "amixer-Master-toggle pulse")

(define-sudo-command brightness-chown "chown hebi:hebi /sys/class/backlight/intel_backlight/brightness")
;; (define-key *root-map* (kbd "b") "brightness-inc")
;; (define-key *root-map* (kbd "C-b") "brightness-dec")
(define-key *root-map* (kbd "XF86MonBrightnessUp") "brightness-inc")
(define-key *root-map* (kbd "XF86MonBrightnessDown") "brightness-dec")
