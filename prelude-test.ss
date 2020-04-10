prelude: "prelude"

(import :std/test)
(export prelude-test)

(def prelude-test
  (test-suite "test :clojerbil/prelude"
    (test-case "macros are available"
      (check (-> 7) => 7))))
