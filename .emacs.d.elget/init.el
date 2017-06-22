
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(let ((versioned-dir (locate-user-emacs-file emacs-version)))
  (setq el-get-dir (expand-file-name "el-get" versioned-dir)
	        package-user-dir (expand-file-name "elpa" versioned-dir)))

(add-to-list 'load-path (expand-file-name (format "%s/el-get" el-get-dir)))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;; ------------------------------
;; Packages
;; ------------------------------
(el-get-bundle! with-eval-after-load-feature in tarao/with-eval-after-load-feature-el)
(el-get-bundle! auto-install)
(el-get-bundle evil)
(el-get-bundle skk in ddskk)
(el-get-bundle diminish)
(el-get-bundle dired+)
(el-get-bundle ag)
(el-get-bundle auto-complete)
(el-get-bundle anzu)
(el-get-bundle bind-key)
(el-get-bundle coffee-mode)
(el-get-bundle color-theme)
(el-get-bundle elscreen)
(el-get-bundle emmet-mode)
(el-get-bundle evil-leader)
(el-get-bundle evil-indent-textobject)
(el-get-bundle evil-visualstar)
(el-get-bundle evil-exchange)
(el-get-bundle evil-surround)
(el-get-bundle evil-matchit)
(el-get-bundle evil-nerd-commenter)
(el-get-bundle evil-search-highlight-persist)
(el-get-bundle evil-numbers)
(el-get-bundle evil-args)
(el-get-bundle evil-jumper)
(el-get-bundle evil-elscreen)
(el-get-bundle edwtjo/evil-org-mode)
(el-get-bundle neotree)
(el-get-bundle expand-region)
(el-get-bundle f)
(el-get-bundle git-gutter)
(el-get-bundle helm)
(el-get-bundle helm-ag)
(el-get-bundle helm-bm)
(el-get-bundle helm-gtags)
(el-get-bundle emacs-jp/helm-migemo)
(el-get-bundle helm-projectile)
(el-get-bundle helm-swoop)
(el-get-bundle hlinum)
(el-get-bundle isearch-dabbrev)
(el-get-bundle js2-mode)
(el-get-bundle json-mode)
(el-get-bundle jump)
(el-get-bundle magit)
(el-get-bundle markdown-mode)
(el-get-bundle migemo)
(el-get-bundle monokai-theme)
(el-get-bundle open-junk-file)
(el-get-bundle suzuki/php-completion :branch "develop")
(el-get-bundle php-eldoc)
(el-get-bundle php-mode)
(el-get-bundle php-auto-yasnippets)
(el-get-bundle popup)
(el-get-bundle popwin)
(el-get-bundle projectile)
(el-get-bundle rainbow-delimiters)
(el-get-bundle recentf-ext)
(el-get-bundle redo+)
(el-get-bundle s)
(el-get-bundle smart-newline)
(el-get-bundle smartparens)
(el-get-bundle smartrep)
(el-get-bundle smartchr)
(el-get-bundle smooth-scroll)
(el-get-bundle sql-indent)
(el-get-bundle emacswiki:sql-complete)
(el-get-bundle emacswiki:sql-transform)
(el-get-bundle stripe-buffer)
(el-get-bundle undo-tree)
(el-get-bundle undohist)
(el-get-bundle use-package)
(el-get-bundle visual-regexp)
(el-get-bundle volatile-highlights)
(el-get-bundle web-mode)
(el-get-bundle yascroll)
(el-get-bundle yasnippet)
(el-get-bundle zlc)
(el-get-bundle which-key)
(el-get-bundle flycheck)
(el-get-bundle flycheck-color-mode-line)
(el-get-bundle leoliu/ggtags)
(el-get-bundle! init-loader
  (with-eval-after-load-feature 'init-loader
    (setq init-loader-show-log-after-init 'error-only)
    (setq init-loader-byte-compile t)
      (init-loader-load "~/.emacs.d/inits")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-replace-to-string-separator " => ")
 '(anzu-search-threshold 1000)
 '(helm-gtags-auto-update t)
 '(helm-gtags-ignore-case t)
 '(helm-gtags-path-style (quote relative))
 '(package-selected-packages (quote (php-auto-yasnippets))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
