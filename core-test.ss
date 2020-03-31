(import :std/sugar
        :std/test
        "core")

(def core-test
  (test-suite "test :clojerbil/core"
    (test-case "test ->"
      (check (-> 7) => 7)
      (check (-> 10 (- 3) (inc) inc) => 9))
    (test-case "test if-let"
      (check (if-let [x false] 'then 'else) => 'else)
      (check (if-let [x true] 'then 'else) => 'then)
      (check (if-let [x 'c] x     'else) => 'c)
      (check (if-let [x false] 'then) => nil))
    (test-case "test when-let"
      (check (when-let [x false] 'body1 'body2) => nil)
      (check (when-let [x 'cond] 'body1 x) => 'cond))
    (test-case "test get"
      (check (get (hash (a-key 'a-value)) 'a-key) => 'a-value)
      (check (get (hash (a-key 'a-value)) 'a-key 'a-default) => 'a-value)
      (check (get (hash (a-key 'a-value)) 'missing-key 'a-default) => 'a-default)
      (check (get nil 'a-key 'a-default) => 'a-default)
      (check (get '#(a b c d) 1 'a-default) => 'b)
      (check (get '#(a b c d) #f 'a-default) => 'a-default)
      (check (get '#(a b c d) -1 'a-default) => 'a-default)
      (check (get '#(a b c d) 4 'a-default) => 'a-default))))

(run-tests! core-test)
(test-report-summary!)

(case (test-result)
  ((OK) (exit 0))
  (else (exit 1)))
