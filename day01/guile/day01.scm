(include "../../guile/support.scm")
(use-modules
  (srfi srfi-41) ; stream
  (ice-9 format)
  (ice-9 string-fun) ; (string-replace-substring)
  (syntax threading))
#!curly-infix

(define* (string-ref-ord s i #:optional (c #\0))
  (- (char->integer (string-ref s i)) (char->integer c)))

(define (find-possible-numeric-digit s search)
  (let ((index (search s char-numeric?)))
    (cons index (string-ref-ord s index))))

(define (digit-math lhs rhs) {{lhs * 10} + rhs})

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
(define string-digits-reversed (map (lambda (sd) (cons (string-reverse (car sd)) (cdr sd))) string-digits))

(define (is-string-digit-prefix? s i string-digits)
  (cdrn (find (lambda (sd) (string-prefix? (car sd) s 0 (string-length (car sd)) i)) string-digits)))

(define first-chars-of-string-digits (list->char-set (map (lambda (sd) (string-ref (car sd) 0)) string-digits)))
(define last-chars-of-string-digits (list->char-set (map (lambda (sd) (string-ref (car sd) 0)) string-digits-reversed)))

(define (find-possible-string-digit s first-chars digits)
  (let loop
      ((i (string-index s first-chars)))
    (if i 
      (let ((d (is-string-digit-prefix? s i digits)))
        (if d (cons i d)
          (loop (string-index s first-chars (1+ i)))))
      #f)
  ))

(define (find-possible-string-digit-reverse s)
  (let ((d (find-possible-string-digit (string-reverse s) last-chars-of-string-digits string-digits-reversed)))
    (if d (cons (- (string-length s) (car d)) (cdr d)) #f)))

(define (part-b s)
  (digit-math
    (cdr (min-pair (find-possible-numeric-digit s string-index) (find-possible-string-digit s first-chars-of-string-digits string-digits)))
    (cdr (max-pair (find-possible-numeric-digit s string-rindex) (find-possible-string-digit-reverse s)))))

(define (process proc)
  (lambda (port)
    (~>> (stream-readlines port)
      (stream-map proc)
      (stream-fold + 0))))

(display (format #f "A: ~a\nB: ~a\n"
  (call-with-puzzle (process part-a))
  (call-with-puzzle (process part-b))))
