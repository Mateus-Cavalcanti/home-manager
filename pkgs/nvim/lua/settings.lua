--!/usr/bin/env cached-nix-shell
--! nix-shell -p lua -i "lua" --quiet
local opt = vim.opt
local g = vim.g
vim.opt.termguicolors = true

dofile("/home/mateusc/.config/nixpkgs/pkgs/nvim/lua/galaxyline.lua")
dofile("/home/mateusc/.config/nixpkgs/pkgs/nvim/lua/lsp.lua")
dofile("/home/mateusc/.config/nixpkgs/pkgs/nvim/lua/nvim-tree.lua")

vim.cmd [[
    autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
    filetype plugin indent on 
    syntax enable
    "set spelllang=en,pt_br"
    "set spellsuggest=best,9"
    nnoremap <silent> <F11> :set spell!<cr>
    inoremap <silent> <F11> <C-O>:set spell!<cr>
    function! Preserve(command)
      let w = winsaveview()
      execute a:command
      call winrestview(w)
    endfunction
    colorscheme palenight
    autocmd BufWinEnter NvimTree setlocal nonumber
    highlight IndentBlanklineChar guifg = #393b4d
    au FileType markdown setlocal wrap linebreak spell
    augroup cmdline
        autocmd!
        autocmd CmdlineLeave : echo ''
    augroup end
    let g:dashboard_default_executive ='telescope'
    let g:indentLine_fileTypeExclude = ['dashboard']
    autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2
    let g:dashboard_custom_shortcut={
\ 'last_session'       : 'NaN',
\ 'find_history'       : 'NaN',
\ 'find_file'          : 'C-f',
\ 'new_file'           : 'NaN',
\ 'change_colorscheme' : 'NaN',
\ 'find_word'          : 'C-n',
\ 'book_marks'         : 'NaN',
\ }
map <silent> k gk
map <silent> j gj
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk
" VimTex "
filetype plugin indent on

syntax enable

let g:vimtex_view_method = 'zathura'

let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

let g:vimtex_compiler_method = 'latexrun'

let maplocalleader = " "

    set shiftwidth=4

let g:Tex_IgnoredWarnings = 
    \'Underfull'."\n".
    \'Overfull'."\n".
    \'specifier changed to'."\n".
    \'You have requested'."\n".
    \'Missing number, treated as zero.'."\n".
    \'There were undefined references'."\n".
    \'Citation %.%# undefined'."\n".
    \'Double space found.'."\n"
let g:Tex_IgnoreLevel = 8
]]

-- Enable plugins
require('bufferline').setup{}
-- require('pears').setup()
require('nvim_comment').setup()
require'sniprun'.setup({
    display = {"VirtualTextOk", "VirtualTextErr"},
})
require('colorizer').setup()
require("project_nvim").setup {}
require("todo-comments").setup {}
local cb = require'diffview.config'.diffview_callback
require'diffview'.setup {
  diff_binaries = false,    -- Show diffs for binaries
  enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
  use_icons = true,         -- Requires nvim-web-devicons
  icons = {                 -- Only applies when use_icons is true.
    folder_closed = "",
    folder_open = "",
  },
  signs = {
    fold_closed = "",
    fold_open = "",
  },
  file_panel = {
    position = "left",                  -- One of 'left', 'right', 'top', 'bottom'
    width = 35,                         -- Only applies when position is 'left' or 'right'
    height = 10,                        -- Only applies when position is 'top' or 'bottom'
    listing_style = "tree",             -- One of 'list' or 'tree'
    tree_options = {                    -- Only applies when listing_style is 'tree'
      flatten_dirs = true,              -- Flatten dirs that only contain one single dir
      folder_statuses = "only_folded",  -- One of 'never', 'only_folded' or 'always'.
    },
  },
  file_history_panel = {
    position = "bottom",
    width = 35,
    height = 16,
    log_options = {
      max_count = 256,      -- Limit the number of commits
      follow = false,       -- Follow renames (only for single file)
      all = false,          -- Include all refs under 'refs/' including HEAD
      merges = false,       -- List only merge commits
      no_merges = false,    -- List no merge commits
      reverse = false,      -- List commits in reverse order
    },
  },
  default_args = {    -- Default args prepended to the arg-list for the listed commands
    DiffviewOpen = {},
    DiffviewFileHistory = {},
  },
  hooks = {},         -- See ':h diffview-config-hooks'
  key_bindings = {
    disable_defaults = false,                   -- Disable the default key bindings
    view = {
      ["<tab>"]      = cb("select_next_entry"),  -- Open the diff for the next file
      ["<s-tab>"]    = cb("select_prev_entry"),  -- Open the diff for the previous file
      ["gf"]         = cb("goto_file"),          -- Open the file in a new split in previous tabpage
      ["<C-w><C-f>"] = cb("goto_file_split"),    -- Open the file in a new split
      ["<C-w>gf"]    = cb("goto_file_tab"),      -- Open the file in a new tabpage
      ["<leader>e"]  = cb("focus_files"),        -- Bring focus to the files panel
      ["<leader>b"]  = cb("toggle_files"),       -- Toggle the files panel.
    },
    file_panel = {
      ["j"]             = cb("next_entry"),           -- Bring the cursor to the next file entry
      ["<down>"]        = cb("next_entry"),
      ["k"]             = cb("prev_entry"),           -- Bring the cursor to the previous file entry.
      ["<up>"]          = cb("prev_entry"),
      ["<cr>"]          = cb("select_entry"),         -- Open the diff for the selected entry.
      ["o"]             = cb("select_entry"),
      ["<2-LeftMouse>"] = cb("select_entry"),
      ["-"]             = cb("toggle_stage_entry"),   -- Stage / unstage the selected entry.
      ["S"]             = cb("stage_all"),            -- Stage all entries.
      ["U"]             = cb("unstage_all"),          -- Unstage all entries.
      ["X"]             = cb("restore_entry"),        -- Restore entry to the state on the left side.
     ["R"]             = cb("refresh_files"),        -- Update stats and entries in the file list.
      ["<tab>"]         = cb("select_next_entry"),
      ["<s-tab>"]       = cb("select_prev_entry"),
      ["gf"]            = cb("goto_file"),
      ["<C-w><C-f>"]    = cb("goto_file_split"),
      ["<C-w>gf"]       = cb("goto_file_tab"),
      ["i"]             = cb("listing_style"),        -- Toggle between 'list' and 'tree' views
      ["f"]             = cb("toggle_flatten_dirs"),  -- Flatten empty subdirectories in tree listing style.
      ["<leader>e"]     = cb("focus_files"),
      ["<leader>b"]     = cb("toggle_files"),
    },
    file_history_panel = {
      ["g!"]            = cb("options"),            -- Open the option panel
      ["<C-A-d>"]       = cb("open_in_diffview"),   -- Open the entry under the cursor in a diffview
      ["y"]             = cb("copy_hash"),          -- Copy the commit hash of the entry under the cursor
      ["zR"]            = cb("open_all_folds"),
      ["zM"]            = cb("close_all_folds"),
      ["j"]             = cb("next_entry"),
      ["<down>"]        = cb("next_entry"),
      ["k"]             = cb("prev_entry"),
      ["<up>"]          = cb("prev_entry"),
      ["<cr>"]          = cb("select_entry"),
      ["o"]             = cb("select_entry"),
      ["<2-LeftMouse>"] = cb("select_entry"),
      ["<tab>"]         = cb("select_next_entry"),
      ["<s-tab>"]       = cb("select_prev_entry"),
      ["gf"]            = cb("goto_file"),
      ["<C-w><C-f>"]    = cb("goto_file_split"),
      ["<C-w>gf"]       = cb("goto_file_tab"),
      ["<leader>e"]     = cb("focus_files"),
      ["<leader>b"]     = cb("toggle_files"),
    },
    option_panel = {
      ["<tab>"] = cb("select"),
      ["q"]     = cb("close"),
    },
  },
}

vim.o.shell = "zsh"

local wk = require("which-key")

-- require("which-key").setup{}

require("toggleterm").setup{
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
}
require('specs').setup{ 
    show_jumps  = true,
    min_jump = 30,
    popup = {
        delay_ms = 0,
        inc_ms = 10,
        blend = 10,
        width = 10,
        winhl = "PMenu",
        fader = require('specs').linear_fader,
        resizer = require('specs').shrink_resizer
    },
    ignore_filetypes = {},
    ignore_buftypes = {
        nofile = true,
    },
}
-- local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

vim.opt.spell = true
vim.opt.spelllang = { 'en_us', 'pt_br' }
--require('cmp').setup {
  --sources = {
  --  { name = 'spell' }
 -- }
--}

-- Treesitter settings
 require'nvim-treesitter.configs'.setup {
   ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
}

-- Strip trailing whitespaces on save
vim.api.nvim_create_autocmd(
    "BufWritePre",
    { pattern = "*", command = "%s/\\s\\+$//e" }
)

local map = vim.api.nvim_set_keymap
function map2(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
options = { noremap = true }

function get_file_executable_lines(file)
    local file_extension = vim.fn.fnamemodify(file, ":e")
    if file_extension == "py" then
        return [[#!/usr/bin/env cached-nix-shell
#! nix-shell -p python310 -i "python3.10" --quiet
]]
    elseif file_extension == "rb" then
        return [[#!/usr/bin/env cached-nix-shell
#! nix-shell -p ruby -i "ruby" --quiet
]]
    elseif file_extension == "js" then
        return [[#!/usr/bin/env cached-nix-shell
        #! nix-shell -p nodejs -i "nodejs" --quiet
]]
    elseif file_extension == "lua" then
        return [[#!/usr/bin/env cached-nix-shell
        #! nix-shell -p lua -i "lua" --quiet
]]
    elseif file_extension == "sh" then
        return [[#!/usr/bin/env bash
]]
    else
        return ""
    end
end

function get_file_name_and_change_it_extension_than_return_it(extension)
    local file_name = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":e")
    return vim.fn.fnamemodify(file_name, ":e") .. extension
end

function run_cpp()
    output_file = get_file_name_and_change_it_extension_than_return_it(".out")
    vim.cmd(":TermExec cmd=\"g++ -std=c++17 -o " .. output_file .. " " .. vim.fn.expand("%:p") .. "\"")
    vim.cmd(":TermExec cmd=\"./" .. output_file .. "\"")
end


function commit_shortcut()
	local message = vim.fn.input('Enter commit message: ')
	if (message == '') then
        return
	end
	vim.cmd(":TermExec cmd=\'git commit -m \"" .. message .. "\"\'")
end

function term_command()
	local message = vim.fn.input('Enter command: ')
	if (message == '') then
		message = '^C'
	end
	vim.cmd(":TermExec cmd=\'" .. message .. "\'")
end

function append_executable()
    vim.cmd("silent w")
    local file = vim.fn.expand("%:p")
    local executable_lines = get_file_executable_lines(file)
    local f = assert(io.open(file, "rb"))
    local file_content = f:read("*all")
    local new_file_content = executable_lines .. file_content
    local writeble_file = io.open(file, "w")
    writeble_file:write(new_file_content)
    writeble_file:close()
    vim.cmd("silent e!")
end

-- Lazygit terminal
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("Closing terminal")
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end
-- Mapping each key to which-key
wk.register({
    ["<Space>"] = {
        g = {
            name = "+git",
            o = { ":DiffviewOpen<CR>", "Open a diff view window" },
            q = { ":DiffviewClose<CR>", "Close the diff view window" },
            a = { ":TermExec cmd=\"git add %\"<CR>", "Add the current file to the staging area" },
            c = { ":lua commit_shortcut()<CR>", "Commit the current file" },
            g = { ":TermExec cmd=\"git push -u origin main\"<CR>", "Push the current file to the remote repository" },
            l = { ":lua _lazygit_toggle()<CR>", "Toggle the lazygit terminal" },
        },
        s = {
            name = "+shell",
            o = { ":TermExec cmd=\"clear\"<CR>", "Clear the terminal" },
            q = { ":TermExec cmd=\"exit\"<CR>", "Exit the terminal" },
            l = { ":TermExec cmd=\"!!\"<CR>", "Run the last command" },
            t = { ":ToggleTerm size=75<CR>", "Toggle the terminal size" },
            s = { ":TermExec cmd=\"xclip -sel c -o | pygmentize -f html | xclip -sel c\"<CR>", "Copy the current line to the clipboard" },
            f = { ":TermExec cmd=\"home-manager switch\"<CR>", "Switch to the next available workspace" },
            p = { ":cd ~/.config <bar> :pwd <CR>", "Print the current directory" },
            j = { ":TermExec cmd=\"npm run dev\"<CR>", "Run the development server" },
            r = { ":TermExec cmd=\"npm start\"<CR>", "Run the production server" },
            g = { ":TermExec cmd=\"git push -u origin main\"<CR>", "Push the current file to the remote repository" },
            k = { ":w % <bar> :TermExec cmd=\"./%\"<CR>", "Run the current file" },
        },
        p = {
            name = "+dotfiles",
            p = { ":cd ~/.config <bar> :pwd <CR>", "Go to the ~/.config dir" },
            f = { ":w % <bar> :TermExec cmd=\"home-manager switch\"<CR>", "Switch to the newest home-manager derivation" },
        },
        f = {
            name = "+files",
            f = { ":Telescope find_files<CR>", "Find files" },
            n = { ":Telescope live_grep<CR>", "Live grep" },
            o = {  ":Telescole old_files<CR>", "Old files" },
            e = {  ":enew<CR>", "New file" },
            t = {  ":tabnew<CR>", "New tab" },
            m = {  ":TZAtaraxis<CR>", "TZAtaraxis - Minimalist mode" },
        },
        t = {
            name = "*tabs",
            n = { ":tabnew<CR>", "New tab" },
            h = { ":tabnext<CR>", "Next tab" },
            l = { ":tabprevious<CR>", "Previous tab" },
            q = { ":tabclose<CR>", "Close tab" },
            w = { ":tabmove %<CR>", "Move tab to %" },
        },
        q = {":q<CR>", "Quit the current window"},
        n = {":Telescope projects<CR>", "Open the project manager"},
        w = {":w %<CR>", "Save the current file"},
        r = {":lua append_executable()<CR>", "Append the line that makes a file executable to the file"},
        a = {
            name = "*telescope",
            a = { ":Telescope find_files<CR>", "Find files" },
            n = { ":Telescope live_grep<CR>", "Live grep" },
            o = {  ":Telescole old_files<CR>", "Old files" },
            c = {
                name = "*commands",
                c = { ":Telescope commands<CR>", "Commands" },
                o = { ":Telescope commands_history<CR>", "Old commands used" },
            },
            s = { ":Telescope colorscheme<CR>", "Color schemes" },
            m = { ":Telescope marks<CR>", "Marks" },
            t = { ":Telescope tresitter<CR>", "Tags" },
            h = { ":Telescope spellsuggest<CR>", "Spell suggestions" },
            f = { ":Telescope filetypes<CR>", "Filetypes" },
            b = { ":Telescope buffers<CR>", "Buffers" },
        },
        l = {
            name = "*lsp",
            r = { ":Telescope lsp_references<CR>", "References" },
            i = { ":Telescope lsp_document_symbols<CR>", "Document symbols" },
            c = {
                name = "*code_actions",
                c = { ":Telescope lsp_code_actions<CR>", "Code actions" },
                r = { ":Telescope lsp_range_code_actions<CR>", "Range code actions" },
            },
            w = {
                name = "*workspace_symbols",
                w = { ":Telescope lsp_workspace_symbols<CR>", "Workspace symbols" },
                s = { ":Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace symbols search" },
            },

        },
    },
    ["<C-m>"] = {":CommentToggle <CR>", "Toggle current line comments"},
    ["<C-o"] = {":NvimTreeToggle <CR>", "Toggle the neovim tree window"},
    ["<C-s>"] = {":'<,>SnipRun <CR>", "Run a snippet"},
    ["<C-f>"] = {":Telescope find_files <CR>", "Find files"},
    ["<C-n>"] = {":Telescope live_grep <CR>", "Live grep"},
    ["<C-l>"] = {":noh <CR>", "Noh"},
    ["<C-t>"] = {":ToggleTerm size=75 direction=vertical <CR>", "Toggle the terminal size"},
    ["<CR>"] = {":CommentToggle<CR>", "Toggle current line comment"}
})

wk.setup{
  plugins = {
    spelling = {
      enabled = true,
    },
  },
}

-- Indent line
vim.opt.list = true
vim.opt.listchars:append("space:⋅")

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
-- Performance
opt.lazyredraw = true;
opt.shell = "zsh"
opt.shadafile = "NONE"

-- Colors
opt.termguicolors = true

-- Undo files
opt.undofile = true

-- Indentation
opt.smartindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.shiftround = true
opt.expandtab = true
opt.scrolloff = 3

-- Set clipboard to use system clipboard
opt.clipboard = "unnamedplus"

-- Use mouse
opt.mouse = "a"

-- Nicer UI settings
opt.cursorline = true
opt.relativenumber = true
opt.number = true

-- Get rid of annoying viminfo file
opt.viminfo = ""
opt.viminfofile = "NONE"

-- Miscellaneous quality of life
opt.ignorecase = true
opt.ttimeoutlen = 5
opt.compatible = false
opt.hidden = true
opt.shortmess = "atI"
opt.wrap = true
opt.linebreak = true
opt.backup = false
opt.writebackup = false
opt.errorbells = false
opt.swapfile = false
opt.showmode = false
