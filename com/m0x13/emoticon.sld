;; $Source: /home/x/Dropbox/2/src/chibi-scheme/lib/com/m0x13/RCS/emoticon.sld,v $
;; $Date: 2026/04/25 04:36:23 $
;; $Revision: 1.4 $

(define-library (com m0x13 emoticon)
  (export emoticon-anger
          emoticon-fear
          emoticon-happy
          emoticon-love
          emoticon-neutral
          emoticon-sad)
  (import (scheme base) (srfi 166))

  (begin

; The emoticons display cats as a homage to アイネコ (Aineko)
; from Accelerando
; (amazon-named-product-url "Accelerando-Singularity-Book-Charles-Stross-ebook" "B000OIZUC6")
; by Charles Stross
; (imdb-name-url "nm5450521").

    (define emoticon-anger "😾")
    (define emoticon-fear "🙀")
    (define emoticon-happy "😸")
    (define emoticon-love "😻")
    (define emoticon-neutral "🐱")
    (define emoticon-sad "😿")

  ))

;; vim: set et ff=unix ft=scheme lisp nocp sts=2 sw=2 ts=2:
