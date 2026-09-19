-- 文件路径: ~/.config/nvim/lua/plugins/tmux-session-fix.lua

return {
  "tpope/vim-obsession",
  -- event = "VeryLazy", -- 确保它在启动时加载
  config = function()
    -- 我们将你找到的 Vimscript 代码原封不动地放在这里
    -- vim.cmd([[ ... ]]) 是在 Lua 中执行 Vimscript 的标准方法
    vim.cmd([[
      function! ConstructNvimSessionFileName()
        let session_id_raw = substitute(system('tmux display-message -p "#{session_id}"'), '\n', '', '')
        let session_id = substitute(session_id_raw, '^\$', '', '')
        let window_index = substitute(system('tmux display-message -p "#{window_index}"'), '\n', '', '')
        let pane_index = substitute(system('tmux display-message -p "#{pane_index}"'), '\n', '', '')
        return getcwd() . '/.TmuxNvimSession-' . session_id . '-' . window_index . '-' . pane_index . '.vim'
      endfunction

      function! StartTmuxPaneNvimSession()
        if exists("$TMUX_PANE")
          let session_file = ConstructNvimSessionFileName()
          if filereadable(session_file)
            execute 'source ' . session_file
            " echo "Loading Session from " . session_file
          endif
          execute 'Obsession ' . session_file
          " echo "Saving Session to " . session_file
          call timer_start(100, {tid -> execute("bufdo if !empty(expand('%')) | e | endif")})
        endif
      endfunction

      if exists('$TMUX')
        autocmd VimEnter * call StartTmuxPaneNvimSession()
      endif
    ]])
  end,
}
