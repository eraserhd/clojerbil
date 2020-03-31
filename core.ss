(import :std/generic)
(export nil true false
        ->
        if-let when-let
        inc
        dec
        get get-in)

(def nil '())
(def true #t)
(def false #f)

(defsyntax (-> stx)
  (syntax-case stx ()
    ((_ expr)                          #'expr)
    ((_ expr (head args ...) rest ...) #'(-> (head expr args ...) rest ...))
    ((_ expr symbol rest ...)          #'(-> (symbol expr) rest ...))))

(defsyntax (if-let stx)
  (syntax-case stx (@list nil)
    ((_ [binding expr] then)
     #'(if-let [binding expr]
         then
         nil))
    ((_ [binding expr] then else)
     #'(let (($expr expr))
         (if $expr
           (let ((binding $expr))
             then)
           else)))))

(defsyntax (when-let stx)
  (syntax-case stx (@list nil)
    ((_ [binding expr] body ...)
     #'(if-let [binding expr]
         (begin
           body ...)))))

(def inc (cut + <> 1))
(def dec (cut - <> 1))

(defgeneric get
  (lambda args nil))

(defmethod (get (x <t>) (k <t>))
  (get x k nil))

(defmethod (get (x <null>) (k <t>) (default <t>))
  default)
(defmethod (get (x <hash-table>) (k <t>) (default <t>))
  (hash-ref x k default))

(defsyntax implement-fixnum-get
  (syntax-rules ()
    ((_ type length ref) (begin
                           (defmethod (get (x type) (k <fixnum>) (default <t>))
                             (cond
                               ((< k 0)           default)
                               ((<= (length x) k) default)
                               (else              (ref x k))))
                           (defmethod (get (x type) (k <t>) (default <t>))
                             default)))))

(implement-fixnum-get <vector> vector-length vector-ref)

(def (get-in x ks)
  (if (null? ks)
    x
    (get-in (get x (car ks)) (cdr ks))))

