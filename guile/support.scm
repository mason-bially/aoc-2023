
(use-modules
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

(define (display* v)
  (format #t "~a\n" v)
  v)
