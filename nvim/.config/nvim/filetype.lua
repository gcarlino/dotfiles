local fortran77 = function(path, bufnr)
    return "fortran77", function (_bufnr)
        -- vim.api.nvim_buf_set_option(_bufnr, "syntax", "fortran")
        vim.api.nvim_exec(
            [[
            set syntax=fortran
            let g:fortran_fixed_source=1
            set tabstop=6
                        set softtabstop=6
                        set shiftwidth=6
                        set softtabstop=6
            set shiftwidth=6
            ]],
            true)
    end
end

vim.filetype.add({
    extension = {
        cuf = "fortran",
        f =  fortran77
        -- f90 = fType,
    }
})
