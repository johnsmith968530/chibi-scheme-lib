;; $Source: /home/x/Dropbox/2/src/chibi-scheme/lib/com/m0x13/RCS/chibi.sld,v $
;; $Date: 2026/04/25 03:42:21 $
;; $Revision: 1.1 $

(define-library (com m0x13 chibi)
  (export chibi-doc-url schemers-url)
  (import (scheme base) (srfi 166))

  (begin

    (define (chibi-doc-url x)
      (show #f "https://synthcode.com/scheme/chibi/lib/chibi/" x ".html"))

    (define (schemers-url x)
      (show #f "https://srfi.schemers.org/srfi-" x "/"))

  ))

;; vim: set et ff=unix ft=scheme lisp nocp sts=2 sw=2 ts=2:
