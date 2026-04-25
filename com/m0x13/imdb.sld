;; $Source: /home/x/Dropbox/2/src/chibi-scheme/lib/com/m0x13/RCS/imdb.sld,v $
;; $Date: 2026/04/25 04:36:51 $
;; $Revision: 1.1 $

(define-library (com m0x13 imdb)
  (export imdb-name-url)
  (import (scheme base) (srfi 166))

  (begin

    (define (imdb-name-url id)
      (show #f "https://www.imdb.com/name/" id "/"))

  ))

;; vim: set et ff=unix ft=scheme lisp nocp sts=2 sw=2 ts=2:
