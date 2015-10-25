(use-package whitespace)
(global-whitespace-mode 1)


;;; 強調したい要素を指定
(setq whitespace-style '(space-mark tab-mark face spaces tabs trailing))


;;; whitespace-space を全角スペースと定義
(setq whitespace-space-regexp "\\(\u3000+\\)")


;;; 全角スペース，タブに使用する記号
(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?□] [?_ ?_])
        (tab-mark     ?\t    [?\xBB ?\t])))


;;; 各要素の face 設定
(set-face-attribute 'whitespace-space nil
                    :foreground "DeepPink"
                    :background 'unspecified)
(set-face-attribute 'whitespace-tab nil
                    :foreground "LightSkyBlue"
                    :background 'unspecified
                    :underline t)
(set-face-attribute 'whitespace-trailing nil
                    :foreground "GreenYellow"
                    :background 'unspecified
                    :underline t)


;;; ファイル保存時に行末のスペースを除去
(add-hook 'before-save-hook 'delete-trailing-whitespace)
