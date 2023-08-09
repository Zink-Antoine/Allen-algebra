;;;; allen-algebra.asd

(asdf:defsystem allen-algebra
  :name "allen-algebra"
  :serial t
  :description "Small implementation of Allen's (1983) time interval algebra in LISP"
  :author "Antoine Zink <antoine.zink@culture.gouv.fr>"
  :maintainer "Antoine Zink <antoine.zink@culture.gouv.fr>"
  :version "0.1"
  :license "GPL V3"
  :depends-on (#:graph
               #:graph/matrix
               #:graph/dot)
  :components ((:file "src/package")
               (:file "src/allen-algebra"))

)

