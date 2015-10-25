(cua-mode t)
(setq cua-enable-cua-keys nil) ; �f�t�H���g�L�[�o�C���h�𖳌���
;; (define-key global-map (kbd "C-,") 'cua-set-rectangle-mark)

(defadvice cua-sequence-rectangle (around my-cua-sequence-rectangle activate)
  "�A�Ԃ�}������Ƃ��A���̂Ƃ���̕������㏑�����Ȃ��ō��ɂ��炷"
  (interactive
   (list (if current-prefix-arg
             (prefix-numeric-value current-prefix-arg)
           (string-to-number
            (read-string "Start value: (0) " nil nil "0")))
         (string-to-number
          (read-string "Increment: (1) " nil nil "1"))
         (read-string (concat "Format: (" cua--rectangle-seq-format ") "))))
  (if (= (length format) 0)
      (setq format cua--rectangle-seq-format)
    (setq cua--rectangle-seq-format format))
  (cua--rectangle-operation 'clear nil t 1 nil
     '(lambda (s e l r)
         (kill-region s e)
         (insert (format format first))
         (yank)
         (setq first (+ first incr)))))
