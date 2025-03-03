return {
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    event = 'InsertEnter',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'default' },
      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = false,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        -- adding any nvim-cmp sources here will enable them
        -- with blink.compat
        -- compat = {},
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },

        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },

      -- Blink.cmp uses a Rust fuzzy matcher by default for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = 'prefer_rust_with_warning' },

      completion = {
        accept = {
          -- experimental auto-brackets support
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          draw = {
            treesitter = { 'lsp' },
          },
          auto_show = true,
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = true,
          show_with_menu = false,
        },
      },
    },
    opts_extend = {
      'sources.completion.enabled_providers',
      -- 'sources.compat',
      'sources.default',
    },
  },
}
