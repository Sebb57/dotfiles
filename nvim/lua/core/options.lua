-- mapleader
vim.g.mapleader = " "

-- INDENTS
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- line numbers
vim.opt.relativenumber = false
vim.opt.number = true

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    if vim.fn.expand("%") == "" then
      local fname = vim.fn.input("Enter filename: ")
      if fname ~= "" then
        vim.cmd("saveas " .. fname)
      else
        print("Save cancelled")
        return
      end
    end
  end
})

--clipboard
vim.opt.clipboard:append("unnamedplus")


--start LSP
-- vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
--   callback = function(args)
--     local clients = vim.lsp.get_clients({ bufnr = args.buf })
--     if #clients == 0 then
--       vim.cmd("LspStart")
--     end
--   end,
-- })

-- EPITECH HEADERS
vim.cmd([[
syntax on

set autoindent
set expandtab
set softtabstop=4
set shiftwidth=4
set shiftround
set smartindent

function! InsertHeaderC()
    let l:filename = expand("%:t")
    let l:dirname = fnamemodify(getcwd(), ':t') " Get current directory name
    let l:header = [
                \ '/*',
                \ '** EPITECH PROJECT, 2026',
                \ '** ' . l:dirname,
                \ '** File description:',
                \ '** ' . l:filename,
                \ '*/',
                \ ''
                \ ]
    call append(0, l:header)
endfunction

function! InsertHeaderMakefile()
    let l:filename = expand("%:t")
    let l:dirname = fnamemodify(getcwd(), ':t') " Get current directory name
    let l:header = [
                \ '##',
                \ '## EPITECH PROJECT, 2026',
                \ '## ' . l:dirname,
                \ '## File description:',
                \ '## ' . l:filename,
                \ '##',
                \ ''
                \ ]
    call append(0, l:header)
endfunction

function! InsertHeaderPython()
    let l:filename = expand("%:t")
    let l:dirname = fnamemodify(getcwd(), ':t') " Get current directory name
    let l:header = [
                \ '#!/usr/bin/env python3',
                \ '#',
                \ '# EPITECH PROJECT, 2026',
                \ '# ' . l:dirname,
                \ '# File description:',
                \ '# ' . l:filename,
                \ '#',
                \ ''
                \ ]
    call append(0, l:header)
endfunction

function! InsertHeaderH()
    let l:filename = expand("%:t")
    let l:dirname = fnamemodify(getcwd(), ':t')
    let l:macro_name = substitute(toupper(l:filename), '\.', '_', 'g') . '_'
    let l:header = [
                \ '/*',
                \ '** EPITECH PROJECT, 2026',
                \ '** ' . l:dirname,
                \ '** File description:',
                \ '** ' . l:filename,
                \ '*/',
                \ '',
                \ '#ifndef ' . l:macro_name,
                \ '    #define ' . l:macro_name,
                \ '',
                \ '#endif /* ' . l:macro_name . ' */',
                \ ]
    call append(0, l:header)
endfunction

function! InsertHeaderHaskell()
    let l:filename = expand("%:t")
    let l:dirname = fnamemodify(getcwd(), ':t')
    let l:header = [
                \ '{-',
                \ '-- EPITECH PROJECT, 2026',
                \ '-- ' . l:dirname,
                \ '-- File description:',
                \ '-- ' . l:filename,
                \ '-}'
                \ ]
    call append(0, l:header)
endfunction

nnoremap <C-p> :call InsertHeaderPython()<CR>

autocmd BufNewFile *.c call InsertHeaderC()
autocmd BufNewFile *.h call InsertHeaderH()
autocmd BufNewFile *.py call InsertHeaderPython()
autocmd BufNewFile Makefile call InsertHeaderMakefile()
autocmd BufNewFile *.hs call InsertHeaderHaskell()
]])

local header_options = {
    { label = ".h", func = "InsertHeaderH" },
    { label = "Makefile", func = "InsertHeaderMakefile" },
    { label = "Python", func = "InsertHeaderPython" },
    { label = "Haskell", func = "InsertHeaderHaskell" },
    { label = "C", func = "InsertHeaderC" },
}

vim.keymap.set("n", "<C-h>", function()
    vim.ui.select(header_options, {
        prompt = "Select header:",
        format_item = function(item)
            return item.label
        end,
    }, function(choice)
        if choice then
            vim.fn[choice.func]()
        end
    end)
end, { noremap = true, silent = true, desc = "Insert Epitech Header" })
