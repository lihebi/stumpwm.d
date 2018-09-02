(define-module (gnu packages hebi)
  #:use-module (gnu packages)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (gnu packages readline)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages tex)
  #:use-module (gnu packages m4)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix hg-download)
  #:use-module (guix utils)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system asdf)
  #:use-module (guix build-system trivial)
  #:use-module (gnu packages base)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages bdw-gc)
  #:use-module (gnu packages libffi)
  #:use-module (gnu packages libffcall)
  #:use-module (gnu packages readline)
  #:use-module (gnu packages sdl)
  #:use-module (gnu packages libsigsegv)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages ed)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages m4)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages xorg)
  #:use-module (ice-9 match)
  #:use-module (srfi srfi-1))

;; TODO how to build this package??
;; FIXME if the package is installed, will the stumpwm be able to use it?
(define-public sbcl-clx-truetype
  (package
   (name "sbcl-clx-truetype")
   (version "0.0.1")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/filonenko-mikhail/clx-truetype.git")
           (commit "c6e10a918d46632324d5863a8ed067a83fc26de8")))
     ;; git clone https://...
     ;; cd xxx
     ;; git log | head -1 # show the first commit
     ;; git checkout c6e10a
     ;; guix hash -rx .
     (sha256
      (base32
       "079hyp92cjkdfn6bhkxsrwnibiqbz4y4af6nl31lzw6nm91j5j37"))
     (file-name (string-append "clx-truetype-" version "-checkout"))))
   (build-system asdf-build-system/sbcl)
   (synopsis "CLX truetype drawing library for Common Lisp")
   (description
    "For usage with stumpwm to show CJK fonts")
   (home-page "http://frisbeejun.ru/clx-truetype/")
   (license license:public-domain)))
