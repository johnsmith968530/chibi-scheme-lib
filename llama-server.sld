;; $Source: /home/x/Dropbox/2/src/chibi-scheme/lib/RCS/llama-server.sld,v $
;; $Date: 2026/04/28 20:49:26 $
;; $Revision: 1.3 $

(define-library (llama-server)
  (export disable-thinking
          host-and-port
          llama-server
          preserve-thinking
          qwen-3_6-35B-a3b-args
          standard-args)
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
          (envy)
          (stardate))

  (begin

    (define disable-thinking
      (list "--reasoning" "off"))

    (define host-and-port
      (list "--host" (envy "get" "global" "llama.cpp" "llama-server" "address")
            "--port" (envy "get" "global" "llama.cpp" "llama-server" "port")))

    (define llama-server "/usr/local/llama.cpp/current/llama-server")

    (define preserve-thinking
      (list "--chat-template-kwargs" "{\"preserve_thinking\": true}"))

    (define standard-args
      (cons "--jinja" host-and-port))

    (define qwen-3_6-35B-a3b-args
      (append standard-args
        (list "--ctx-size" "262144"
              "--temperature" "1.0"
              "--top_p" "0.95"
              "--top_k" "20"
              "--min_p" "0.0"
              "--presence-penalty" "1.5"
              "--repeat-penalty" "1.0")))

    (define google-gemma-4-E4B-it-args
      (append standard-args
        (list "--ctx-size" "262144"
              "--temperature" "1.0"
              "--top_p" "0.95"
              "--top_k" "64")))

  )
)

;; vim: set et ff=unix ft=scheme lisp nocp sts=2 sw=2 ts=2:
