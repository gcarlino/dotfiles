local status, diffview = pcall(require, 'diffview')
if not status then
    return
end

diffview.setup({
    view = {
        default = {
            layout = "diff2_vertical",
        },
        merge_tool = {
            layout = "diff3_mixed"
        }
    },
    file_panel = {
        win_config = "right",
    },
})
