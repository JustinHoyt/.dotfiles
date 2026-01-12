return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")

    mc.setup()

    local set = vim.keymap.set

    -- 1. The "Ctrl-n" Workflow (The VVM Classic)
    -- Select word under cursor (or add next match if already active)
    set({ "n", "v" }, "<C-n>", function()
      mc.matchAddCursor(1)
    end)

    -- Select ALL matches of the word under cursor immediately
    set({ "n", "v" }, "<C-q>", function()
      mc.matchAllAddCursors()
    end)

    -- 2. Vertical Cursors (Ctrl-Up/Down)
    set({ "n", "v" }, "<C-Down>", function()
      mc.lineAddCursor(1)
    end)
    set({ "n", "v" }, "<C-Up>", function()
      mc.lineAddCursor(-1)
    end)

    -- 2. The "Layer" (Only active when multicursors exist)
    -- This replaces the broken AutoCmds
    mc.addKeymapLayer(function(layerSet)
      -- layerSet has the same signature as vim.keymap.set

      -- 'q' skips the current match
      layerSet("n", "q", function()
        mc.matchSkipCursor(1)
      end)

      -- 'Q' removes the current cursor
      layerSet("n", "Q", function()
        mc.deleteCursor()
      end)
    end)

    -- 4. Handling Escape
    set("n", "<Esc>", function()
      if not mc.cursorsEnabled() then
        mc.enableCursors()
      elseif mc.hasCursors() then
        mc.clearCursors()
      else
        -- Fallback to default ESC behavior to clear search highlights etc.
        vim.cmd("noh")
      end
    end)

    -- 5. Next/Prev Cursor Navigation (Optional: VVM uses [ and ])
    set({ "n", "v" }, "[", mc.prevCursor)
    set({ "n", "v" }, "]", mc.nextCursor)
  end,
}
