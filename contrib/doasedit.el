;;; doasedit.el --- Automatic doasedit major-mode detection -*- lexical-binding: t; -*-

;; Copyright (C) 2026  Thomas Voss

;; Author: Thomas Voss <mail@thomasvoss.com>
;; Maintainer: Thomas Voss <mail@thomasvoss.com>
;; URL: https://git.thomasvoss.com/doasutils
;; Package-Version: 1.0.0
;; Package-Requires: ((emacs "24.4"))
;; Keywords: tools, convenience, files

;; This file is NOT part of GNU Emacs.

;;; License:
;;
;; Permission to use, copy, modify, and distribute this software for any
;; purpose with or without fee is hereby granted, provided that the above
;; copyright notice and this permission notice appear in all copies.
;;
;; THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
;; WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
;; WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
;; AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
;; DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA
;; OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
;; TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
;; PERFORMANCE OF THIS SOFTWARE.
;;; Commentary:
;;
;; This package provides `global-doasedit-mode', a minor-mode that
;; ensures that the correct major-mode is set in the current buffer when
;; editing files via the `doasedit' command-line utility.

;;; Code:

(defgroup doasedit nil
  "Automatic major-mode detection when editing files via doasedit."
  :group 'tools)

(defun doasedit--setup-buffer ()
  (let* ((tmpdir (or (getenv "TMPDIR") "/tmp"))
         (regexp (expand-file-name "\\`doasedit\\.")))
    (when (and buffer-file-name (string-match-p regexp buffer-file-name))
      (if-let ((target-file (getenv "DOASEDIT_EDITING")))
          (let ((buffer-file-name target-file))
            (set-auto-mode)
            (rename-buffer (format "*doasedit: %s*" target-file) :unique))
        (error "`DOASEDIT_EDITING' is not set.")))))

;;;###autoload
(define-minor-mode global-doasedit-mode
  "Global minor-mode to automatically set correct major-mode in the
current buffer when editing a root-protected file via the doasedit
command-line utility."
  :global t
  :lighter nil
  (if global-doasedit-mode
      (add-hook 'find-file-hook #'doasedit--setup-buffer)
    (remove-hook 'find-file-hook #'doasedit--setup-buffer)))

(provide 'doasedit)
;;; doasedit.el ends here
