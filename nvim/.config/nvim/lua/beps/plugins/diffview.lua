local status, diffview = pcall(require, 'diffview')
if not status then
    return
end

diffview.setup({
    view = {
        default = {
            layout = "diff2_horizontal",
            -- layout = "diff2_vertical",
        },
        merge_tool = {
            layout = "diff3_mixed"
        }
    },
})

vim.opt.fillchars = vim.opt.fillchars + 'diff:╱'
