(import :std/generic
        :gerbil/gambit/hvectors)
(export nil true false
        ->
        if-let when-let
        count
        dec
        get get-in
        inc)

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

(defgeneric count)

(defmethod (count (x <null>))      0)
(defmethod (count (x <pair>))      (fx1+ (count (cdr x))))
(defmethod (count (x <string>))    (string-length x))
(defmethod (count (x <vector>))    (vector-length x))
(defmethod (count (x <s8vector>))  (s8vector-length x))
(defmethod (count (x <u8vector>))  (u8vector-length x))
(defmethod (count (x <s16vector>)) (s16vector-length x))
(defmethod (count (x <u16vector>)) (u16vector-length x))
(defmethod (count (x <s32vector>)) (s32vector-length x))
(defmethod (count (x <u32vector>)) (u32vector-length x))
(defmethod (count (x <f32vector>)) (f32vector-length x))
(defmethod (count (x <s64vector>)) (s64vector-length x))
(defmethod (count (x <u64vector>)) (u64vector-length x))
(defmethod (count (x <f64vector>)) (f64vector-length x))

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
    ((_ type ref)
     (begin
       (defmethod (get (x type) (k <fixnum>) (default <t>))
         (cond
           ((< k 0)          default)
           ((<= (count x) k) default)
           (else             (ref x k))))
       (defmethod (get (x type) (k <t>) (default <t>))
         default)))))

(implement-fixnum-get <string>    string-ref)
(implement-fixnum-get <vector>    vector-ref)
(implement-fixnum-get <s8vector>  s8vector-ref)
(implement-fixnum-get <u8vector>  u8vector-ref)
(implement-fixnum-get <s16vector> s16vector-ref)
(implement-fixnum-get <u16vector> u16vector-ref)
(implement-fixnum-get <s32vector> s32vector-ref)
(implement-fixnum-get <u32vector> u32vector-ref)
(implement-fixnum-get <f32vector> f32vector-ref)
(implement-fixnum-get <s64vector> s64vector-ref)
(implement-fixnum-get <u64vector> u64vector-ref)
(implement-fixnum-get <f64vector> f64vector-ref)

(def (get-in x ks)
  (if (null? ks)
    x
    (get-in (get x (car ks)) (cdr ks))))

