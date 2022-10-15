local fortran77 = function()
    if vim.fn.search("^C ", "nw", 200) ~= 0 then
        return "fortran77", function()
            vim.bo.syntax = "fortran"
        end
    end
    return "fortran"
end

vim.filetype.add({
    extension = {
        cuf = 'fortran',
        f = fortran77,
        f90 = fortran77,
    }
})
