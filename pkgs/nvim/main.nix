{ pkgs, config, ... }:

let
    vim-spell-pt-br = pkgs.vimUtils.buildVimPlugin {
        name = "vim-spell-pt-br";
        src = pkgs.fetchFromGitHub {
            owner= "mateusbraga";
            repo= "vim-spell-pt-br";
            rev= "3d7eb3098de77b86c8a880354b442b3d84b18a72";
            sha256= "1wcrb3q5zn10s00dxmaiw4a9j6yj45dv4sr3nygmivkcin3sf490";
            fetchSubmodules = true;
        };
    };
    spellsitter = pkgs.vimUtils.buildVimPlugin {
        name = "spellsitter";
        dontBuild = true;
        dontCheck = true;
        src = pkgs.fetchFromGitHub {
            owner= "lewis6991";
            repo= "spellsitter.nvim";
            rev= "0a19491a9c15c0b9283a6698e31ea7471419d5f8";
            sha256= "0rq3nwgjiapv3cshfrm2nkhflgqd9kvx46g8n2plzw4i6r67njcf";
        };

    };
    nvim-code-action-menu = pkgs.vimUtils.buildVimPlugin {
        name = "nvim-code-action-menu";
        src = pkgs.fetchFromGitHub {
            owner = "weilbith";
            repo = "nvim-code-action-menu";
            rev = "b3671ef7a74912575d84b4dbc848fd3b6195b27e";
            sha256 = "0p6959z8im5r1mvr0fmx1ig24kav9wndnr50r1pvq117ch9kr59z";
        };
    };
    project_nvim = pkgs.vimUtils.buildVimPlugin {
        name = "project_nvim";
        src = pkgs.fetchFromGitHub {
            owner = "ahmedkhalf";
            repo = "project.nvim";
            rev = "cef52b8da07648b750d7f1e8fb93f12cb9482988";
            sha256 = "1qwpp0a8llx437jms3ghx8wrc5rwnrkh52xp24ysymqr4lc1xfq6";
        };
    };
    neogen = pkgs.vimUtils.buildVimPlugin {
        name = "neogen";
        src = pkgs.fetchFromGitHub {
            owner = "danymat";
            repo = "neogen";
            rev = "218e0a63fd28fe3fcd34477e198193f26e0863ce";
            sha256 = "1x8nyrclg2bvs6p136jr2d20xprr9r0x61ahd535yxxwngnm19dc";
        };
        dontBuild = true;
        dontCheck = true;
    };
  vimp = pkgs.vimUtils.buildVimPlugin {
    name = "vimp";
    src = pkgs.fetchFromGitHub {
      owner = "svermeulen";
      repo = "vimpeccable";
      rev = "bd19b2a86a3d4a0ee184412aa3edb7ed57025d56";
      sha256 = "0wbdfcfsgp85g2q6nnnxxn0x9h9vjpll9kklcbfgphplpw4hww9j";
    };
  };
    tressiter-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "tressitter";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-treesitter";
      repo = "nvim-treesitter";
      rev = "a10b603a2cd6d336412e996970e91566492562d2";
      sha256 = "UzrJhJk4zPk+VNUxma4qwsEGgZynfd4RPEk2mSbqQms=";
    };
    };
  copilot-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "copilot";
    src = pkgs.fetchFromGitHub {
      owner = "github";
      repo = "copilot.vim";
      rev = "4df203c1356b72032df32d7b0b5facb4895139b6e7e";
      sha256 = "Dd9nTeOPBgft9QTj+CJbvLxCqLMYdvBjjo5cEsYKYqM=";
    };
  };
  firenvim-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "firenvim";
    src = pkgs.fetchFromGitHub {
      owner = "glacambre";
      repo = "firenvim";
      rev = "668b350ce88cc9a2257644c67945c9abbdd36cb5";
      sha256 = "e+ZniVYOJEuCTwjNkta9K0jrVddxOHa/vqWQuMGO7lk=";
    };
  };
  dressing-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "dressing";
    src = pkgs.fetchFromGitHub {
      owner = "stevearc";
      repo = "dressing.nvim";
      rev =  "b36b69c6a5d6b30b16782be22674d6d037dc87e3";
      sha256 = "UZxi7EeTJ8fVuJsHYbVCuNG1G22VdbZgz7s4Rk8/y8Y=";
    };
  };
  venn-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "venn";
    src = pkgs.fetchFromGitHub {
      owner = "jbyuki";
      repo = "venn.nvim";
      rev =  "d5a9c73fe7772c11414fc52acbb1d1bdb1ebc70f";
      sha256 = "BnSE/W8T+NiIa9xCuSga+vDkwdDDGv+/T6havEPf/dc=";
    };
  };
  nvim-hclipboard = pkgs.vimUtils.buildVimPlugin {
    name = "hclipboard";
    src = pkgs.fetchFromGitHub {
      owner = "kevinhwang91";
      repo = "nvim-hclipboard";
      rev = "90fd9a9fe28971d5b464eada34864c889d28a7dd";
      sha256 = "ws6qVznAGdbJmV2gWOD2XzAqlAJEP5c6TZN63GB4bQM=";
    };
  };
  toggle-term = pkgs.vimUtils.buildVimPlugin {
    name = "toggle-term";
    src = pkgs.fetchFromGitHub {
      owner = "jbyuki";
      repo = "toggleterm.nvim";
      rev = "dca8f4d9516270cb41c147ed692f3ee420c5e515";
      sha256 = "GBbpLdsPprxUlpCg9eRD+KvKWPKe7wELxPTN1C2+Xio=";
    };
  };
  nvim-palenight = pkgs.vimUtils.buildVimPlugin {
    name = "palenight";
    src = pkgs.fetchFromGitHub {
      owner = "mateus-cavalcanti";
      repo = "nvim-palenight.lua";
      rev = "d316039df82dd9640f6a4baec655e4cf84334619";
      sha256 = "9GMu9PRisRCvMGb4wydQzaat+3juYhZXHpqjF44TkQU=";
    };
  };
  dirbuf = pkgs.vimUtils.buildVimPlugin {
    name = "dirbuf";
    src = pkgs.fetchFromGitHub {
      owner = "elihunter173";
      repo = "dirbuf.nvim";
      rev = "d347a7e21b94162ddfa4323b7d1408e90d8c9502";
      sha256 = "77y3ncqP+e9NvVIZOPoUAF3Hle0632OqwtTmOXB+Abs=";
    };
  };
  instant-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "instant";
    src = pkgs.fetchFromGitHub {
      owner = "jbyuki";
      repo = "instant.nvim";
      rev = "c02d72267b12130609b7ad39b76cf7f4a3bc9554";
      sha256 = "7Pr2Au/oGKp5kMXuLsQY4BK5Wny9L1EBdXtyS5EaZPI=";
    };
  };
in
{
    # programs.neovim = {
        # vimAlias = true;
        # enable = true;
        # plugins = with pkgs.vimPlugins; [
        #   # Package manager
        #   packer-nvim
        #   # File tree
        #   nvim-web-devicons
        #   nvim-tree-lua
        #
        #   # LSP
        #   nvim-lspconfig
        #   # ultisnips
        #   lsp_signature-nvim
        #   nvim-code-action-menu
        #   friendly-snippets
        #   luasnip
        #
        #   # Languages
        #   vim-nix
        #
        #   # Eyecandy
        #   nvim-treesitter
        #   nvim-treesitter-context
        #   bufferline-nvim
        #   galaxyline-nvim
        #   nvim-colorizer-lua
        #   pears-nvim
        #   # dressing-nvim
        #   TrueZen-nvim
        #   goyo-vim
        #   vim-visual-multi
        #   # nvim-ts-rainbow
        #   # nvim-palenight
        #   palenight-vim
        #   catppuccin-nvim
        #   # nvim-cursorline
        #
        #   # Docs generator
        #   # neogen
        #
        #   # LSP and completion
        #   nvim-lspconfig
        #   nvim-compe
        #   cmp-nvim-lsp
        #   # vim-vsnip
        #   copilot-nvim
        #   nvim-dap
        #   feline-nvim
        #
        #   # Latex
        #   vimtex
        #
        #   # Telescope
        #   telescope-nvim
        #
        #   # Indent lines
        #   indent-blankline-nvim
        #
        #   # Spell Checking
        #   vim-spell-pt-br
        #   spellsitter
        #   nvim-cmp
        #   cmp-spell
        #   nvim-lightbulb
        #   project_nvim
        #
        #   # Writing utilities
        #   todo-comments-nvim
        #   neorg
        #   venn-nvim
        #   dirbuf
        #
        #   # Other utilities
        #   nvim-whichkey-setup-lua
        #   instant-nvim
        #   which-key-nvim
        #   nvim-notify
        #   firenvim-nvim
        #   nvim-comment
        #   specs-nvim
        #   toggle-term
        #   sniprun
        #   # vimp
        #   nvim-bqf
        #   neoformat
        #   # dashboard-nvim
        #   diffview-nvim
        #   impatient-nvim
        #   plenary-nvim
        #   nvim-hclipboard
        # ];
        # extraConfig = ''
        #     luafile /home/mateusc/.config/nixpkgs/pkgs/nvim/lua/settings.lua
        # '';
    # };
}
