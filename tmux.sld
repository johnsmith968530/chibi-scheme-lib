;; $Source: /home/x/Dropbox/2/src/chibi-scheme/lib/RCS/tmux.sld,v $
;; $Date: 2026/04/24 18:48:08 $
;; $Revision: 1.1 $

(define-library (tmux)
  (export tmux-rename-window)
  (import (scheme base)
          (scheme process-context)
          (chibi shell))

  (begin

    (define (tmux-rename-window name)
      (let ((tmux-env (get-environment-variable "TMUX")))
        (when (and tmux-env (> (string-length tmux-env) 0))
          (shell (list "tmux" "rename-window" name)))))

  ))

;; vim: set et ff=unix ft=scheme lisp nocp sts=2 sw=2 ts=2:
