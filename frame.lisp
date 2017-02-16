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
