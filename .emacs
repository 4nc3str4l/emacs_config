;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(inhibit-startup-screen t)
 '(package-selected-packages (quote (company ace-window ##))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Disable all top bars
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1) 

;; Split window in 2
(split-window-right)

;; Company mode for every buffer
(add-hook 'after-init-hook 'global-company-mode)

;; Ctr + space to begin completion with company mode
(global-set-key (kbd "C-SPC") 'company-complete)

;; Ctr + s = save buffer
(global-set-key "\C-s" 'save-buffer)

;; Ctr + c copy selection
(global-set-key "\C-c" 'copy-region-as-kill)

;; Ctr + v paste selection
(global-set-key "\C-v" 'yank)

;; Ctr + z undo region
(global-set-key "\C-z" 'undo)
		      
;; Ctr + f find
(global-set-key "\C-f" 'search-forward)

;; Ctr + F4 kill buffer and window
(global-set-key [C-f4] 'quit-window)

;; Ctr + G go to lone
(global-set-key "\C-g" 'goto-line)

;; Ctr + A go to lone
(global-set-key "\C-a" 'mark-whole-buffer)

;; window movement
(global-set-key [C-right] 'windmove-right)
(global-set-key [C-left] 'windmove-left)
(global-set-key [C-up] 'windmove-up)
(global-set-key [C-down] 'windmove-down)

;; open recent file
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; Move lines up and down using m
(defun move-text-internal (arg)
   (cond
    ((and mark-active transient-mark-mode)
     (if (> (point) (mark))
            (exchange-point-and-mark))
     (let ((column (current-column))
              (text (delete-and-extract-region (point) (mark))))
       (forward-line arg)
       (move-to-column column t)
       (set-mark (point))
       (insert text)
       (exchange-point-and-mark)
       (setq deactivate-mark nil)))
    (t
     (beginning-of-line)
     (when (or (> arg 0) (not (bobp)))
       (forward-line)
       (when (or (< arg 0) (not (eobp)))
            (transpose-lines arg))
       (forward-line -1)))))

(defun move-text-down (arg)
   "Move region (transient-mark-mode active) or current line
  arg lines down."
   (interactive "*p")
   (move-text-internal arg))

(defun move-text-up (arg)
   "Move region (transient-mark-mode active) or current line
  arg lines up."
   (interactive "*p")
   (move-text-internal (- arg)))

(global-set-key [\M-up] 'move-text-up)
(global-set-key [\M-down] 'move-text-down)

;; Buffer indentation
(defun indent-buffer ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))
(global-set-key [f12] 'indent-buffer)
