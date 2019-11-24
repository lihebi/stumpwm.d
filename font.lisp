;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setting fonts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; HACK on NixOS, the clx-truetype is compiled by Nix bulid user, which cause
;; xft:+font-cache-filename+ to be set to /build/.fonts, and that is not
;; accessible. Thus, I'm going into :xft package and set it to $HOME/.fonts
(in-package :xft)
(defparameter +font-cache-filename+
  #.(merge-pathnames "font-cache.sexp"
                     (merge-pathnames ".fonts/" (user-homedir-pathname))))
(setq *font-dirs*
      (remove-duplicates
       (append *font-dirs*
               ;; NixOS fonts
               '("/run/current-system/sw/share/X11-fonts"
                 ;; my own fonts, basically wqy.ttc
                 "/home/hebi/.hebi/fonts"))))
;; switch back to :stumpwm (not :cl-user!)
(in-package :stumpwm)

(if (not (xft:get-font-families))
    ;; cache fonts. pretty slow
    (xft:cache-fonts))

;; (xft:get-font-families) should work now

(set-font
 (list
  ;; this size determines the size of mode line
  (make-instance 'xft:font
                 ;; FIXME would throw error if not found
                 :family "WenQuanYi Micro Hei Mono"
                 :subfamily "Regular" :size 12)
  (make-instance 'xft:font
                 :family "Source Code Pro"
                 :subfamily "Regular" :size 12)
  (make-instance 'xft:font
                 :family "Anonymous Pro"
                 :subfamily "Regular" :size 12)))

;; (set-font "Source Code Pro")
;; (set-font "-xos4-terminus-medium-r-normal--10-140-72-72-c-80-iso8859-15")
