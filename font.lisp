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
    ;; cache fonts. pretty slow
    (xft:cache-fonts))

;; (xft:get-font-families) should work now

(set-font
 (list
  ;; this size determines the size of mode line
  (make-instance 'xft:font
                 :family "WenQuanYi Micro Hei Mono"
                 :subfamily "Regular" :size 16)
  (make-instance 'xft:font
                 :family "Source Code Pro"
                 :subfamily "Regular" :size 16)))

;; (set-font "Source Code Pro")
;; (set-font "-xos4-terminus-medium-r-normal--10-140-72-72-c-80-iso8859-15")
