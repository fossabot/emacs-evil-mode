;; Always able to answer 'y' instead of 'yes'
(defalias 'yes-or-no-p 'y-or-n-p)
(setq-default indent-tabs-mode nil)

(require 'fringe)

(require 'org)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)
(setq org-log-done t)

(global-set-key "\C-cv" 'revert-buffer)
(global-set-key (kbd "C-x g") 'magit-status)
;; (global-linum-mode 1)
(setq-default evil-escape-delay 0.2)
(setq-default evil-escape-key-sequence "jk")
(setq evil-want-C-i-jump nil) ;; makes tab work in org mode
(setq evil-collection-outline-bind-tab-p nil) ;; don't set shift-tab to show-all in orgmode
(setq evil-want-integration nil)
(require 'evil)
(evil-mode 1)

;; hitting C-x C-s puts you into normal mode
(add-hook 'after-save-hook 'evil-normal-state)
(evil-escape-mode 1)
(evil-collection-init)

;; (require 'evil-org)
;; (add-hook 'org-mode-hook 'evil-org-mode)
;; (evil-org-set-key-theme '(navigation insert textobjects additional calendar))
;; (require 'evil-org-agenda)
;; (evil-org-agenda-set-keys)

(add-hook 'markdown-mode-hook 'darkroom-mode)

(require 'evil-surround)
(global-evil-surround-mode 1)


(require 'navigate)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(require 'projectile-rails)
(projectile-rails-global-mode)

;; line-wrapping everywhere
(global-visual-line-mode t)

;; delete trailing whitespace before saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; ruby
;; don't insert a magic "coding: utf-8" comment at the top of every file
(setq ruby-insert-encoding-magic-comment nil)
;; rubocop
(require 'rubocop)
(add-hook 'ruby-mode-hook 'rubocop-mode)

;; make underscores count as words
;; For python
(add-hook 'python-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
;; For ruby
(add-hook 'ruby-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
;; For Javascript
(add-hook 'js2-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))

(require 'haml-mode)

;; JS
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; Coffeescript
(require 'coffee-mode)
;; This gives you a tab of 2 spaces
(custom-set-variables '(coffee-tab-width 2))

;; YAML
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;; Use OS X copy/paste buffers
(xclip-mode 1)

;; turn off beeping
(setq ring-bell-function 'ignore)
;; Make backup (foo~) files in ~/.emacs-saves
(setq backup-directory-alist `(("." . "~/.emacs-saves")))
;; Slow but safe
(setq backup-by-copying t)
;; keep more than one backup of each file
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

;; turn off icons and menu at the top of the window
(tool-bar-mode -1)
(menu-bar-mode -1)

(setq initial-scratch-message "")
(setq initial-major-mode 'text-mode)

;; enable electric-pair-mode in all buffers, and
;; turn on pairing for double-quotes and back-ticks
;; to turn on single-quotes, add this line:
;; (?\"' . ?\')
(electric-pair-mode t)
(setq electric-pair-pairs '(
                            (?` . ?`)
                            (?\" . ?\")
                            ) )


;; type C-\ to go into "latin-postfix" mode. This allows you to type a" and get ä or a` => à or a' => á. C-\ to get back out
(setq default-input-method 'latin-postfix)

;; bindings for the move-text package
;; these two lines are necessary before defining meta-down or meta-up
;; https://stackoverflow.com/questions/4351044/binding-m-up-m-down-in-emacs-23-1-1
;; (define-key input-decode-map "\e\eOA" [(meta up)])
;; (define-key input-decode-map "\e\eOB" [(meta down)])
;; (global-set-key [(meta up)] 'move-text-up)
;; (global-set-key [(meta down)] 'move-text-down)
;; (global-set-key (kbd "<M-up>") 'move-text-up)
;; (global-set-key (kbd "<M-down>") 'move-text-down)

;; I think only these last two are actually required
(global-set-key (kbd "ESC <up>") 'move-text-up)
(global-set-key (kbd "ESC <down>") 'move-text-down)

(load (concat user-emacs-directory "work-logs.el"))
(load (concat user-emacs-directory "fanfic.el"))
(load (concat user-emacs-directory "pry.el"))
(load (concat user-emacs-directory "navigation.el"))
(load (concat user-emacs-directory "org-mode-mappings.el"))

;; make sentence motion work with single-space sentences
(setf sentence-end-double-space nil)

(global-flycheck-mode)
(setq-default flycheck-indication-mode 'left-fringe)

;; brew install aspell first
(setq ispell-program-name "/usr/local/bin/aspell")
(setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_GB"))
;; Use M-$ to spell-check a word

(require 'darkroom)
;; (add-hook 'darkroom-mode-hook (lambda () (make-variable-buffer-local 'default-input-method) (setq default-input-method 'latin-postfix)))
(add-hook 'darkroom-mode-hook 'flyspell-mode)

(global-set-key (kbd "M-=") 'count-words)

;; web-mode setup
;; (require 'web-mode)
;; (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; https://stackoverflow.com/questions/3669511/the-function-to-show-current-files-full-path-in-mini-buffer
(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

(global-set-key (kbd "C-c f f") 'show-file-name) ; Or any other key you want

(setq inhibit-splash-screen t)
(open-latest-log)
