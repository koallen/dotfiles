" disable smart_indent_cap
lua require("ibl").setup_buffer(0, { indent = { smart_indent_cap = false } })

" change indentation rules to 2 spaces
setlocal shiftwidth=2
setlocal softtabstop=2
