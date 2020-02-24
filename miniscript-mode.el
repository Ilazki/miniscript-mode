;; Still need indentation.  fish-mode may be good info.

;;;###autoload
(defconst miniscript-mode-syntax-table
  (let ((table (make-syntax-table)))
    ;; " is a string delimiter
    (modify-syntax-entry ?\" "\"" table)

    ;; / is punctuation, but // is a comment starter
    (modify-syntax-entry ?/ ". 12" table)
    ;; \n is a comment ender
    (modify-syntax-entry ?\n ">" table)
    table))

;; Still need to add @foo function refs.  Also should probably move
;; all the methods to something else.
;;;###autoload
(defconst miniscript-font-lock-keywords
  ;; Keywords
  `(,(rx symbol-start
         (or
          "if" "else if" "else" "end if" "then"
          "end while" "while" "end for" "for" "break" "continue"
          "end function" "function" "return"
          
          "print" "time" "wait" "locals" "outer" "globals" "yield"
          "new"
          )
         symbol-end
         )
    ;; negation
    (,(rx symbol-start
          (group (or
                  "not" "!=")))
     (0 font-lock-negation-char-face))
    ;; numbers
    (,(rx symbol-start (1+ (or digit "."))) (0 font-lock-constant-face))
    ;; variable bindings
    (,(rx symbol-start (group (1+ (or word ?_ ?' ?.))) (* space) (= 1 ?=) (not (any ?=)))
     (1 font-lock-variable-name-face))

    ;; built-ins
    (,(rx symbol-start
         (group (or
          "abs" "cos" "asin" "atan" "ceil" "char" "cos" "floor"
          "log" "round" "rnd" "pi" "sign" "sin" "sqrt" "str" "tan"

          "indexOf" "insert" "len" "val" "code" "remove" "lower"
          "upper" "replace" "split"

          "hasIndex" "insert" "join" "push" "pop" "pull" "indexes"
          "values" "len" "sum" "sort" "shuffle" "remove" "range"

          ))
         symbol-end
         )
 (1 font-lock-builtin-face))
     ))

;;;###autoload
(define-derived-mode miniscript-mode prog-mode "MiniScript mode"
  :syntax-table miniscript-mode-syntax-table
  (set (make-local-variable 'font-lock-defaults) '(miniscript-font-lock-keywords))
  (font-lock-fontify-buffer))

;; ;;;###autoload
;; (defun miniscript-mode ()
;;   "Major mode for editing MiniScript files"
;;   (interactive)
;;   (kill-all-local-variables)
;;   (setq major-mode 'miniscript-mode))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.ms\\'" . miniscript-mode))

(provide 'miniscript-mode)
