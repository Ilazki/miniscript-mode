;; Still need indentation.  fish-mode may be good info.

;;;###autoload
(defconst greyscript-mode-syntax-table
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
(defconst greyscript-font-lock-keywords
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
         symbol-end)
     (1 font-lock-builtin-face))

    ;; GreyHack API
    (,(rx symbol-start
          (group (or
                  ;; Misc.
                  "params" "typeof" "md5" "get_router" "get_shell"
                  "nslookup" "whois" "is_valid_ip" "is_lan_ip"
                  "command_info" "current_date" "parent_path" "home_dir"
                  "program_path" "active_user" "user_mail_address"
                  "user_bank_number" "format_columns" "user_input"
                  "include_lib" "exit"
                  ;; Router
                  "public_ip" "local_ip"
                  "computer_ports" "computers_lan_ip" "ping_port"
                  "port_info" "used_ports" "bssid_name" "essid_name"
                  ;; Computer
                  "change_password" "create_user" "create_group"
                  "create_folder" "close_program" "connect_wifi"
                  "delete_user" "delete_group" "groups" "network_devices"
                  "get_ports" "is_network_active" "lan_ip" "show_procs"
                  "current_path" "touch" "wifi_networks" "File"
                  ;; File
                  "copy" "move" "rename" "chmod" "set_content" "set_group"
                  "group" "path" "content" "is_binary" "is_folder"
                  "has_permission" "set_owner" "owner" "permissions"
                  "parent" "name" "size" "delete" "get_folders" "get_files"
                  ;; Port
                  "get_lan_ip" "is_closed" "port_number"
                  ;; Shell
                  "host_computer" "start_terminal" "connect_service"
                  "scp_upload" "launch" "build"
                  ;; FtpShell
                  "start_terminal" "put" "host_computer"
                  ;; Cryto
                  "aircrack" "airmon" "decipher" "smtp_user_list"
                  ;; MetaLib
                  "overflow" "lib_name" "version"
                  ;; Metaxploit
                  "load" "net_use" "scan" "scan_address"
                  ;; NetSession
                  "dump_lib"
                  )) symbol-end)
     (1 font-lock-function-name-face))

     ))

;;;###autoload
(define-derived-mode greyscript-mode prog-mode "GreyHack Script mode"
  :syntax-table greyscript-mode-syntax-table
  (set (make-local-variable 'font-lock-defaults) '(greyscript-font-lock-keywords))
  (font-lock-fontify-buffer))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.gsc\\'" . greyscript-mode))
;;;###autoload
(add-to-list 'auto-mode-alist '("\\.src\\'" . greyscript-mode))

(provide 'greyscript-mode)
