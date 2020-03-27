(export ->)

(define-syntax ->
  (syntax-rules ()
    ((_ expr)                          expr)
    ((_ expr (head args ...) rest ...) (-> (head expr args ...) rest ...))
    ((_ expr symbol rest ...)          (-> (symbol expr) rest ...))))
