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
(el-get-bundle! use-package)
(el-get-bundle! with-eval-after-load-feature in tarao/with-eval-after-load-feature-el)
(el-get-bundle! auto-install)
(el-get-bundle dired+)
(el-get-bundle auto-complete)
(el-get-bundle color-theme)
(el-get-bundle helm)
(el-get-bundle helm-projectile)
(el-get-bundle helm-swoop)
(el-get-bundle helm-descbinds)
;; (el-get-bundle helm-cmd-t)
(el-get-bundle js2-mode)
(el-get-bundle monokai-theme)
(el-get-bundle open-junk-file)
(el-get-bundle suzuki/php-completion :branch "develop")
(el-get-bundle php-mode)
(el-get-bundle php-auto-yasnippets)
(el-get-bundle ac-php)
(el-get-bundle rainbow-delimiters)
(el-get-bundle recentf-ext)
(el-get-bundle undo-tree)
(el-get-bundle web-mode)
(el-get-bundle yasnippet)
(el-get-bundle smartparens)
(el-get-bundle ace-link)
(el-get-bundle elscreen)
(el-get-bundle init-loader)
(el-get-bundle which-key)
(el-get-bundle skk in ddskk)
(el-get-bundle evil)
(el-get-bundle evil-elscreen)
(el-get-bundle foreign-regexp)
(el-get-bundle sql-indent)
(el-get-bundle emacswiki:sql-complete)
(el-get-bundle emacswiki:sql-transform)
(el-get-bundle smart-newline)
(el-get-bundle auto-highlight-symbol)
(el-get-bundle projectile)
(el-get-bundle volatile-highlights)
(el-get-bundle diminish)
(el-get-bundle anzu)
(el-get-bundle comment-dwim-2)
(el-get-bundle expand-region)
(el-get-bundle dsvn)
(el-get-bundle emacswiki:eldoc-extension)
(el-get-bundle undo-tree)
(el-get-bundle undohist)
(el-get-bundle ggtags)
(el-get-bundle org-bullets)
(el-get-bundle point-undo)
(el-get-bundle json-mode)
(el-get-bundle flycheck)
(el-get-bundle flycheck-color-mode-line)
(el-get-bundle gitconfig-mode)
(el-get-bundle gitignore-mode)
(el-get-bundle git-gutter+)
(el-get-bundle git-gutter-fringe+)
(el-get-bundle magit)
(el-get-bundle migemo)
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
(el-get-bundle edwtjo/evil-org-mode
  :name evil-org
  )
(el-get-bundle neotree)
(el-get-bundle howm)

(use-package init-loader
  :config
  (with-eval-after-load-feature 'init-loader
    (setq init-loader-show-log-after-init 'error-only)
    (setq init-loader-byte-compile t)
    (init-loader-load "~/.emacs.d/inits"))
  )
