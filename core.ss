(export ->
        if-let
        inc
        dec
        nil)

(def nil '())

(defsyntax (-> stx)
  (syntax-case stx ()
    ((_ expr)                          #'expr)
    ((_ expr (head args ...) rest ...) #'(-> (head expr args ...) rest ...))
    ((_ expr symbol rest ...)          #'(-> (symbol expr) rest ...))))

(defsyntax (if-let stx)
  (syntax-case stx (@list nil)
    ((_ [binding expr] then)
     #'(if-let [binding expr] then nil))
    ((_ [binding expr] then else)
     #'(let (($expr expr))
         (if $expr
           (let ((binding $expr))
             then)
           else)))))

(def inc (cut + <> 1))
(def dec (cut - <> 1))

