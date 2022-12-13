local status, diffview = pcall(require, 'diffview')
if not status then
    return
end

diffview.setup({
    view = {
        merge_tool = {
            layout = "diff3_mixed"
        }
    }
})
