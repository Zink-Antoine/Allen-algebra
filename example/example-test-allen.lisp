(defun example ();;example Allen'paper 83
	(ql:quickload "allen-algebra")
	(use-package :allen-algebra)

	(in-package :allen-algebra)

	(defparameter *ToDo* (make-hash-table :test 'equal)) 	

	(temporal-network '((S) (L)) '(o m))
	(temporal-network '((S) (R)) '(bi m mi b))
	(pretty-hash-table *ToDo*)

	(temporal-network '((L) (R)) (Constraints '(oi mi) '(bi m mi b)))
	(pretty-hash-table *ToDo*)

	(update-temporal-network '((L) (R)) '(o s d))
	(pretty-hash-table *ToDo*)

	(update-temporal-network '((D) (S)) '(d))
	(pretty-hash-table *ToDo*)
)

(example)