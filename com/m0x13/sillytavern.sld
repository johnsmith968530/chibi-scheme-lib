;; $Source: /home/x/Dropbox/2/src/chibi-scheme/lib/com/m0x13/RCS/sillytavern.sld,v $
;; $Date: 2026/04/25 06:54:23 $
;; $Revision: 1.1 $

(define-library (com m0x13 sillytavern)
  (export sillytavern-dir
          sillytavern-url)
  (import (scheme base)
          (com m0x13 dropbox)
          (srfi 166))

  (begin

    (define sillytavern-url "http://127.0.0.1:51374/")
    (define sillytavern-dir
      (show #f dropbox-dir "/3/Documents/SillyTavern/2025.718"))

  ))

;; vim: set et ff=unix ft=scheme lisp nocp sts=2 sw=2 ts=2:
