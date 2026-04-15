;; $Source: /home/x/Dropbox/2/src/chibi-scheme/lib/med/RCS/a1c.sld,v $
;; $Date: 2026/04/15 03:52:20 $
;; $Revision: 1.1 $

;; a1c.sld
;;
;; HbA1c <-> estimated average glucose conversions
;;
;; Formulas:
;;   eAG (mg/dL)  = 28.7 * A1c - 46.7
;;   A1c (%)      = (mg/dL + 46.7) / 28.7
;;
;;   eAG (mmol/L) = 1.59 * A1c - 2.59
;;   A1c (%)      = (mmol/L + 2.59) / 1.59

(define-library (med a1c)
  (export a1c->eag-mg/dl
          eag-mg/dl->a1c
          a1c->eag-mmol/l
          eag-mmol/l->a1c
          mg/dl->mmol/l
          mmol/l->mg/dl
          round-to)
  (import (scheme base))

  (begin
    ;; Round x to n digits after the decimal point.
    (define (round-to x n)
      (let* ((scale (expt 10 n)))
        (/ (round (* x scale)) scale)))

    ;; Unit conversion for glucose:
    ;; 1 mmol/L glucose = 18.0182 mg/dL
    ;; Often approximated as 18.
    (define glucose-factor 18.0182)

    (define (mg/dl->mmol/l mg/dl)
      (/ mg/dl glucose-factor))

    (define (mmol/l->mg/dl mmol/l)
      (* mmol/l glucose-factor))

    ;; A1c (%) -> estimated average glucose (mg/dL)
    (define (a1c->eag-mg/dl a1c)
      (- (* 28.7 a1c) 46.7))

    ;; estimated average glucose (mg/dL) -> A1c (%)
    (define (eag-mg/dl->a1c mg/dl)
      (/ (+ mg/dl 46.7) 28.7))

    ;; A1c (%) -> estimated average glucose (mmol/L)
    (define (a1c->eag-mmol/l a1c)
      (- (* 1.59 a1c) 2.59))

    ;; estimated average glucose (mmol/L) -> A1c (%)
    (define (eag-mmol/l->a1c mmol/l)
      (/ (+ mmol/l 2.59) 1.59))))

;; vim: set et ff=unix ft=scheme lisp nocp sts=2 sw=2 ts=2:
