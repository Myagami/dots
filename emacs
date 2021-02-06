;;server

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.


(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;;(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") 
(package-initialize)

;;share windows clipboard

;;load-path
;;;emacs
;;(setq load-path (cons "/home/karen/.emacs.d/" load-path))
(setq load-path (cons "/home/karen/.emacs.d/elisp/" load-path))
(setq load-path (cons "/home/karen/.emacs.d/elpa/" load-path))

;;tabstops
(setq-default tab-width 4)
(setq default-tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
                      64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))

;;cask
;;(require 'cask "/home/karen/.cask/cask.el")
;;(cask-initialize)

(setq create-lockfiles nil)

;;Fonts
;; (set-face-attribute 'default nil
;; 		    :family "Monaco"
;; 		    :height 110)
;; (set-fontset-font "fontset-default"
;; 		  '("Ricty Diminished" . "iso10646-1"))
;; (set-fontset-font "fontset-default"
;; 		  'katakana-jisx0201
;; 		  '("Ricty Diminished" . "iso10646-1"))
(add-to-list 'default-frame-alist '(font . "Monaco-13"))

(setq display-time-day-and-date t)
(setq display-time-24hr-format t)
(display-time-mode t)

;;Not use MenuBar and Tool Bar
(menu-bar-mode 0)
;(tool-bar-mode 0)

;; Use System Locate
(set-locale-environment nil)
(load-theme 'deeper-blue t)

;;keys
;;Top / End
(global-set-key (kbd "C-;")  'beginning-of-buffer)
(global-set-key (kbd "C-h")  'delete-backward-char)
(global-set-key (kbd "C-:")  'end-of-buffer)

;;comment
(global-set-key "\C-c;" 'comment-region)
(global-set-key "\C-c:" 'uncomment-region)

;;backspace use C-h
(keyboard-translate ?\C-h ?\C-?)
;; Line top push C-k All Delete
(setq kill-whole-line t)
;;share clipboard
;;(setq x-select-enable-clipboard t)
;;(global-set-key "\C-y" 'x-clipboard-yank)

;;revert
(global-set-key (kbd "C-x r") 'revert-buffer)

;;スタートアップは表示しない
(setq inhibit-startup-screen t)
;;scratchバッファのデフォのメッセージを出さない
(setq initial-scratch-message "")

;;強調表示
(show-paren-mode t)
;;(setq show-paren-style 'expression)
;; ミニバッファの履歴を保存する
(savehist-mode 1)

;; ミニバッファの履歴の保存数を増やす
(setq history-length 3000)

;; yes or noをy or n
(fset 'yes-or-no-p 'y-or-n-p)

;; Line top push C-k All Delete
(setq kill-whole-line t)

;;swap
(setq backup-directory-alist
  (cons (cons ".*" (expand-file-name "/home/karen/.emacs.d/backup"))
        backup-directory-alist))


(setq auto-save-file-name-transforms
  `((".*", (expand-file-name "/home/karen/.emacs.d/backup/") t)))

;;highlight
(show-paren-mode t)

;;history
(require 'recentf)
(recentf-mode 1)
(global-set-key (kbd "C-c t") 'helm-recentf)

(setq recentf-max-saved-items 2000) ;; 2000ファイルまで履歴保存する
(setq recentf-auto-cleanup 'never)  ;; 存在しないファイルは消さない
(setq recentf-exclude '("/recentf" "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" "/\\.emacs\\.d/\\.cask/" ".png"))
(setq recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list))

;;junkfile
(setq open-junk-file-format "/home/karen/Works/junk/%Y/%m/%Y-%m-%d-%H%M%S.")
(global-set-key (kbd "C-x j") 'open-junk-file)

;;(set-face-attribute 'default nil :family "Ricty Diminished" :height 120)

;; Close all buffers
(require 'cl)
(defun close-all-buffers ()
  (interactive)
  (loop for buffer being the buffers
     do (kill-buffer buffer)))
(global-set-key (kbd "C-c C-w") 'close-all-buffers)
;;loadfile
(global-set-key (kbd "<f12>") 'load-file )

;;resize
(defun my-window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        action c)
    (catch 'end-flag
      (while t
        (setq action
              (read-key-sequence-vector (format "size[%dx%d]"
                                                (window-width)
                                                (window-height))))
        (setq c (aref action 0))
        (cond ((= c ?f)
               (enlarge-window-horizontally dx))
              ((= c ?b)
               (shrink-window-horizontally dx))
              ((= c ?n)
               (enlarge-window dy))
              ((= c ?p)
               (shrink-window dy))
              ;; otherwise
              (t
               (let ((last-command-char (aref action 0))
                     (command (key-binding action)))
                 (when command
                   (call-interactively command)))
               (message "Quit")
               (throw 'end-flag t)))))))
(global-set-key (kbd "C-c C-e") 'my-window-resizer)


;;buffer name
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;;Window move
(global-set-key (kbd "C-c b")  'windmove-left)
(global-set-key (kbd "C-c n")  'windmove-down)
(global-set-key (kbd "C-c p")    'windmove-up)
(global-set-key (kbd "C-c f") 'windmove-right)

;;; フォルダを開く時, 新しいバッファを作成しない
;; バッファを作成したい時にはoやC-u ^を利用する
(defvar my-dired-before-buffer nil)
(defadvice dired-advertised-find-file
  (before kill-dired-buffer activate)
  (setq my-dired-before-buffer (current-buffer)))

(defadvice dired-advertised-find-file
  (after kill-dired-buffer-after activate)
  (if (eq major-mode 'dired-mode)
      (kill-buffer my-dired-before-buffer)))

(defadvice dired-up-directory
  (before kill-up-dired-buffer activate)
  (setq my-dired-before-buffer (current-buffer)))

(defadvice dired-up-directory
  (after kill-up-dired-buffer-after activate)
  (if (eq major-mode 'dired-mode)
      (kill-buffer my-dired-before-buffer)))
(ffap-bindings)

;;elscreen
(require 'elscreen)
(elscreen-start)
(setq elscreen-prefix-key "\C-z")
(setq elscreen-display-tab nil)
(cond 
 (window-system
       (setq x-select-enable-clipboard t)
       )
 )


;;exit save buffer
(add-hook 'kill-emacs-hook 'frame-size-save); Emacs終了時
(add-hook 'window-setup-hook 'frame-size-resume); Emacs起動時
(defun frame-size-save ()
  (set-buffer
   (find-file-noselect (expand-file-name "/home/karen/.emacs.d/.framesize")))
  (erase-buffer)
  (insert (concat
           "(set-frame-width (selected-frame) "
           (int-to-string (frame-width))
           ") (set-frame-height (selected-frame) "
           (int-to-string (frame-height))
           ")"))
  (save-buffer)
  (kill-buffer))
(defun frame-size-resume ()
  (let* ((file "/home/karen/.emacs.d/.framesize"))
    (if (file-exists-p file)
        (load-file file))))

(require 'helm) 
(helm-mode 1) 
;;helm
(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)

;; キーバインド
;;(define-key global-map (kbd "C-x b")   'helm-buffers-list)
;;(define-key global-map (kbd "C-x b") 'helm-for-files)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "M-x")     'helm-M-x)
(define-key global-map (kbd "M-y")     'helm-show-kill-ring)

;; -------------------------------------------------------------------------
;; @multiple-cursors.el
;;
(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-M->") 'mc/skip-to-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;;Server用
;;(global-set-key (kbd "C-x C-c") 'server-edit) ;emacs休止
(defalias 'exit 'save-buffers-kill-emacs) ;M-x exit で emacs終了
;;markdown
(global-set-key (kbd "C-c r") 'markdown-preview-mode)

;;(require 'mozc)
;;(setq default-input-method "japanese-mozc")
;;(setq mozc-candidate-style 'overlay)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(open-junk-file csv-mode markdown-preview-mode markdown-mode neotree multiple-cursors helm elscreen))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;not using beep sound
(setq visible-bell t)

;;not create lockfile
(setq backup-inhibited t) ;; バックアップ禁止
(auto-save-mode nil)      ;; 自動保存しない
(make-local-variable 'create-lockfiles) ;; ロックファイルを作成しない

;;text-code
(set-default-coding-systems 'utf-8-unix) ; デフォルトの文字コード

;;replace-str
(global-set-key (kbd "C-c m") 'replace-string)


;;region replace
(setq transient-mark-mode t)

;;background
(set-face-background 'default "#101010")
