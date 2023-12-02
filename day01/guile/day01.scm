(include "../../guile/support.scm")
(use-modules
  (srfi srfi-41) ; stream
  (ice-9 format)
  (ice-9 string-fun) ; (string-replace-substring)
  (syntax threading))

(define* (string-ref-ord s i #:optional (c #\0))
  (- (char->integer (string-ref s i)) (char->integer c)))

(define (part-a s)
  (+ (* 10 (string-ref-ord s (string-index s char-numeric?)))
     (string-ref-ord s (string-rindex s char-numeric?))))

(define (part-b s)
  (part-a (~> s
    (string-replace-substring "one" "1")
    (string-replace-substring "two" "2")
    (string-replace-substring "three" "3")
    (string-replace-substring "four" "4")
    (string-replace-substring "five" "5")
    (string-replace-substring "six" "6")
    (string-replace-substring "seven" "7")
    (string-replace-substring "eight" "8")
    (string-replace-substring "nine" "9"))))

(define (process proc)
  (lambda (port)
    (~>> (stream-readlines port)
      (stream-map proc)
      (stream-fold + 0))))

(display (format #f "A: ~a\nB: ~a\n"
  (call-with-puzzle (process part-a))
  (call-with-puzzle (process part-b))))
