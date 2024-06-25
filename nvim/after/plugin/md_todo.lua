local todo = require("md_todo")

vim.keymap.set("n", "<leader>md", function ()
  todo.toggle_state()
end)
vim.keymap.set("n", "<leader>mn", function ()
  todo.create_todo()
end)
