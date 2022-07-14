local fortran77 = function(path, bufnr)
    return "fortran77", function ()
        vim.bo.syntax="fortran"
        vim.g.fortran_fixed_source=1
        vim.o.tabstop = 6
        vim.o.shiftwidth = 6
        vim.o.softtabstop=6
        vim.bo.commentstring = "C%s"
    end
end

vim.filetype.add({
    extension = {
        cuf = "fortran",
        f =  fortran77
        -- f90 = fType,
    }
})
