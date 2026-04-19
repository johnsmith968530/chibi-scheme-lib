;; $Source: /Users/x/Dropbox/2/src/chibi-scheme/lib/stack/RCS/stardate.sld,v $
;; $Date: 2026/04/19 05:14:08 $
;; $Revision: 1.1 $

(define-library (stack stardate)
  (export rStar rStar0 rStarn poprStar delrStar clrStar prStar prStarMtime crStar)
  (import (scheme base)
          (chibi)                ; display
          (chibi string)         ; string-trim-right
          (scheme process-context)
          (chibi process))

  (begin

    (define key "org.au0:stack:stardate")

    ;; --- helpers ------------------------------------------------------------

    (define (->string x)
      (if (string? x) x (number->string x)))

    ;; run redis-cli with args → string
    (define (redis . args)
      (string-trim-right
        (process->string
          (cons "redis-cli" (map ->string args)))
        #\newline))

    ;; run stardate command
    (define (stardate . args)
      (string-trim-right
        (process->string
          (cons "stardate" (map ->string args)))
        #\newline))

    ;; --- stack ops ----------------------------------------------------------

    ;; full stack
    (define (rStar)
      (display "Note: redis-cli displays 1-based indices, but commands use 0-based indexing\n")
      (redis "LRANGE" key "0" "-1"))

    ;; index 0
    (define (rStar0)
      (redis "LINDEX" key "0"))

    ;; index n
    (define (rStarn n)
      (if (not n)
          (begin
            (display "Usage: rStarn <n>\n")
            #f)
          (redis "LINDEX" key n)))

    ;; pop
    (define (poprStar)
      (redis "LPOP" key))

    ;; delete index n
    (define (delrStar n)
      (if (not n)
          (begin
            (display "Usage: delrStar <n>\n")
            #f)
          (begin
            (redis "LSET" key n "__DELETED__")
            (redis "LREM" key "1" "__DELETED__"))))

    ;; clear
    (define (clrStar)
      (redis "DEL" key))

    ;; --- push operations ----------------------------------------------------

    ;; push current stardate or given args
    (define (prStar . args)
      (if (null? args)
          ;; equivalent to: stardate | redis-cli -x LPUSH key
          (process->string
            (list "sh" "-c"
                  (string-append
                    "stardate | redis-cli -x LPUSH " key)))
          ;; direct push
          (apply redis (append (list "LPUSH" key) args))))

    ;; push stardate from mtime
    (define (prStarMtime . args)
      (if (null? args)
          (let ((top (redis "LINDEX" key "0")))
            (if (string=? top "")
                (begin
                  (display "Stardate stack is empty\n")
                  #f)
                (process->string
                  (list "sh" "-c"
                        (string-append
                          "stardate --mtime \"" top "\" | redis-cli -x LPUSH " key)))))
          ;; explicit arg
          (process->string
            (list "sh" "-c"
                  (string-append
                    "stardate --mtime \"" (car args) "\" | redis-cli -x LPUSH " key)))))

    ;; --- clipboard ----------------------------------------------------------

    (define (crStar . maybe-n)
      (let* ((n (if (null? maybe-n) "0" (->string (car maybe-n))))
             (top (redis "LINDEX" key n))
             (os (or (get-environment-variable "ORG_AU0_OS") "")))
        (if (string=? top "")
            (display "Stack is empty\n")
            (cond
              ((string=? os "Cygwin")
               (process->string
                 (list "sh" "-c"
                       (string-append "echo -n \"" top "\" > /dev/clipboard"))))
              ((string=? os "Darwin")
               (process->string
                 (list "sh" "-c"
                       (string-append "echo -n \"" top "\" | pbcopy"))))
              ((string=? os "GNU/Linux")
               (process->string
                 (list "sh" "-c"
                       (string-append "echo -n \"" top "\" | xclip -sel clip"))))
              (else
               (display "Unknown operating system\n")
               #f)))))

  ))

;; vim: set et ff=unix ft=scheme lisp nocp sts=2 sw=2 ts=2:
