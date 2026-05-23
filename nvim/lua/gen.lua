vim.api.nvim_create_user_command("GenTestFlow", function(opts)
    local name = opts.args

    local property = name
    local vars_key = name
    local data_test = "_" .. name

    local output = table.concat({
        "@property",
        "def value_" .. property .. "(self) -> bool:",
        "    return self.vars.setdefault(",
        '        "' .. vars_key .. '",',
        "        True,",
        "        False,",
        "        aw_utils.aw_random_bool()",
        "    )",
        "",
        "def answer_" .. name .. "(self) -> bool:",
        "    suffix = aw_utils.bool_to_english(self.value_" .. property .. ")",
        '    data_test = f"' .. data_test .. '-{suffix}"',
        "    locator = f\"label[data-test='{data_test}'] span\"",
        "",
        "    aw_utils.aw_click_button_sr(",
        "        self,",
        "        locator,",
        '        description="' .. name .. '"',
        "    )",
        "    return self.value_" .. property,
        "",
        "def step_" .. name .. "(self):",
        "    self.answer_" .. name .. "()",
        "    if self.value_" .. property .. ":",
        "        pass",
        "    else:",
        "        pass",
    }, "\n")

    vim.api.nvim_put(vim.split(output, "\n"), "l", true, true)
end, { nargs = 1 })
