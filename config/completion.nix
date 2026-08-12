{
  plugins = {
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        mapping = {
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.abort()";
          "<CR>" = "cmp.mapping.confirm({ select = false })";
          "<Tab>" = "cmp.mapping.select_next_item()";
          "<S-Tab>" = "cmp.mapping.select_prev_item()";
        };
        snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        sources = [
          {
            name = "lazydev";
            group_index = 0;
          }
          {name = "nvim_lsp";}
          {name = "luasnip";}
          {name = "buffer";}
          {name = "path";}
        ];
      };
    };

    cmp-buffer.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp-path.enable = true;
    cmp_luasnip.enable = true;

    luasnip = {
      enable = true;
      fromVscode = [{}];
      settings.enable_autosnippets = true;
    };
    friendly-snippets.enable = true;

    lazydev = {
      enable = true;
      settings.library = [
        {
          path = "\${3rd}/luv/library";
          words = ["vim%.uv"];
        }
      ];
    };
  };

  extraConfigLua = ''
    local ls = require("luasnip")
    local s, t, i = ls.snippet, ls.text_node, ls.insert_node

    local c_comments = {
      s("cheadercomment", {
        t("// Lloyd Williams (z5599988) | Written on " .. os.date("%d/%m/%Y ")),
        t({ "", "// Description: " }),
      }),
      s("bigcomment", {
        t("// " .. string.rep("=", 20) .. " "),
        i(1),
        t(" " .. string.rep("=", 20) .. " //"),
      }),
    }
    ls.add_snippets("c", c_comments)
    ls.add_snippets("cpp", c_comments)
    ls.add_snippets("java", { c_comments[2] })

    ls.add_snippets("typst", {
      s({ trig = "mk", snippetType = "autosnippet" }, { t("$"), i(1), t(" $") }),
      s({ trig = "dm", snippetType = "autosnippet" }, {
        t({ "$", "  " }), i(1), t({ "", "  .", "$" }),
      }),
      s("def", { t({ "#definition()[", "  " }), i(1), t({ "", "]" }) }),
    })

    vim.keymap.set("i", "<C-K>", function() ls.expand() end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-E>", function()
      if ls.choice_active() then ls.change_choice(1) end
    end, { silent = true })
  '';
}
