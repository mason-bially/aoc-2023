(use-modules
  (srfi srfi-1) ; list
  (srfi srfi-11) ; let-values
  (srfi srfi-41) ; stream
  (ice-9 textual-ports)
  (ice-9 rdelim))

(add-to-load-path (string-append (dirname (current-filename)) "/site-dir"))

(define (call-with-puzzle proc)
  (call-with-input-file "../input.txt" proc))

(define-stream (stream-readlines port)
  (let ((read (read-line port)))
    (if (eof-object? read) stream-null 
      (stream-cons read (stream-readlines port)))
  ))

(define (cdrn p)
  (if p (cdr p) p))
(define (carn p)
  (if p (car p) p))

(define (max-pair a b)
  (if (and b (> (car b) (car a))) b a))
(define (min-pair a b)
  (if (and b (< (car b) (car a))) b a))

(define (display* v)
  (format #t "~a\n" v)
  v)
