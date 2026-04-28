;; $Source: /home/x/Dropbox/2/src/chibi-scheme/lib/com/m0x13/RCS/rcs.sld,v $
;; $Date: 2026/04/26 20:44:10 $
;; $Revision: 1.6 $

(define-library (com m0x13 rcs)
  (export ci rcs-filename rcs-init)
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
          ; https://srfi.schemers.org/srfi-166/srfi-166.html
          (srfi 166) ; provides show
          (stardate))

  (begin

    (define (rcs-filename filename)
      (show #f (path-directory filename)
            "/RCS/"
            (path-strip-directory filename)
            ",v"))

    (define (rcs-init filename)
      (let* (
             (rcs-dir (show #f (path-directory filename) "/RCS"))
             (rcs-file (show #f rcs-dir "/" filename ",v"))
             (abspath (path-normalize filename))
             (hostname (get-environment-variable "ORG_AU0_HOSTNAME"))
             (msg (show #f "-t-" hostname ":" abspath))
            )

        (cond (
          (not (file-exists? rcs-file))
            (if (not (file-exists? rcs-dir))
              (create-directory rcs-dir))
            (system? "ci" "-l" msg filename)))))

    (define (ci . (dir1 msg1 . files1))
      (change-directory dir1)
      (let* (
             (msg2 (if msg1
                     (show #f "-m" msg1)
                     (show #f "-mSnapshot on " (stardate) ".")))
            )
        (map rcs-init files1)
        (apply system? (append (list "ci" "-l" msg2) files1))
      )
    )
  )
)

;; vim: set et ff=unix ft=scheme lisp nocp sts=2 sw=2 ts=2:
