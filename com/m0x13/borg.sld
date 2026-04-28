;; $Source: /home/x/Dropbox/2/src/chibi-scheme/lib/com/m0x13/RCS/borg.sld,v $
;; $Date: 2026/04/26 17:46:24 $
;; $Revision: 1.3 $

(define-library (com m0x13 borg)
  (export backup-huggingface)
  (import (scheme small)
          ; https://synthcode.com/scheme/chibi/lib/chibi/filesystem.html
          (chibi filesystem) ; provides change-directory
          ; https://synthcode.com/scheme/chibi/lib/chibi/process.html
          (chibi process) ; provides system?
          ; https://srfi.schemers.org/srfi-98/srfi-98.html
          (srfi 98)) ; provides get-environment-variable

  (begin

    (define (backup-huggingface)
      (change-directory (get-environment-variable "HOME"))
      (system? "borg-backup.py"
               "huggingface"
               ".cache/huggingface"
               "Dropbox/2/src/zsh/llama-server"))

  ))

;; vim: set et ff=unix ft=scheme lisp nocp sts=2 sw=2 ts=2:
