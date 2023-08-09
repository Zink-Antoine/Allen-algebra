(defpackage allen-algebra/tests/main
  (:use :cl
        :allen-algebra
        :rove))
(in-package :allen-algebra/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :allen-algebra)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
