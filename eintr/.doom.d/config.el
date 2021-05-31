;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Eintr Impact"
      user-mail-address "yixingwei4@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)
;;(setq doom-theme 'doom-1337)
;;(setq doom-theme 'doom-acario-dark)
;;(setq doom-theme 'doom-acario-light)
;;(setq doom-theme 'doom-ayu-mirage)
;;(setq doom-theme 'doom-ayu-light)
;;(setq doom-theme 'doom-badger)
;;(setq doom-theme 'doom-challenger-deep)
(setq doom-theme 'doom-city-lights)
;;(setq doom-theme 'doom-dark+)
;;(setq doom-theme 'doom-dracula)
;;(setq doom-theme 'doom-ephemeral)
;;(setq doom-theme 'doom-fairy-floss)
;;(setq doom-theme 'doom-flatwhite)
;;(setq doom-theme 'doom-gruvbox-light)
;;(setq doom-theme 'doom-gruvbox)
;;(setq doom-theme 'doom-henna)
;;(setq doom-theme 'doom-homage-black)
;;(setq doom-theme 'doom-homage-white)
;;(setq doom-theme 'doom-horizon)
;;(setq doom-theme 'doom-Iosvkem)
;;(setq doom-theme 'doom-laserwave)
;;(setq doom-theme 'doom-manegarm)
;;(setq doom-theme 'doom-material)
;;(setq doom-theme 'doom-miramare)
;;(setq doom-theme 'doom-molokai)
;;(setq doom-theme 'doom-monokai-classic)
;;(setq doom-theme 'doom-monokai-pro)
;;(setq doom-theme 'doom-monokai-spectrum)
;;(setq doom-theme 'doom-moonlight)
;;(setq doom-theme 'doom-nord-light)
;;(setq doom-theme 'doom-nord)
;;(setq doom-theme 'doom-nova)
;;(setq doom-theme 'doom-oceanic-next)
;;(setq doom-theme 'doom-old-hope)
;;(setq doom-theme 'doom-opera-light)
;;(setq doom-theme 'doom-opera)
;;(setq doom-theme 'doom-outrun-electric)
;;(setq doom-theme 'doom-palenight)
;;(setq doom-theme 'doom-peacock)
;;(setq doom-theme 'doom-plain-dark)
;;(setq doom-theme 'doom-plain)
;;(setq doom-theme 'doom-rouge)
;;(setq doom-theme 'doom-shades-of-purple)
;;(setq doom-theme 'doom-snazzy)
;;(setq doom-theme 'doom-solarized-dark)
;;(setq doom-theme 'doom-solarized-dark-high-contrast)
;;(setq doom-theme 'doom-solarized-light)
;;(setq doom-theme 'doom-sourcerer)
;;(setq doom-theme 'doom-spacegrey)
;;(setq doom-theme 'doom-tomorrow-day)
;;(setq doom-theme 'doom-tomorrow-night)
;;(setq doom-theme 'doom-wilmersdorf)
;;(setq doom-theme 'doom-xcode)
;;(setq doom-theme 'doom-zenburn)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
; they are implemented.

;;; Company mode
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)

;; Go - lsp-mode
;; Set up before-save hooks to format buffer and add/delete imports.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; Start LSP Mode and YASnippet mode
(add-hook 'go-mode-hook #'lsp-deferred)
(add-hook 'go-mode-hook #'yas-minor-mode)

;; rust
(setq rustic-lsp-server 'rust-analyzer)

;; java
(add-hook 'java-mode-hook #'lsp)

(set-company-backend! 'prog-mode
   'company-tabnine 'company-capf 'company-yasnippet)
(setq +lsp-company-backend '(company-lsp :with company-tabnine :separate))

(appendq! +ligatures-extra-symbols
          `(:checkbox      "☐"
            :pending       "◼"
            :checkedbox    "☑"
            :list_property "∷"
            :em_dash       "—"
            :ellipses      "…"
            :arrow_right   "→"
            :arrow_left    "←"
            :title         "𝙏"
            :subtitle      "𝙩"
            :author        "𝘼"
            :date          "𝘿"
            :property      "☸"
            :options       "⌥"
            :startup       "⏻"
            :macro         "𝓜"
            :html_head     "🅷"
            :html          "🅗"
            :latex_class   "🄻"
            :latex_header  "🅻"
            :beamer_header "🅑"
            :latex         "🅛"
            :attr_latex    "🄛"
            :attr_html     "🄗"
            :attr_org      "⒪"
            :begin_quote   "❝"
            :end_quote     "❞"
            :caption       "☰"
            :header        "›"
            :results       "🠶"
            :begin_export  "⏩"
            :end_export    "⏪"
            :properties    "⚙"
            :end           "∎"
            :priority_a   ,(propertize "⚑" 'face 'all-the-icons-red)
            :priority_b   ,(propertize "⬆" 'face 'all-the-icons-orange)
            :priority_c   ,(propertize "■" 'face 'all-the-icons-yellow)
            :priority_d   ,(propertize "⬇" 'face 'all-the-icons-green)
            :priority_e   ,(propertize "❓" 'face 'all-the-icons-blue)))

;; ;; ;; ======= 编辑   =========================================================
;; ;;
;; ;; evil-multiedit 方式: 使用 v 选中文本后，键入 R 可以进入多光标编辑模式. 这时使用 C-n C-p 可以在匹配文本中轮换，按 RET 反选当前匹配项.
;; ;;
;; ;;调整缩进、格式： 系统默认也是keymap到 C-M-\, 不过只是对选中区域有效，这里让当前激活的buffer也可以。
(defun dj@indent-buffer()
  (interactive)
  (indent-region (point-min) (point-max)))
(defun dj@indent-region-or-buffer()
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indent selected region."))
      (progn
        (dj@indent-buffer)
        (message "Indent buffer.")))))
(global-set-key (kbd "C-M-\\") 'dj@indent-region-or-buffer)


;; ;;光标在括号内时就高亮包含内容的两个括号
(defadvice show-paren-function (around fix-show-paren-function activate)
  (cond ((looking-at-p "\\s(") ad-do-it)
        (t (save-excursion
             (ignore-errors (backward-up-list))
             ad-do-it)))
  )


;; 设置默认缩进 4 个空格， tab也是4个空格
(setq-default c-basic-offset 2
              tab-width 2
              indent-tabs-mode nil      ; t 使用 TAB 作格式化字符  nil 使用空格代替tab作格式化字符
              tab-always-indent t )
(setq c-default-style "linux")
(add-hook 'c-mode-common-hook   ; 强制c/c++ 使用 4个空格缩进, 如果只是c++，可以用c++-mode-hook
          '(lambda()
             (setq c-basic-offset 4)
             (c-set-offset 'substatement-open 0)
             ))


;; ;; 在org，中英混排出现空格时，禁止自动折行生成真正的新行。
(remove-hook 'org-mode-hook #'auto-fill-mode) ; 在新的doom 20191017版本中，这个好像不行了，只好用下面这个把 fill-column设一个大值
(setq-default fill-column 1500)               ; org-mode模式，在超过fill-column值的列位置，插入空格，会导致硬换行|硬回车, 烦人，所以这里故意把它设大。

;; ;; ======= 搜索匹配    =========================================================
;; ;;
;; ;; *：evil normal模式  *  自动匹配光标下的单词，高亮显示， 可用n匹配下项。
;; ;; zt zz zb： evil nomal 模式下，把当前行移动到屏幕顶部、总部、底部。
;; ;; H  L:evil nomal 模式下，把光标移动到屏幕顶部， 底部。 gg是移动到到第一行， G是移动到最后一行。
;; ;; / 绑定到evil-ex-search-forward：  用于需要手动输入的时候。
;; ;; SPC / b 绑定到 counsel-grep-or-swiper ： 用于手动输入， 下面会有所有匹配结果的汇总。
;; ;; C-s 默认绑定到 isearch-forward: 不好用， swiper-isearch or swiper-isearch-thing-at-point 感觉没counsel-grep-or-swiper好用。
(defun dj@counsel-grep-or-swiper-at-point () ; 增强counsel-grep-or-swiper，默认可以自动搜索光标下的单词、或选中的。
  "C-s 默认绑定到 isearch-forward: 不好用。通过增强counsel-grep-or-swiper，可以自动搜索光标下的单词、或选中的。"
  (interactive)
  (if (window-minibuffer-p)
      (let (bnd str regionp)
        (with-ivy-window
          (setq bnd
                (if (setq regionp (region-active-p))
                    (prog1 (cons (region-beginning) (region-end))
                      (deactivate-mark))
                  (bounds-of-thing-at-point 'symbol)))
          (setq str (buffer-substring-no-properties (car bnd) (cdr bnd))))
        (insert str)
        (unless regionp
          (ivy--insert-symbol-boundaries)))
    (let (thing)
      (if (use-region-p)
          (progn
            (setq thing (buffer-substring-no-properties
                         (region-beginning) (region-end)))
            (goto-char (region-beginning))
            (deactivate-mark))
        (let ((bnd (bounds-of-thing-at-point 'symbol)))
          (when bnd
            (goto-char (car bnd)))
          (setq thing (ivy-thing-at-point))))
      (counsel-grep-or-swiper thing))))
(global-set-key (kbd "C-s") 'dj@counsel-grep-or-swiper-at-point)

;; ;;配置 Occur Mode 使其默认搜索当前被选中的或者在光标下的字符串, M-s o 默认就有，这里只是增强：默认可以搜索广标下的字符。
;; (defun occur-dwim ()
;;   "Call `occur' with a sane default."
;;   (interactive)
;;   (push (if (region-active-p)
;;             (buffer-substring-no-properties
;;              (region-beginning)
;;              (region-end))
;;           (let ((sym (thing-at-point 'symbol)))
;;             (when (stringp sym)
;;               (regexp-quote sym))))
;;         regexp-history)
;;   (call-interactively 'occur))
;; (global-set-key (kbd "M-s o") 'occur-dwim)



;; ;; ======= keymap    =========================================================
;; ;;
(map!
 ;; :nvi "C-k" #'kill-line                 ; 在正常、可视、插入模式下, C-k 删除当前行光标后的内容。
 ;; :nvi "C-e" #'doom/forward-to-last-non-comment-or-eol ; 在正常、可视、插入模式下, C-e 去到行尾。
 ;; :nvi "M-;" #'comment-dwim     ; 在正常、可视、插入模式下, M-; 在行尾添加注释。s-/  是对整行或选中区域进行注释或取消注释。
 ;; :nvi "s-/" #'comment-line     ; S代表Shift键盘；s代表Command键，默认s-/绑定到evilnc-comment-or-uncomment-lines， 感觉没comment-line好用
 )



(map! :leader
      (:prefix ("t" . "toggle")                               ;  SPC t 切换 toggle
       ;; :desc "当前行居中"                  "-" #'centered-cursor-mode) ; 切换当前行居中
       ;;         :desc "自动调整窗口大小"     "w" #'golden-ratio-mode; 切换自动调整当前窗口大小
       ;; :desc "自动折行"         "v" #'visual-line-mode    ; 系统提供了word-wrap模块，启用后，可通过 SPC t w 切换。自动折行，虚拟成n行，上下行、头尾移动方便。 toggle-truncate-lines自动折行，但逻辑上还是一行，不好用。
       ;;   ;;; deprecated      ;; :desc "org显示内嵌的图片"       "m" #'org-toggle-inline-images ; 在org-mode下， 这个函数系统已经默认绑定到 z i
       ))
