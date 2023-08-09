;;; allen-algebra.lisp

;; Copyright (C) Antoine Zink 2023

;; Licensed under the Gnu Public License Version 3 or later


(in-package :allen-algebra)

(defparameter *transitive-table* 
	(make-array '(12 12) 
		:initial-contents
		'(((B) NIL (B O M D S) (B) (B) (B O M D S) (B) (B O M D S) (B) (B) (B O M D S) (B))

		(NIL (BI) (BI OI MI D F) (BI) (BI OI MI D F) (BI) (BI OI MI D F) (BI) (BI OI MI D F) (BI) (BI) (BI))

		((B) (BI) (D) NIL (B O M D S) (BI OI MI D F) (B) (BI) (D) (BI OI MI D F) (D) (B O M D S))

		((B O M DI FI) (BI OI DI MI SI) (O OI D DI S SI F FI E) (DI) (O DI FI) (OI DI SI) (O DI FI) (OI DI SI) (O DI FI) (DI) (OI DI SI) (DI))

		((B) (BI OI DI MI SI) (O D S) (B O M DI FI) (B O M) (O OI D DI S SI F FI E) (B) (OI DI SI) (O) (DI FI O) (D S O) (B O M))
 
		((B O M DI FI) (BI) (OI D F) (BI OI MI DI SI) (O OI D DI S SI F FI E) (BI OI MI) (O DI FI) (BI) (OI D F) (OI BI MI) (OI) (OI DI SI))
 
		((B) (BI OI MI DI SI) (O D S) (B) (B) (O D S) (B) (F FI E) (M) (M) (D S O) (B))

		((B O M DI FI) (BI) (OI D F) (BI) (OI D F) (BI) (S SI E) (BI) (D F OI) (BI) (MI) (MI))

		((B) (BI) (D) (B O M DI FI) (B O M) (OI D F) (B) (MI) (S) (S SI E) (D) (B M O))

		((B O M DI FI) (BI) (OI D F) (DI) (O DI FI) (OI) (O DI FI) (MI) (S SI E) (SI) (OI) (DI))

		((B) (BI) (D) (BI OI MI DI SI) (O D S) (BI OI MI) (M) (BI) (D) (BI OI MI) (F) (F FI E))

		((B) (BI OI MI DI SI) (O D S) (DI) (O) (OI DI SI) (M) (SI OI DI) (O) (DI) (F FI E) (FI)))
))

(format t "~a~%" *transitive-table*)
;;(terpri)

(defvar *allen-temporal-relation* '(b bi d di o oi m mi s si f fi e))

(defun temporal-relation-inv (temporal-relation)
	(let (inv)
	 (dolist (k temporal-relation inv)
	  (setq inv 
	   (push
	    (nth
		 (position k *allen-temporal-relation*)
		 '(bi b di d oi o mi m si s fi f e))
	     inv)))
	))
		

(defun entry-in-transitive-table (r1 r2)
	(setq disparition (remove 'e *allen-temporal-relation*))
	(let (
		 (r1-index (position r1 disparition))
		 (r2-index (position r2 disparition)))
	;;return
	(aref *transitive-table* r1-index r2-index)))

(defun Constraints (R1 R2)
	(defparameter C ())
	(dolist (k1 R1)
		(dolist (k2 R2)
		  (if (not (or (equal k1 'e)(equal k2 'e)))
			(setq C (union C (entry-in-transitive-table k1 k2))))
	))
	(write C)
)

(defparameter *ToDo* (make-hash-table :test 'equal)) ;; ToDo est une hash-table avec en clé les arcs (i j) et en propriétés les relations temporelles associées N(i,j)

(defun temporal-network (arc temporal-relation)
	(setf (gethash arc *ToDo*) temporal-relation)
	(setf (gethash (list (second arc) (first arc)) *ToDo*) (temporal-relation-inv temporal-relation)))

(defun pretty-hash-table (*h*) ;;shiny
	(maphash #'(lambda (k v) (format t "~a => ~a~%" k v)) *h*))


(defun extract-edges-w-values (hash-table-Allen)
  (let (key val)
	 (loop for k being the hash-keys in hash-table-Allen using (hash-value v)
			do (push (list (elt (elt k 0)0) (elt (elt k 1)0)) key)
				(push v val))
	(defparameter edges-w-values (map 'list #'cons key val))))

(defun extract-node (hash-table)
  (defparameter node ());;define nodes
  (loop for k being the hash-keys in hash-table
	do (setq node (union node (union (elt k 0) (elt k 1))))	
   ))

(defun extract-edge (hash-table)
  (defparameter edge ());;define edges
  (loop for k being the hash-keys in hash-table
	do (push (list (elt k 0) (elt k 1)) edge)))	

(defun update-temporal-network (arc temporal-relation);;nécessite au préalable au moins deux arcs  
  (defparameter i (first arc))
  (defparameter j (second arc))
  (multiple-value-bind (value present) (gethash  arc *ToDo*)
	(if present
      (defparameter rij (intersection (gethash arc *ToDo*) temporal-relation))
	  (defparameter rij temporal-relation)))

		;;(write (list arc (gethash arc *ToDo*)))
		;;(write (list i j rij))

  (temporal-network arc rij)

  (extract-node *ToDo*)

  (dolist (k node)
	  (multiple-value-bind (valueki presentki) (gethash  (list (list k) i) *ToDo*)
	  (when presentki
			(setq Nki valueki)
		(multiple-value-bind (valuekj presentkj) (gethash  (list (list k) j) *ToDo*)
		(when presentkj
		    (setq Nkj valuekj)
			(setq Rkj (intersection Nkj (constraints Nki rij)))
			(if (subsetp Rkj Nkj) (temporal-network (list (list k) j) Rkj)))
		(unless presentkj
			(setq Rkj (constraints Nki rij))
			(temporal-network (list (list k) j) Rkj)))))

	  (multiple-value-bind (valuejk presentjk) (gethash  (list j (list k)) *ToDo*)
	  (when presentjk
			(setq Njk valuejk)
		(multiple-value-bind (valueik presentik) (gethash  (list i (list k)) *ToDo*)
		(when presentik
		    (setq Nik valueik)
			(setq Rik (intersection Nik (constraints rij Njk)))
			(if (subsetp Rik Nik) (temporal-network (list i (list k)) Rik)))
		(unless presentik
			(setq Rik (constraints rij Njk))
			(temporal-network (list i (list k)) Rik)))))
	)
)


	   