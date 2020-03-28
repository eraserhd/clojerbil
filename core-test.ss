(import :std/test
        "core")

(def core-test
  (test-suite "test :clojerbil/core"
    (test-case "test ->"
      (check (-> 7) => 7)
      (check (-> 10 (- 3) (inc) inc) => 9))))

(run-tests! core-test)
(test-report-summary!)

(case (test-result)
  ((OK) (exit 0))
  (else (exit 1)))
