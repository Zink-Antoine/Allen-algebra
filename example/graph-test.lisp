(ql:quickload "graph")
(ql:quickload "graph/dot")
(use-package :graph)
(use-package :graph/dot)

(extract-edges-w-values *ToDo*)
(extract-node *ToDo*)



(defparameter *graph-test* (populate (make-instance 'digraph) 
						:nodes node 
					   :edges-w-values edges-w-values))

(to-dot-file *graph-test* "dot-test-1.dot" 
					:node-attrs (list  
						(cons :style (constantly "filled")) 
						(cons :colorscheme (constantly "set34"))))





