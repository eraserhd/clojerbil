(import :std/test
        "core-test"
        "prelude-test")

(run-tests! core-test prelude-test)
(test-report-summary!)

(case (test-result)
  ((OK) (exit 0))
  (else (exit 1)))
