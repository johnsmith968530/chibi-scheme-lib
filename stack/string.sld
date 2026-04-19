;; $Source: /Users/x/Dropbox/2/src/chibi-scheme/lib/stack/RCS/string.sld,v $
;; $Date: 2026/04/18 22:44:29 $
;; $Revision: 1.2 $

(define-library (stack string)
  (export rS0 rSn poprS delrS clrS prS rS)
  (import (scheme base)
          (chibi) ; display
          (chibi string) ; string-trim-right
          (scheme process-context)
          (chibi process))

  (begin

    (define key "org.au0:stack:string")

    ;; --- helpers ------------------------------------------------------------

    (define (->string x)
      (if (string? x) x (number->string x)))

    ;; run redis-cli with args → string
    (define (redis . args)
      (string-trim-right
        (process->string
          (cons "redis-cli" (map ->string args)))
	#\newline))

    ;; --- stack ops ----------------------------------------------------------

    ;; full stack (like `rS` in your bash)
    (define (rS)
      (redis "LRANGE" key "0" "-1"))

    ;; index 0
    (define (rS0)
      (redis "LINDEX" key "0"))

    ;; index n
    (define (rSn n)
      (if (not n)
          (begin
            (display "Usage: rSn <n>\n")
            #f)
          (redis "LINDEX" key n)))

    ;; pop
    (define (poprS)
      (redis "LPOP" key))

    ;; delete index n
    (define (delrS n)
      (if (not n)
          (begin
            (display "Usage: delrS <n>\n")
            #f)
          (begin
            (redis "LSET" key n "__DELETED__")
            (redis "LREM" key "1" "__DELETED__"))))

    ;; clear
    (define (clrS)
      (redis "DEL" key))

    ;; push
    ;; NOTE: this version avoids shell quoting issues by passing args directly
    (define (prS . args)
      (if (null? args)
          ;; clipboard fallback (minimal)
          (let ((os (or (get-environment-variable "ORG_AU0_OS") "")))
            (cond
              ((string=? os "Darwin")
               (process->string
                 (list "sh" "-c"
                       (string-append
                         "pbpaste | redis-cli -x LPUSH " key))))
              ((string=? os "GNU/Linux")
               (process->string
                 (list "sh" "-c"
                       (string-append
                         "xclip -out -selection clipboard | redis-cli -x LPUSH " key))))
              (else
               (display "Unknown OS for clipboard\n")
               #f)))
          ;; direct push
          (apply redis (append (list "LPUSH" key) args))))

  ))

;; vim: set et ff=unix ft=scheme lisp nocp sts=2 sw=2 ts=2:
