(defun reverse-list (list)
  (let (result)
    (dolist (cur list result)
      (setq result (cons cur result)))))


(defun content-reverse-lines (content)
  (setq lines (split-string content "\n"))
  (string-join (reverse-list lines) "\n"))

(defun content-to-upper-case (content)
    "Preprocess content before output."
  (upcase content))

(defun process-and-print (file-path processing-function)
  "Print processed contents of a file in a new buffer"
  (with-temp-buffer
    (insert-file-contents file-path)
    (let ((file-content (buffer-string)))
      (setq file-content (funcall processing-function file-content))
      (with-current-buffer (get-buffer-create "*Processing result*")
        (erase-buffer)
        (insert file-content)
        (pop-to-buffer-same-window (current-buffer))))))
;;        (pop-to-buffer (current-buffer))))))

(defun process-buffer-contents (processing-function)
  (setq file-path (buffer-file-name))
  (if file-path
       (message file-path)
     (message "Buffer is not associated with file!"))
  (process-and-print file-path processing-function))

(defun buffer-to-uppercase ()
  "Turn buffer content to UPPERCASE"
  (interactive)
  (process-buffer-contents 'content-to-upper-case))

(defun buffer-reverse-lines ()
  (interactive)
  (process-buffer-contents 'content-reverse-lines))


(global-set-key (kbd "C-c U") 'buffer-to-uppercase)
(global-set-key (kbd "C-c R") 'buffer-reverse-lines)
