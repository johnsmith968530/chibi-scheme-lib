;; $Source: /home/x/Dropbox/2/src/chibi-scheme/lib/com/m0x13/RCS/git.sld,v $
;; $Date: 2026/04/27 16:25:48 $
;; $Revision: 1.2 $

(define-library (com m0x13 git)
  (export git-remotes)
  (import (scheme small)
          ; https://synthcode.com/scheme/chibi/lib/chibi/filesystem.html
          (chibi filesystem) ; provides change-directory, file-exists?
          ; https://synthcode.com/scheme/chibi/lib/chibi/pathname.html
          (chibi pathname) ; provides path-directory, path-strip-directory,
            ; path-normalize
          ; https://synthcode.com/scheme/chibi/lib/chibi/process.html
          (chibi process) ; provides system?
          ; https://srfi.schemers.org/srfi-98/srfi-98.html
          (srfi 98) ; provides get-environment-variable
          ; https://srfi.schemers.org/srfi-130/srfi-130.html
          (srfi 130) ; provides string-null?, string-split
          ; https://srfi.schemers.org/srfi-166/srfi-166.html
          (srfi 166) ; provides show
          (stardate))

  (begin



    (define (git-remotes)
      ;; Return a list of remote names for the repo in the current
      ;; working directory, or '() if this is not a git repo or no
      ;; remotes are configured.
      (let* ((res (process->output+error+status '("git" "remote")))
             (out (list-ref res 0))
             (status (list-ref res 2)))
        (if (= 0 status)
            (let ((lines (string-split out "\n")))
              (let loop ((result '()) (remaining lines))
                (if (null? remaining)
                    (reverse result)
                    (let ((line (car remaining)))
                      (if (not (string-null? line))
                          (loop (cons line result) (cdr remaining))
                          (loop result (cdr remaining)))))))
            '())))
  )
)

;; vim: set et ff=unix ft=scheme lisp nocp sts=2 sw=2 ts=2:
