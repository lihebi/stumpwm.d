;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setting fonts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Finallly I got this working!
;; Steps
;; 1. must call (xft:cache-fonts)
;; 2. you can view the (print xft:*font-dirs*), it shows the path is ~/.fonts, not ~/.fonts/TTF
;;    ("/usr/share/fonts/" "/home/hebi/.fonts/")
;;    So move font files up to the ~/.fonts
;; A combo:
;; Done!


(if (not (find "Source Code Pro" (xft:get-font-families)
               :test #'equal))
    (xft:cache-fonts))

;; Some note for using REPL (slime) (sbcl)
;; load a module by (ql:quickload "xxx")

;; This is very slow, use with caution! neng bu yong jiu bu yong
;; (HEBI: run this to cache fonts (not the fc-cache))
;; (xft:cache-fonts)


;; Another reason to fail is not having xrdb, bc, tr installed
(defun get-dpi()
  (values
   (parse-integer
    (run-shell-command
     ;; require bc to be installed
     "echo $(xrdb -query | grep dpi | awk '{print $2}') | bc | tr '\n' ' '" t))))

;; ;; (defcommand hebi()()
;; ;;             (echo (get-dpi))
;; ;;             (echo (get-font-size)))

;; (defun get-font-size()
;;   (case (get-dpi)
;;     (96 12)
;;     (144 16)
;;     (otherwise 14)))

(defun get-font-size ()
  (/ (get-dpi) 8))

;; (setq xft:*font-dirs*
;;       (cons "/usr/share/fonts/adobe-source-code-pro/"
;;             xft:*font-dirs*))
;; (xft:cache-fonts)
;; (xft:get-font-families)
;; (xft:cache-font-file "/usr/share/fonts/adobe-source-code-pro/SourceCodePro-Regular.otf")
(set-font
 (list
  ;; this size determines the size of mode line
  ;; 12: my desktop
  ;; 16: tp25
  (make-instance 'xft:font :family "WenQuanYi Micro Hei Mono" :subfamily "Regular" :size (get-font-size))
  ;; (make-instance 'xft:font :family "WenQuanYi Zen Hei Mono" :subfamily "Regular" :size 12)
  ;; (make-instance 'xft:font :family "Source Han Sans CN" :subfamily "Regular" :size 12)
  ;; (make-instance 'xft:font :family "WenQuanYi Zen Hei" :subfamily "Regular" :size 12)
  
  ;; (make-instance 'xft:font :family "DejaVu Sans Mono" :subfamily "Oblique" :size 12)
  (make-instance 'xft:font :family "Source Code Pro" :subfamily "Regular" :size (get-font-size))
  ;; (make-instance 'xft:font :family "cwTeXFangSong" :subfamily "Medium" :size 16)
  )
 )

;; (set-font "Source Code Pro")
;; (set-font "-xos4-terminus-medium-r-normal--10-140-72-72-c-80-iso8859-15")
