;; $Source: /home/x/Dropbox/2/src/chibi-scheme/lib/com/m0x13/RCS/amazon.sld,v $
;; $Date: 2026/04/25 07:00:37 $
;; $Revision: 1.1 $

(define-library (com m0x13 amazon)
  (export amazon-named-product-url)
  (import (scheme base) (srfi 166))

  (begin

    (define (amazon-named-product-url name asin1)
      (show #f "https://www.amazon.com/" name "/dp/" asin1 "/"))

  ))

;; vim: set et ff=unix ft=scheme lisp nocp sts=2 sw=2 ts=2:
