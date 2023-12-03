(include "../../guile/support.scm")
(use-modules
  (srfi srfi-41) ; stream
  (ice-9 format))
#!curly-infix

(define (part-a s)
  2)

(define (part-b s)
  1)

(display (format #f "A: ~a\nB: ~a\n"
  (call-with-puzzle (process-puzzle part-a))
  (call-with-puzzle (process-puzzle part-b))))
