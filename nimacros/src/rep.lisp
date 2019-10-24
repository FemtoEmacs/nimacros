(defmacro itr(ixx c1xx c2xx &rest body)
  `(loop for ,ixx from ,c1xx to ,c2xx do 
         (format t "~a- " ,ixx) ,@body))

(itr i 0 3 (format t "Hello, world~%") 
	 (format t "End~%"))


