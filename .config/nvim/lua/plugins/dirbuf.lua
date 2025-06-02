return {
  {
    "elihunter173/dirbuf.nvim",
    keys = {
      {
        "<leader>ob",
        "<cmd>Dirbuf<CR>",
        desc = "[O]pen Dir[b]uf"
      },
      {
        "<C-i>",
        "<Plug>dirbuf_enter",
      },
    },
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        desc = "Mappings for difbuf",
        pattern = "dirbuf",
        once = true,
        callback = function(args)
          vim.api.nvim_buf_set_keymap(args.buf, "n", "<C-i>", "<Plug>(dirbuf_enter)", {})
          vim.api.nvim_buf_set_keymap(args.buf, "n", "<C-b>", "<Plug>(dirbuf_up)", {})
        end
      })
      return {}
    end
  }
}
