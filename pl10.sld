;; $Source: /home/x/Dropbox/2/src/chibi-scheme/lib/RCS/pl10.sld,v $
;; $Date: 2026/04/16 19:25:57 $
;; $Revision: 1.1 $

(define-library (pl10)
  (export log10 pl10)
  (import (scheme small)
          (srfi 159))

  (begin
    ;; base-10 log helper (portable)
    (define (log10 x)
      (/ (log x) (log 10)))

    ;; Print log10(x) with optional decimal precision.
    ;; Default precision is 3.
    (define (pl10 x . maybe-digits)
      (let ((digits (if (null? maybe-digits) 3 (car maybe-digits))))
        (show #t
              (with ((precision digits))
                (log10 x))
              "\n")))))

;; vim: set et ff=unix ft=scheme lisp nocp sts=2 sw=2 ts=2:
