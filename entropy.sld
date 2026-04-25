;; $Source: /home/x/Dropbox/2/src/chibi-scheme/lib/RCS/entropy.sld,v $
;; $Date: 2026/04/19 05:04:52 $
;; $Revision: 1.3 $

(define-library (entropy)
  (export random-letters
          random-digits
          random-string
          random-minute
          random-port)
  (import (scheme base)
          (chibi process))

  (begin

    ;; Core helper: call python and return stdout
  (define (py-call expr)
    (let ((cmd (list "python3" "-c"
                     (string-append
                      "import entropy, sys;"
                      "sys.stdout.write(str(" expr "))"))))
      (let ((out (process->string cmd)))
        (if (string=? out "")
            (error "Python call produced no output"
                   expr
                   "Is PYTHONPATH set correctly?")
            out))))

    ;; Functions mapped to your entropy.py

    (define (random-letters n)
      (py-call
       (string-append "entropy.random_letters(" (number->string n) ")")))

    (define (random-digits n)
      (py-call
       (string-append "entropy.random_digits(" (number->string n) ")")))

    (define (random-string n)
      (py-call
       (string-append "entropy.random_string(" (number->string n) ")")))

    (define (random-minute)
      (py-call "entropy.random_minute()"))

    (define (random-port)
      (py-call "entropy.random_port()"))

  ))

;; vim: set et ff=unix ft=scheme lisp nocp sts=2 sw=2 ts=2:
