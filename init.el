
 (when (>= emacs-major-version 24)
     (require 'package)
     ;(package-initialize)
     (setq package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
		      ("melpa" . "https://melpa.org/packages/"))))
(eval-when-compile
;;;;   ;; Following line is not needed if use-package.el is in ~/.emacs.d
(add-to-list 'load-path "~/.emacs.d/lisp/")
   (require 'use-package))
;;; package --- summary:
; 关闭工具栏，tool-bar-mode 即为一个 Minor Mode
(tool-bar-mode -1)
;; 关闭菜单栏
;; 关闭文件滑动控件
(scroll-bar-mode -1)

(setq org-roam-buffer-window-parameters '((no-delete-other-windows . t)))


(setq
  display-buffer-alist
   '(("*org-roam*"
      (side . bottom))))
;; 更改光标的样式（不能生效，解决方案见第二集）
(setq-default cursor-type 'bar)
;; 默认垂直分裂
;;(setq split-height-threshold nil)
;;(setq split-width-threshold 0)


;; 关闭启动帮助画面
(setq inhibit-splash-screen 1)
(defun my/setfont ()
(when (display-graphic-p)
  ;; Set default font
  (cl-loop for font in '(
			 "JetBrainsMono Nerd Font")
           return (set-face-attribute 'default nil
				      :font font
				      :height ;(cond;((eq system-type 'darwin) 125)
                                                    ;((eq system-type 'windows-nt) 110)
                                                     200))
  ;; Specify font for all unicode characters
  (cl-loop for font in '("Symbola" "Noto Color Emoji")
           return(set-fontset-font t 'unicode font nil 'prepend))
  ;; Specify font for Chinese characters
  (cl-loop for font in '(
			 "Wenquanyi Microhei"
                         )
           return (set-fontset-font t '(#x4e00 . #x9fff) font))))
;; 更改显示字体大小 16pt
;;  (set-face-attribute 'default nil :font "WenQuanYi Zen Hei Mono" :height 160)
;; (defun set-font (english chinese english-size chinese-size)
  ;; (set-face-attribute 'default nil :font
                      ;; (format   "%s:pixelsize=%d"  english english-size))
  ;; (dolist (charset '(kana han  symbol cjk-misc bopomofo))
    ;; (set-fontset-font (frame-parameter nil 'font) charset
                      ;; (font-spec :family chinese :size chinese-size))))
;; ;;(set-font   "JetBrainsMono Nerd Font" "Sarasa Mono SC Nerd" 20 20)
 (if (and (fboundp 'daemonp) (daemonp))
    (add-hook 'after-make-frame-functions
           (lambda (frame)
         (with-selected-frame frame
 (my/setfont)))))
 ;(set-font   "JetBrainsMono Nerd Font" "Sarasa Mono SC Nerd" 20 20))
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
;; 自动括号匹配
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
;; 高亮当前行，当文本内容很多时可以很容易找到光标的位置。
(global-hl-line-mode 1)
;; 载入插件

(use-package doom-themes
  :ensure t
  :init
;;(load-theme 'doom-snazzy 1)
  )


(use-package all-the-icons
  :ensure t)

(use-package all-the-icons-dired
		   :ensure t
		   :hook ('dired-mode . 'all-the-icons-dired-mode))

(use-package hungry-delete
  :ensure t
  :defer t
  :config (hungry-delete-mode 1)
  )
;; 表情符号
(use-package emojify
  :ensure t
  :custom (emojify-emojis-dir "~/.emacs.d/emojis")
  :hook (after-init . global-emojify-mode))

;; 竖线
;; (use-package
  ;; page-break-lines
  ;; :ensure t
  ;; :hook (after-init . page-break-lines-mode)
  ;; :config (turn-on-page-break-lines-mode))

;; 启动界面
(use-package 
  dashboard 
  :ensure t
  :init
  (dashboard-setup-startup-hook)
  (dashboard-modify-heading-icons '((recents . "file-text") 
                                    (bookmarks . "book")))
  ;; 设置标题
  (setq dashboard-banner-logo-title
        "This Is My Emacs")
  ;; 设置banner
  (setq dashboard-center-content t) 
  (setq dashboard-set-heading-icons t) 
  (setq dashboard-set-file-icons t) 
  (setq dashboard-set-navigator t))

(use-package 
  doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 10)
  (doom-modeline-bar-width 3)
  (doom-modeline-buffer-file-name-style 'file-name))

(use-package 
  rainbow-delimiters 
  :ensure t 
  :defer 2
  :config
  ;; 设置每一级括号的颜色
  (set-face-foreground 'rainbow-delimiters-depth-1-face "chartreuse3") 
  (set-face-foreground 'rainbow-delimiters-depth-2-face "DodgerBlue1") 
  (set-face-foreground 'rainbow-delimiters-depth-3-face "DarkOrange2")
  (set-face-foreground 'rainbow-delimiters-depth-4-face "deep pink") 
  (set-face-foreground 'rainbow-delimiters-depth-5-face "medium orchid") 
  (set-face-foreground 'rainbow-delimiters-depth-6-face "turquoise") 
  (set-face-foreground 'rainbow-delimiters-depth-7-face "lime green") 
  (set-face-foreground 'rainbow-delimiters-depth-8-face "gold") 
  (set-face-foreground 'rainbow-delimiters-depth-9-face "cyan") 
  (set-face-bold 'rainbow-delimiters-depth-1-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-2-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-3-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-4-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-5-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-6-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-7-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-8-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-9-face "t") 
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))
;; 让info帮助信息中关键字有高亮
(use-package 
  info-colors 
  :ensure t 
  :hook ('Info-selection-hook . 'info-colors-fontify-node))

;; 缩进线
(use-package
  indent-guide
  :ensure t
  :defer t
  :hook (prog-mode . indent-guide-mode))

;; 彩虹猫进度条
;; (use-package doom-themes
;;   :ensure t
;;   :config
;;   ;; Global settings (defaults)
;;   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;         doom-themes-enable-italic t) ; if nil, italics is universally disabled
;;   (load-theme 'doom-one t)
;; 
;;   ;; Enable flashing mode-line on errors
;;   (doom-themes-visual-bell-config)
;;   
;;   ;; Enable custom neotree theme (all-the-icons must be installed!)
;;   (doom-themes-neotree-config)
;;   ;; or for treemacs users
;;   (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
;;   (doom-themes-treemacs-config)
;;   
;;   ;; Corrects (and improves) org-mode's native fontification.
;;   (doom-themes-org-config))

;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
(setq lsp-keymap-prefix "s-l")

(use-package lsp-mode
    :ensure t 
    :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
            (c-mode . lsp)
            ;; if you want which-key integration
            (lsp-mode . lsp-enable-which-key-integration))
    :commands lsp)
(use-package lsp-ui :ensure t :commands lsp-ui-mode)
;; if you are ivy user
(use-package lsp-ivy :ensure t :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :ensure t :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
(use-package dap-mode
  :ensure t)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; optional if you want which-key integration
(use-package which-key
    :config
    (which-key-mode))

;; 插件源

 (when (>= emacs-major-version 24)
     (require 'package)
     (package-initialize)
     (setq package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
		      ("melpa" . "https://melpa.org/packages/"))))

;; 注意 elpa.emacs-china.org 是 Emacs China 中文社区在国内搭建的一个 ELPA 镜像

 ;; cl - Common Lisp Extension
(use-package cl
  )

;;(use-package vterm
;;    :ensure t)


(use-package evil-leader
  :defer 2
  :ensure t
  :config
  (global-evil-leader-mode 1)
   (evil-leader/set-key
     "ff" 'recentf-open-files
     "bb" 'switch-to-buffer
     "mj" 'bookmark-jump
     "ms" 'bookmark-set
     "mS" 'bookmark-save
     "md" 'bookmark-delete
     "g"  'magit-status
     "0"  'select-window-0
     "1"  'select-window-1
     "2"  'select-window-2
     "3"  'select-window-3
     ;;  ":"  'counsel-M-x          Add Packages
     "wO" 'delete-other-windows
     )
   )

(use-package evil-magit
  :ensure t)

(use-package evil
  :config
  (evil-mode 1)
)

(use-package expand-region
  :defer t
  :bind ("C-=" . er/expand-region)
  )


(use-package flycheck
  :ensure t
  :defer 2
  :config (global-flycheck-mode))

(use-package avy
  :ensure t
  :defer t
  :bind (("M-g ;" . 'avy-goto-char)
         ("M-g '" . 'avy-goto-char-2)
         ("M-g \"" . 'avy-goto-char-timer)
         ("M-g l" . 'avy-goto-line)
         ("M-g w" . 'avy-goto-word-1)
         ("M-g e" . 'avy-goto-word-0)))
 (use-package magit
  :ensure t
  :defer t
  :commands (magit)
	)



(use-package 
  counsel-projectile 
  :ensure t 
  :hook ((counsel-mode . counsel-projectile-mode)) 
  :init (setq counsel-projectile-grep-initial-input '(ivy-thing-at-point)) 
              )
(use-package format-all
  :defer t
  :ensure t)
(defvar my/packages '(
		;; ---PackageManage
		use-package
		;; --- Auto-completion ---
		;; --- Better Editor ---
		hungry-delete
		swiper
		expand-region
		iedit
		;; --- Major Mode ---
		js2-mode
		web-mode
		;; --- Minor Mode ---
		nodejs-repl
		exec-path-from-shell
		;; ---Window---
		popwin
		;; --- Themes ---
		;;monokai-theme
	        solarized-theme
		) "Default packages")

 (setq package-selected-packages my/packages)

 (defun my/packages-installed-p ()
     (loop for pkg in my/packages
	   when (not (package-installed-p pkg)) do (return nil)
	   finally (return t)))

 (unless (my/packages-installed-p)
     (message "%s" "Refreshing package database...")
     (package-refresh-contents)
     (dolist (pkg my/packages)
       (when (not (package-installed-p pkg))
	 (package-install pkg))))
(use-package valign
  :ensure t
  :hook
  (org-mode . valign-mode))


 ;; (use-package eaf
   ;; :load-path "~/.emacs.d/site-lisp/emacs-application-framework" ; Set to "/usr/share/emacs/site-lisp/eaf" if installed from AUR
   ;; :custom
   ;; (eaf-find-alternate-file-in-dired t)
   ;; :config
   ;; (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
   ;; (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding)
   ;; (eaf-bind-key take_photo "p" eaf-camera-keybinding))

;; 启动插件
;; (global-evil-leader-mode 1)
(use-package company
  :ensure t
  :config
  (global-company-mode)
)
(use-package counsel
  :ensure t
  :commands
  (counsel-mode)
)
(use-package smartparens
  :ensure t
  :config
 (sp-local-pair '(emacs-lisp-mode lisp-interaction-mode) "'" nil :actions nil)
  (smartparens-global-mode)
)
(use-package ivy
  :ensure t
  :config
  (ivy-mode)
  )
(use-package ivy-rich
  :ensure t
  :config
  (ivy-rich-mode))
(use-package ivy-posframe
  :ensure t
  :config
   (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-center)))
   (ivy-posframe-mode 1))
(use-package which-key
  :ensure t
  :defer 2
  :config
(which-key-mode)
)
;; ---ivy---

(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; ---
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       auto-mode-alist))
;; ---which-key---
;;(use-package telega
;;  :ensure t
;;  :commands (telega)
;;  :defer t)


;; BETTERDEFAULT


;; 设置文件编码
;; ((set-charset-priority 'unicode) 
;; (setq locale-coding-system   'utf-8)    ; pretty
;; (set-terminal-coding-system  'utf-8)    ; pretty
;; (set-keyboard-coding-system  'utf-8)    ; pretty
;; (set-selection-coding-system 'utf-8)    ; please
;; (prefer-coding-system        'utf-8)    ; with sugar on top
;; (setq default-process-coding-system '(utf-8-unix . utf-8-unix))set-language-environment "UTF-8")
;; 关闭自动备份
(setq make-backup-files nil)
;; 关闭自动保存的文件
(setq auto-save-default nil)
;; Avoid #file.org# to appear
(setq create-lockfiles nil)
;; Avoid filename.ext~ to appear
;; 关闭自动换行
;; (setq truncate-partial-width-windows t)
;; 创建新行的动作
;; 回车时创建新行并且对齐
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "<escape>")      'keyboard-escape-quit)
;; 取消对齐创建的新行
(global-set-key (kbd "S-<return>") 'comment-indent-new-line)
;; Dired-mode 默认递归
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)
;; Emacsn能从剪贴板读取内容
(setq x-select-enable-clipboard t
      x-select-enable-primary t)
;; Dired-mode 只用一个buffer
(put 'dired-find-alternate-file 'disabled nil)
;; 主动加载 Dired Mode
;; (require 'dired)
;; (defined-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
;; 延迟加载
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

;; 优化'自动补全

;; 括号内时也高亮括号
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
	(t (save-excursion
	     (ignore-errors (backward-up-list))
	     (funcall fn)))))
;; 删除换行符
(defun remove-dos-eol ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

;; 开启最近浏览的文件
(use-package recentf
  :ensure t
  :defer t)
;; 选中一个区域后,输入一个字母会替代当前区域
(delete-selection-mode 1)

;; OccurMode
(defun occur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
	    (buffer-substring-no-properties
	     (region-beginning)
	     (region-end))
	  (let ((sym (thing-at-point 'symbol)))
	    (when (stringp sym)
	      (regexp-quote sym))))
	regexp-history)
  (call-interactively 'occur))
;;  (defun efs/exwm-update-class ()
;;    (exwm-workspace-rename-buffer exwm-class-name))
;; (defun my/swapescaps ()
;; (shell-command "setxkbmap -option caps:swapescape"))
;;  (use-package exwm
;;    :ensure t
;;    :config
;;    ;; Set the default number of workspaces
;;    (setq exwm-workspace-number 5)
;;  
;;    ;; When window "class" updates, use it to set the buffer name
;;    (add-hook 'exwm-update-class-hook #'efs/exwm-update-class)
;;    
;;    ;; Rebind CapsLock to Ctrl
;;    (add-hook 'exwm-init-hook #'my/swapescaps)
;;    ;; Set the screen resolution (update this to be the correct resolution for your screen!)
;;    (require 'exwm-randr)
;;    (exwm-randr-enable)
;;    ;; (start-process-shell-command "xrandr" nil "xrandr --output Virtual-1 --primary --mode 2048x1152 --pos 0x0 --rotate normal")
;;  
;;    ;; Load the system tray before exwm-init
;;    (require 'exwm-systemtray)
;;    (exwm-systemtray-enable)
;;  
;;    ;; These keys should always pass through to Emacs
;;    (setq exwm-input-prefix-keys
;;      '(?\C-x
;;        ?\C-u
;;        ?\C-h
;;        ?\M-x
;;        ?\M-`
;;        ?\M-&
;;        ?\M-:
;;        ?\C-\M-j  ;; Buffer list
;;        ?\C-\ ))  ;; Ctrl+Space
;;  
;;    ;; Ctrl+Q will enable the next key to be sent directly
;;    (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)
;;  
;;    ;; Set up global key bindings.  These always work, no matter the input state!
;;    ;; Keep in mind that changing this list after EXWM initializes has no effect.
;;    (setq exwm-input-global-keys
;;          `(
;;            ;; Reset to line-mode (C-c C-k switches to char-mode via exwm-input-release-keyboard)
;;            ([?\s-r] . exwm-reset)
;;  
;;            ;; Move between windows
;;            ([s-h] . windmove-left)
;;            ([s-l] . windmove-right)
;;            ([s-k] . windmove-up)
;;            ([s-j] . windmove-down)
;;  
;;            ;; Launch applications via shell command
;;            ([?\s-d] . (lambda (command)
;;                         (interactive (list (read-shell-command "$ ")))
;;                         (start-process-shell-command command nil command)))
;;  
;;            ;; Switch workspace
;;            ([?\s-w] . exwm-workspace-switch)
;;            ([?\s-`] . (lambda () (interactive) (exwm-workspace-switch-create 0)))
;;  
;;            ;; 's-N': Switch to certain workspace with Super (Win) plus a number key (0 - 9)
;;            ,@(mapcar (lambda (i)
;;                        `(,(kbd (format "s-%d" i)) .
;;                          (lambda ()
;;                            (interactive)
;;                            (exwm-workspace-switch-create ,i))))
;;                      (number-sequence 0 9))))
;;  
;;    (exwm-enable))
;; 

;; 将光标移动到新建的窗口

;; (use-package disable-mouse
;;   :ensure t
;;   :config
;;   (global-disable-mouse-mode))
(use-package popwin
  :ensure t
  :defer t
  :commands (popwin-mode))

(use-package nix-mode
  :ensure t
  )
(use-package pdf-tools
  :ensure t
  :bind ( :map pdf-view-mode-map
	               ("j" .  pdf-view-next-line-or-next-page)
		       ("k" .  pdf-view-previous-line-or-previous-page)
		       ("l" .  image-forward-hscroll)
		       ("h" .  image-backward-hscroll)
		       ("J" .  pdf-view-next-page)
		       ("K" .  pdf-view-previous-page)
		       ("u" .  pdf-view-scroll-down-or-previous-page)
		       ("d" .  pdf-view-scroll-up-or-next-page)
		       ("0" .  image-bol)
		       ("$" .  image-eol)
	 )
  )
(pdf-loader-install)
;; 关闭警告音量
(setq ring-bell-function 'ignore)

;; 简化yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;; Hippie补全
(setq hippie-expand-try-function-list '(try-expand-debbrev
					try-expand-debbrev-all-buffers
					try-expand-debbrev-from-kill
					try-complete-file-name-partially
					try-complete-file-name
					try-expand-all-abbrevs
					try-expand-list
					try-expand-line
					try-complete-lisp-symbol-partially
					try-complete-lisp-symbol))

;; 工作区
(use-package perspeen
  :ensure t
  :diminish 
  :init
  ;; (setq perspeen-use-tab t)
  (setq perspeen-keymap-prefix [C-tab]) 
  :config (perspeen-mode))

;; recentf



(defun my-recentf-open ()
"open recent files. In ido style if applicable --lgfang"
(interactive)
(let* ((path-table (mapcar
(lambda (x) (cons (file-name-nondirectory x) x))
recentf-list))
(file-list (mapcar (lambda (x) (file-name-nondirectory x))
recentf-list))
(complete-fun (if (require 'ido nil t)
'ido-completing-read
'completing-read))
(fname (funcall complete-fun "File Name: " file-list)))
(find-file (cdr (assoc fname path-table)))))

;(use-package rime
;  :ensure t
;  :custom
;  (default-input-method "rime")
;  (rime-user-data-dir ~/.local/share/fcitx5/rime))
(use-package yasnippet-snippets
  :ensure t
  :config
  )
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

;; 撤销树
(use-package 
  undo-tree 
  :ensure t 
  :hook (after-init . global-undo-tree-mode) 
  :init (setq undo-tree-visualizer-timestamps t undo-tree-enable-undo-in-region nil undo-tree-auto-save-history nil)

  ;; HACK: keep the diff window
  (with-no-warnings (make-variable-buffer-local 'undo-tree-visualizer-diff) 
                    (setq-default undo-tree-visualizer-diff t)))
;; 项目管理
(use-package go-translate
  :ensure t
  :config
  (setq go-translate-base-url "https://translate.google.cn")
  (setq go-translate-local-language "zh-CN")
  (global-set-key (kbd "C-c g") 'go-translate-echo-area))

(use-package youdao-dictionary
	:ensure t
	:config 
	(global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point))
(use-package 
  projectile 
  :defer t
  :ensure t)

(use-package company 
  :defer 2 
  :hook (after-init . global-company-mode) 
  :init (setq company-tooltip-align-annotations t company-idle-delay 0 company-echo-delay 0
              company-minimum-prefix-length 2 company-require-match nil company-dabbrev-ignore-case
              nil company-dabbrev-downcase nil company-show-numbers t) 
  :config 
  :bind (:map company-active-map
              ("M-n" . nil) 
              ("M-p" . nil) 
              ("C-n" . #'company-select-next) 
              ("C-p" . #'company-select-previous)) 
      ) 

;; (defun my/changeinput2en()
    ;; "this is a function automatic changing input method to en"
  ;; (interactive)
;; (if (eq major-mode 'org-mode)
  ;; (shell-command "fcitx5-remote -c")))
;; 
;; (defun my/changeinput2cn()
    ;; "this is a function automatic changing input method to en"
  ;; (interactive)
;; (if (eq major-mode 'org-mode)
  ;; (shell-command "fcitx5-remote -o")))
;; (add-hook 'evil-insert-state-entry-hook #'my/changeinput2cn)
;; (add-hook 'evil-insert-state-exit-hook #'my/changeinput2en)


;; INITORG

(use-package org
  :ensure t
  :defer 2
  :config
  (setq org-ellipsis " ▾"
        org-hide-emphasis-markers t
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 0
        org-hide-block-startup nil
        org-src-preserve-indentation nil
        org-cycle-separator-lines 2)
  )
(use-package org-ref
  :ensure t)

(setq reftex-default-bibliography '("~/Org/references.bib"))

;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "~/Org/notes.org"
      org-ref-default-bibliography '("~/Org/references.bib")
      org-ref-pdf-directory "~/Org/bibliography/bibtex-pdfs/")

(org-babel-do-load-languages
      'org-babel-load-languages
      '((emacs-lisp . t)
        (C . t)
        (java . t)
        (js . t)
        (ruby . t)
        (ditaa . t)
        (python . t)
        (shell . t)
        (latex . t)
        (plantuml . t)
        (R . t)))
;;(setcar (nthcdr 0 org-emphasis-regexp-components) " \t('\"{[:nonascii:]")
;;(setcar (nthcdr 1 org-emphasis-regexp-components) "- \t.,:!?;'\")}\\[[:nonascii:]")
;;(org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)
;;(org-element-update-syntax)
;; 规定上下标必须加 {}，否则中文使用下划线时它会以为是两个连着的下标
(setq org-use-sub-superscripts "{}")
;; (setq org-src-fontify-natively t)
(setq evil-org-set-key-theme '(navigation insert textobjects additional calendar))

(setq org-log-done 'time)
;; 设置默认 org agenda 文件目录
(setq org-agenda-files '("~/Org"))
(setq org-startup-indented t)
;; ---org-capture---
 (setq org-todo-keywords
       '((sequence "TODO(t)" "|" "DONE(d)" "MISS(m)" "CANCLE(c)")))

(defun org-hide-properties ()
  "Hide org headline's properties using overlay."
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward
              "^:PROPERTIES:\n\\(:.*:.*\n\\)+:END:" nil t)
      (overlay-put (make-overlay
                    (match-beginning 0) (match-end 0))
                   'display ""))))

(add-hook 'org-mode-hook #'org-hide-properties)
(add-hook 'org-mode-hook #'toggle-truncate-lines)

(use-package cl-lib
  :ensure t)

(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package org-download
  :after org
  :bind
  (:map org-mode-map
        (("s-Y" . org-download-screenshot)
         ("s-y" . org-download-yank))))

(use-package org-roam
      :ensure t
      :defer 30
      :hook
       (after-init . org-roam-mode)
      :custom
      (org-roam-directory "~/Org/")
      :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n t" . org-roam-dailies-today)
               ("C-c n g" . org-roam-graph-show))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))
              (("C-c n I" . org-roam-insert-immediate))))

(use-package org-roam-server
  :ensure t
  :defer t
  :config
  (setq org-roam-server-host "0.0.0.0"
        org-roam-server-port 8080
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        org-roam-server-serve-files nil
        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20))

(use-package
  org-roam-protocol
  :after org
  )

(use-package org-noter
  :ensure t
  :after org
  :config (setq org-noter-notes-search-path '("~/Org/Orgall")))
(use-package org-superstar
  :ensure t
  :hook (org-mode . org-superstar-mode)
  :config
(set-face-attribute 'org-level-4 nil :weight 'bold :height 1.0) ;\large
(set-face-attribute 'org-level-3 nil :weight 'bold :height 1.2) ;\large
(set-face-attribute 'org-level-2 nil :weight 'bold :height 1.44) ;\Large
(set-face-attribute 'org-level-1 nil :weight 'bold :height 1.728)
  (setq org-superstar-item-bullet-alist '((?- . ?⁍)))
  (setq org-superstar-headline-bullets-list
  '("☺" "◎" "○" "●"))
  )


(defun +org/opened-buffer-files ()
  "Return the list of files currently opened in emacs"
  (delq nil
        (mapcar (lambda (x)
                  (if (and (buffer-file-name x)
                           (string-match "\\.org$"
                                         (buffer-file-name x)))
                      (buffer-file-name x)))
                (buffer-list))))

(setq org-refile-targets '((+org/opened-buffer-files :maxlevel . 1)))
(setq org-refile-use-outline-path 'file)
;; makes org-refile outline working with helm/ivy
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-allow-creating-parent-nodes 'confirm)

(defun my/changeinto-roam-link ()
    "changeinto-Org-roam link."
    (interactive)
    (backward-kill-word 1)
    (my/insert-roam-link)
    (yank 1))
(defun my/insert-roam-link ()
    "Inserts an Org-roam link."
    (interactive)
    (insert "[[roam:]]")
    (backward-char 2))

(defun my/auto-highlighting ()
    "auto-highlighting"
    (interactive)
    (backward-word)
    (insert "~")
    (forward-word)
    (insert "~")
    (forward-char 1))

(defun my/auto-strikethrough()
    "auto-highlighting"
    (interactive)
    (backward-word)
    (insert "+")
    (forward-word)
    (insert "+")
    (forward-char 1))

(defun my/auto-bold()
    "auto-highlighting"
    (interactive)
    (backward-word)
    (insert "*")
    (forward-word)
    (insert "*")
    (forward-char 1))

(defun my/auto-underline()
    "auto-underline"
    (interactive)
    (backward-word)
    (insert "_")
    (forward-word)
    (insert "_")
    (forward-char 1))

(defun my/auto-rice-English-Word ()
    "auto-rice-English-Word."
    (interactive)
    (backward-kill-word 1)
    (my/insert-roam-link)
    (yank 1)
    (let* ((title (current-word)) )
      (unless (member title (org-roam--get-titles))
      (let ((org-roam-capture--info (list (cons 'title title)
					  (cons 'slug (funcall org-roam-title-to-slug-function title))))
            (org-roam-capture--context 'title)
	    (org-file-path (concat "~/Org/Orgall/" (format-time-string "%Y%m%d%H") "-" (funcall org-roam-title-to-slug-function title) ".org")))
	    (condition-case err
		(org-roam-capture--capture nil "y")
                 (error (user-error "%s.  Please adjust `org-roam-capture-templates'"
                           (error-message-string err))))
      (youdao-dictionary-search-at-point)
      (with-current-buffer  "*Youdao Dictionary*"
	(write-region nil nil org-file-path t))))
      
      )
    (forward-char 2))


(use-package deft
  :ensure t
  :defer t
  :bind ("<f8>" . deft)
  :commands (deft)
  :config (setq deft-directory "~/Org"
		deft-recursive t
                deft-extensions '("md" "org")))



;; KEYBINDING

;; aya-snippet
;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上
(global-set-key (kbd "<f2>") 'open-init-file)

;; evil
(setcdr evil-insert-state-map nil)
(define-key evil-insert-state-map [escape] 'evil-normal-state)
(define-key evil-normal-state-map (kbd "RET") 'org-open-at-point)
(define-key evil-normal-state-map (kbd "DEL") 'org-mark-ring-goto)
(define-key evil-normal-state-map (kbd "Q") 'kill-buffer-and-window)
(define-key evil-normal-state-map (kbd "S") 'save-buffer)
(define-key evil-insert-state-map (kbd "M-[") #'my/insert-roam-link)
(define-key evil-insert-state-map (kbd "M-]") #'my/changeinto-roam-link)
(define-key evil-insert-state-map (kbd "M-}") #'my/auto-rice-English-Word)
(define-key evil-insert-state-map (kbd "M-~") #'my/auto-highlighting)
(define-key evil-insert-state-map (kbd "M-*") #'my/auto-bold)
(define-key evil-insert-state-map (kbd "M-+") #'my/auto-strikethrough)
(define-key evil-insert-state-map (kbd "M-_") #'my/auto-underline)




;;;; evil-leader
;;(evil-leader/set-key
;;  "ff" 'find-file
;;  "bb" 'switch-to-buffer
;;  "0"  'select-window-0
;;  "1"  'select-window-1
;;  "2"  'select-window-2
;;  "3"  'select-window-3
;;  ":"  'counsel-M-x
;;  "wO" 'delete-other-windows
;;  )
;; Hippie 补全
(global-set-key (kbd "s-/") 'hippie-expand)

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c L") 'org-insert-link)
;; 设置 org-agenda 打开快捷键
(global-set-key (kbd "C-c a") 'org-agenda)
;; org-capture
(global-set-key (kbd "C-c r") 'org-capture)

;; expand-region
;; (global-set-key (kbd "C-=") 'er/expand-region)
;; company
;; (with-eval-after-load 'company
  ;; (define-key company-active-map (kbd "M-n") nil)
  ;; (define-key company-active-map (kbd "M-p") nil)
  ;; (define-key company-active-map (kbd "C-n") #'company-select-next)
  ;; (define-key company-active-map (kbd "C-p") #'company-select-previous))
;; occurmode
(global-set-key (kbd "M-s o") 'occur-dwim)

;; iedit
(global-set-key (kbd "M-s e") 'iedit-mode)
;; imenu
(global-set-key (kbd "M-s i") 'counsel-imenu)
;; ivy
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c c-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x c-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "C-c r") 'counsel-rg)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-s-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
;; recentf
(define-key global-map [f5] 'my-recentf-open)





;; Custom

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-begin-commands
   '(self-insert-command org-self-insert-command orgtbl-self-insert-command c-scope-operator c-electric-colon c-electric-lt-gt c-electric-slash))
 '(company-minimum-prefix-length 2)
 '(custom-enabled-themes '(doom-snazzy))
 '(custom-safe-themes
   '("c83c095dd01cde64b631fb0fe5980587deec3834dc55144a6e78ff91ebc80b19" "7b3d184d2955990e4df1162aeff6bfb4e1c3e822368f0359e15e2974235d9fa8" "71e5acf6053215f553036482f3340a5445aee364fb2e292c70d9175fb0cc8af7" "a3b6a3708c6692674196266aad1cb19188a6da7b4f961e1369a68f06577afa16" "21055a064d6d673f666baaed35a69519841134829982cbbb76960575f43424db" "e1ef2d5b8091f4953fe17b4ca3dd143d476c106e221d92ded38614266cea3c8b" "c4bdbbd52c8e07112d1bfd00fee22bf0f25e727e95623ecb20c4fa098b74c1bd" "37144b437478e4c235824f0e94afa740ee2c7d16952e69ac3c5ed4352209eefb" "c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "0fffa9669425ff140ff2ae8568c7719705ef33b7a927a0ba7c5e2ffcfac09b75" "2c613514f52fb56d34d00cc074fe6b5f4769b4b7f0cc12d22787808addcef12c" "c0a0c2f40c110b5b212eb4f2dad6ac9cac07eb70380631151fa75556b0100063" "dde8c620311ea241c0b490af8e6f570fdd3b941d7bc209e55cd87884eb733b0e" "5d09b4ad5649fea40249dd937eaaa8f8a229db1cec9a1a0ef0de3ccf63523014" "9efb2d10bfb38fe7cd4586afb3e644d082cbcdb7435f3d1e8dd9413cbe5e61fc" "2f1518e906a8b60fac943d02ad415f1d8b3933a5a7f75e307e6e9a26ef5bf570" "99ea831ca79a916f1bd789de366b639d09811501e8c092c85b2cb7d697777f93" "3325e2c49c8cc81a8cc94b0d57f1975e6562858db5de840b03338529c64f58d1" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" "13a8eaddb003fd0d561096e11e1a91b029d3c9d64554f8e897b2513dbf14b277" "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" default))
 '(evil-leader/in-all-states t)
 '(evil-leader/leader "SPC")
 '(evil-undo-system 'undo-tree)
 '(org-roam-buffer-width 0.2)
 '(org-roam-capture-templates
   '(("d" "default" plain #'org-roam-capture--get-point :file-name "~/Org/Orgall/%<%Y%m%d%H>-${slug}" :head "#+title: ${title}" :unnarrowed t :jump-to-captured t :immediate-finish t)
     ("b" "病" entry #'org-roam--capture-get-point "
* 要点
* 定义%?
* 病因
* 分类
* 症状
* 体征
* 病理
* 实验室检查检验
* 病理生理机制
* 分级
* 治疗
* 诊断
* 预后" :file-name "~/Org/Orgall/%<%Y%m%d%H>-${slug}" :head "#+title: ${title}
#+roam_tags:病
" :immediate-finish t :unnarrowed t)
     ("y" "英语单词" entry #'org-roam--capture-get-point "
* 定义
  %?" :file-name "~/Org/Orgall/%<%Y%m%d%H>-${slug}" :head "#+title: ${title}
#+roam_tags:英语单词
" :immediate-finish t :unnarrowed t)
     ("m" "名词解释" entry #'org-roam--capture-get-point "
* 定义
  %?" :file-name "~/Org/Orgall/%<%Y%m%d%H>-${slug}" :head "#+title: ${title}
#+roam_tags:名词解释
" :immediate-finish t :unnarrowed t)
     ("j" "简答题" entry #'org-roam--capture-get-point "
* 答 
  %?" :file-name "~/Org/Orgall/%<%Y%m%d%H>-${slug}" :head "#+title: ${title}
#+roam_tags:简答题
" :immediate-finish t :unnarrowed t)))
 '(org-roam-completion-everywhere t)
 '(org-roam-completion-system 'default)
 '(org-roam-dailies-capture-templates
   '(("d" "daily" plain #'org-roam-capture--get-point "" :immediate-finish t :file-name "~/Org/Orgall/%<%Y-%m-%d>" :head "#+title: %<%Y-%m-%d>")))
 '(org-roam-db-update-idle-seconds 2)
 '(org-roam-enable-headline-linking t)
 '(package-selected-packages
   '(org-download lsp-ivy lsp-latex lsp-ui lsp-treemacs dap-mode lsp-mode cl-generic cl-lib ## ayu-theme dashboard doom-modeline doom-themes emojify indent-guide info-colors nyan-mode page-break-lines rainbow-delimiters all-the-icons-dired mood-line all-the-icons org-super-agenda use-package company hungry-delete swiper counsel expand-region iedit auto-yasnippet evil evil-leader window-numbering evil-surround js2-mode which-key web-mode nodejs-repl exec-path-from-shell popwin solarized-theme))
 '(pdf-tools-enabled-modes
   '(pdf-history-minor-mode pdf-isearch-minor-mode pdf-links-minor-mode pdf-misc-minor-mode pdf-outline-minor-mode pdf-misc-size-indication-minor-mode pdf-misc-menu-bar-minor-mode pdf-annot-minor-mode pdf-sync-minor-mode pdf-misc-context-menu-minor-mode pdf-cache-prefetch-minor-mode pdf-occur-global-minor-mode pdf-virtual-global-minor-mode))
 '(rime-posframe-properties
   '(:background-color "#333333" :foreground-color "#dcdccc" :font "WenQuanYi Micro Hei" :internal-border-width 10)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-warning ((t (:inherit nil :underline nil)))))
