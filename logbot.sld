;; $Source: /home/x/Dropbox/2/src/chibi-scheme/lib/RCS/logbot.sld,v $
;; $Date: 2026/04/17 01:43:37 $
;; $Revision: 1.1 $

(define-library (logbot)
  (export logbot)
  (import (scheme base)
          (scheme process-context)
          (chibi process))

  (begin
    (define (logbot . args)
      (let ((exe (get-environment-variable "ORG_AU0_LOGBOT")))
        (cond
          ((not exe)
           (error "ORG_AU0_LOGBOT is not set"))
          ((string=? exe "")
           (error "ORG_AU0_LOGBOT is empty"))
          (else
           (process->string (cons exe args))))))))

;; vim: set et ff=unix ft=scheme lisp nocp sts=2 sw=2 ts=2:
