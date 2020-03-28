(export ->
        inc
        dec)

(define-syntax ->
  (syntax-rules ()
    ((_ expr)                          expr)
    ((_ expr (head args ...) rest ...) (-> (head expr args ...) rest ...))
    ((_ expr symbol rest ...)          (-> (symbol expr) rest ...))))

(def inc (cut + <> 1))
(def dec (cut - <> 1))
