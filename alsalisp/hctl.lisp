(setq card (acall 'card_next -1))
(setq card (aresult card))
(while (>= card 0)
  (progn
    (princ "found card: " card "\n")
    (princ "  name    : " (aresult (acall 'card_get_name card)) "\n")
    (princ "  longname: " (aresult (acall 'card_get_longname card)) "\n")
    (setq card (acall 'card_next card))
    (setq card (aresult card))
  )
)

(princ "card_get_index test (SI7018): " (acall 'card_get_index "SI7018") "\n")
(princ "card_get_index test (ABCD): " (acall 'card_get_index "ABCD") "\n")

(setq hctl (acall 'hctl_open ('default nil)))
(if (= (aerror hctl) 0)
  (progn
    (princ "open success: " hctl "\n")
    (setq hctl (ahandle hctl))
    (princ "open hctl: " hctl "\n")
    (setq hctl (acall 'hctl_close hctl))
    (if (= hctl 0)
      (princ "close success\n")
      (princ "close failed: " hctl "\n")
    )
  )
  (progn
    (princ "open failed: " hctl "\n")
  )
)

(setq ctl (acall 'ctl_open ('default nil)))
(if (= (aerror ctl) 0)
  (progn
    (princ "ctl open success: " ctl "\n")
    (setq ctl (ahandle ctl))
    (setq info (aresult (acall 'ctl_card_info ctl)))
    (princ "ctl card info: " info "\n")
    (princ "ctl card info (mixername): " (cdr (assq "mixername" info)) "\n")
    (setq hctl (acall 'hctl_open_ctl ctl))
    (if (= (aerror hctl) 0)
      (progn
        (princ "hctl open success: " hctl "\n")
        (setq hctl (ahandle hctl))
        (princ "open hctl: " hctl "\n")
	(princ "load hctl: " (acall 'hctl_load hctl) "\n")
	(princ "first    : " (acall 'hctl_first_elem hctl) "\n")
	(princ "last     : " (acall 'hctl_last_elem hctl) "\n")
	(princ "next (first): " (acall 'hctl_elem_next (acall 'hctl_first_elem hctl)) "\n")
	(princ "prev (last) : " (acall 'hctl_elem_prev (acall 'hctl_last_elem hctl)) "\n")
	(princ "first info  : " (acall 'hctl_elem_info (acall 'hctl_first_elem hctl)) "\n")
        (setq hctl (acall 'hctl_close hctl))
        (if (= hctl 0)
          (princ "hctl close success\n")
          (princ "hctl close failed: " hctl "\n")
        )
      )
      (progn
        (princ "hctl open failed: " ctl "\n")
	(acall 'ctl_close ctl)
      )
    )
  )
  (progn
    (princ "ctl open failed: " ctl "\n")
  )
)
