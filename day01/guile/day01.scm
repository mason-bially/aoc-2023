(include "../../guile/support.scm")
(use-modules
  (srfi srfi-41) ; stream
  (ice-9 format)
  (syntax threading))

(define (part-a s)
  (+ 1 1))

(define (part-b s)
  (+ 1 1))

(define (process proc)
  (lambda (port)
    (~>> (stream-readlines port)
      (stream-map proc)
      (stream-fold + 0))))

(display (format #f "A: ~a\nB: ~a\n"
  (call-with-puzzle (process part-a))
  (call-with-puzzle (process part-b))))
