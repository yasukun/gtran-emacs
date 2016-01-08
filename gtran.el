;;; gtran.el --- This package allows to translate the strings using Google Translate service (required api key).  -*- lexical-binding: t; -*-

;; Copyright (C) 2016  sukezo

;; Author: sukezo <https://twitter.com/sukezo>
;; Keywords: tools

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(require 'auto-complete)

(defun gtran-process (target)
  (when (executable-find "honyaku-exe")
    (shell-command-to-string
     (concat "honyaku-exe -q " (shell-quote-argument target)))))

(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(setq popwin:popup-window-position 'bottom)
(push '("*gtran*") popwin:special-display-config)

(defun pop-gtran (target)
  (let* ((multiline-escaped-string (replace-regexp-in-string "\n" "\uFF00" target))
	 (doc (gtran-process multiline-escaped-string)))
    (when doc
      (with-output-to-temp-buffer "*gtran*"
	(princ doc)))))

(defun gtran-symbol ()
  (interactive)
  (pop-gtran (symbol-name (symbol-at-point))))

(defun gtran (start end)
     (interactive "r")
     (deactivate-mark t)
     (pop-gtran (buffer-substring-no-properties start end)))

(provide 'gtran)
;;; gtran.el ends here
