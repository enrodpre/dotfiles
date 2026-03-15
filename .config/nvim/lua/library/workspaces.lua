local W = {
  list = {
    "$HOME/.config/nvim",
    "$HOME/.local/share/nvim/lazy",
    "$HOME/dev/cmm"
  },
}

function W.select()
  vim.ui.select(W.list, { prompt = "Select cwd", },
    function(dir)
      if not dir then
        vim.notify("No dir selected", vim.log.levels.INFO, {})
        return
      end

      vim.schedule(function()
        vim.api.nvim_set_current_dir(dir)
      end)
    end)
end

function W.setup()
  vim.keymap.set("n", "gw", W.select, {})
end

-- function W.add()
--
return W
