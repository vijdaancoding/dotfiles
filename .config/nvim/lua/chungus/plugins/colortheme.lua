return {
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      local onedark = require("onedark")

      -- Track current transparency state
      local current_transparent = false

      -- Theme application logic
      local function apply_theme()
        onedark.setup {
          style = 'warmer',
          transparent = current_transparent,
          term_color = true,
          ending_tildes = false,
          cmp_itemkind_reverse = false,

          code_style = {
            comments = 'italic',
            keywords = 'none',
            functions = 'none',
            strings = 'none',
            variables = 'none'
          },
        }
        onedark.load()   
      end

      -- Call theme on load
      apply_theme()

      -- Keymap: Toggle transparency
      vim.keymap.set("n", "<leader>bg", function()
        current_transparent = not current_transparent
        apply_theme()
        vim.notify("Transparency: " .. (current_transparent and "ON" or "DIM"), vim.log.levels.INFO, { title = "Theme" })
      end, { desc = "Toggle background transparency" })
    end,
  },
}
