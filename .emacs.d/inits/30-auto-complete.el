(use-package auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'text-mode)
(add-to-list 'ac-modes 'fundamental-mode)
(add-to-list 'ac-modes 'org-mode)
(add-to-list 'ac-modes 'sql-mode)
(add-to-list 'ac-modes 'sql-interactive-mode)

(ac-set-trigger-key "TAB")
(setq ac-use-menu-map t)       ;; 補完メニュー表示時にC-n/C-pで補完候補選択
(setq ac-use-comphist t)
(setq ac-use-fuzzy t)          ;; 曖昧マッチ
(setq ac-delay 0.1) ; auto-completeまでの時間
(setq ac-auto-show-menu 0.2) ; メニューが表示されるまで
(setq ac-menu-height 20)

(setq ac-sources '(ac-source-filename
                   ac-source-functions
                   ac-source-variables
                   ac-source-symbols
                   ac-source-abbrev
                   ac-source-words-in-same-mode-buffers
                   ac-source-dictionary))

(defun ac-quick-help-force ()
  (interactive)
  (ac-quick-help t))
