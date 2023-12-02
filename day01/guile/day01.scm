(include "../../guile/support.scm")
(use-modules
  (srfi srfi-41) ; stream
  (ice-9 format)
  (ice-9 string-fun) ; (string-replace-substring)
  (syntax threading))

(define* (string-ref-ord s i #:optional (c #\0))
  (- (char->integer (string-ref s i)) (char->integer c)))

(define (find-possible-numeric-digit s search)
  (let ((index (search s char-numeric?)))
    (cons index (string-ref-ord s index))))

(define (digit-math lhs rhs) (+ (* 10 lhs) rhs))

(define (part-a s)
  (digit-math
    (cdr (find-possible-numeric-digit s string-index))
    (cdr (find-possible-numeric-digit s string-rindex))))

(define string-digits '(
    ("one" . 1)
    ("two" . 2)
    ("three" . 3)
    ("four" . 4)
    ("five" . 5)
    ("six" . 6)
    ("seven" . 7)
    ("eight" . 8)
    ("nine" . 9)
  ))

(define (is-string-digit-prefix? s i)
  (cdrn (find (lambda (sd) (string-prefix? (car sd) s 0 (string-length (car sd)) i)) string-digits)))
(define (is-string-digit-suffix? s i)
  (cdrn (find (lambda (sd) (string-suffix? (car sd) s 0 (string-length (car sd)) 0 i)) string-digits)))

(define first-chars-of-string-digits (string->char-set "otfsen"))
(define last-chars-of-string-digits (string->char-set "eorxnt"))

(define (find-possible-string-digit s)
  (let loop
      ((i (string-index s first-chars-of-string-digits)))
    (if i 
      (let ((d (is-string-digit-prefix? s i)))
        (if d (cons i d)
          (loop (string-index s first-chars-of-string-digits (1+ i)))))
      #f)
  ))

(define (rfind-possible-string-digit s)
  (let loop
      ((i (string-rindex s last-chars-of-string-digits)))
    (if (and i (> i 1)) 
      (let ((d (is-string-digit-suffix? s (1+ i))))
        (if d (cons i d)
          (loop (string-rindex s last-chars-of-string-digits 0 i))))
      #f)
  ))

(define (part-b s)
  (display* s)
  (display* (digit-math
    (cdr (min-pair (display* (find-possible-numeric-digit s string-index)) (display* (find-possible-string-digit s))))
    (cdr (max-pair (display* (find-possible-numeric-digit s string-rindex)) (display* (rfind-possible-string-digit s)))))))

(define (process proc)
  (lambda (port)
    (~>> (stream-readlines port)
      (stream-map proc)
      (stream-fold + 0))))

(display (format #f "A: ~a\nB: ~a\n"
  (call-with-puzzle (process part-a))
  (call-with-puzzle (process part-b))))
