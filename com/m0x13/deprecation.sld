;; $Source: /home/x/Dropbox/2/src/chibi-scheme/lib/com/m0x13/RCS/deprecation.sld,v $
;; $Date: 2026/04/25 03:47:10 $
;; $Revision: 1.3 $

(define-library (com m0x13 deprecation)
  (export srfi-deprecation)
  (import (scheme base)
          (com m0x13 chibi)
          (com m0x13 emoticon)
          (srfi 166))
  (begin

    (define (srfi-deprecation x y)
      (show #t emoticon-sad " SRFI " x " is deprecated in favor of SRFI " y nl)
      (show #t "See " (schemers-url x) nl)
      (show #t "and " (schemers-url y) nl))
  ))

;; vim: set et ff=unix ft=scheme lisp nocp sts=2 sw=2 ts=2:
