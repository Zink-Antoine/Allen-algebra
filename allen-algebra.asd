;;;; allen-algebra.asd


(asdf:defsystem "allen-algebra"
  :version "0.1.0"
  :author "Antoine Zink <antoine.zink@culture.gouv.fr> ORCID = https://orcid.org/0000-0001-7146-1101"
  :license  "CeCILL-2 | file LICENSE"
  :depends-on (#:graph
               #:graph/matrix
               #:graph/dot)
  :components ((:module "src"
                :components
                ((:file "package")
               (:file "allen-algebra"))))
  :description "Small implementation of Allen's (1983) time interval algebra in LISP"
  :in-order-to ((test-op (test-op "allen-algebra/tests"))))

(defsystem "allen-algebra/tests"
  :author "Antoine Zink <antoine.zink@culture.gouv.fr>"
  :license  "CeCILL-2 | file LICENSE"
  :depends-on ("allen-algebra"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for allen-algebra"
  :perform (test-op (op c) (symbol-call :rove :run c)))
