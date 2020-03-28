(import :std/test
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
      (check (when-let [x 'cond] 'body1 x) => 'cond))))

(run-tests! core-test)
(test-report-summary!)

(case (test-result)
  ((OK) (exit 0))
  (else (exit 1)))
