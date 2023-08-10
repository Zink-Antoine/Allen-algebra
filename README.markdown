# Allen-Algebra

a small implementation of Allen's (1983) time interval algebra in LISP  

## Usage

Function *temporal-network*  

Syntax  
(temporal-network '((node1) (node2)) '(rel1 rel2 ...))  

Description  
create a new temporal network or add new temporal relations between two nodes

Function *update-temporal-network*  

Syntax  
(update-temporal-network '((node1) (node2)) '(rel1 rel2 ...))  

Description  
add new temporal relations between two nodes and up date the temporal network 

function *pretty-hash-table*  

Syntax  
(pretty-hash-table \*hash-table\*)  

Description  
Displays all arcs of the temporal network, and their temporal relationships 

## Installation

    (ql:quickload "allen-algebra")  
    (use-package :allen-algebra)

    (in-package :allen-algebra)

The :allen-algebra package uses Graphviz dot for graphics output. for this purpose it depends of the following packages  

- graph

- graph/matrix

- graph/dot
