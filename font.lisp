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
;; (xft:cache-fonts)
;; (xft:get-font-families)
;; Done!

;; Some note for using REPL (slime) (sbcl)
;; load a module by (ql:quickload "xxx")

;; This is very slow, use with caution! neng bu yong jiu bu yong
;; (HEBI: run this to cache fonts (not the fc-cache))
;; (xft:cache-fonts)

(defun get-dpi()
  (values
   (parse-integer
    (run-shell-command
     "echo $(xrdb -query | grep dpi | awk '{print $2}') | bc | tr '\n' ' '" t))))

(defcommand hebi()()
            (echo (get-dpi))
            (echo (get-font-size)))

(defun get-font-size()
  (case (get-dpi)
    (96 12)
    (144 16)
    (otherwise 14)))

(set-font
 (list
  (make-instance 'xft:font :family "WenQuanYi Micro Hei Mono" :subfamily "Regular" :size (get-font-size))
  ;; (make-instance 'xft:font :family "DejaVu Sans Mono" :subfamily "Oblique" :size 16)
  ;; (make-instance 'xft:font :family "Source Code Pro" :subfamily "Regular" :size 20)
  ;; (make-instance 'xft:font :family "cwTeXFangSong" :subfamily "Medium" :size 16)
  )
 )
