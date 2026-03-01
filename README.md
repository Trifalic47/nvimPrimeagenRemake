# ⚡ Trifalic47's Neovim Config (Primeagen Remake)

**Trifalic47 remake this ThePrimeagen config which is error free.**

This is a refined, ultra-fast, and stable Neovim configuration based on [ThePrimeagen's dotfiles](https://github.com/ThePrimeagen/init.lua). It has been debugged and optimized to ensure all plugins load correctly without permission or path errors.

---

## 🚀 Features
- **Zero Errors**: Fixed all local path issues, permissions, and Luarocks build errors.
- **Ultra-Fast Performance**: Minimalist approach using [Lazy.nvim](https://github.com/folke/lazy.nvim).
- **Modern LSP**: Pre-configured Language Server Protocol support with auto-completion.
- **Harpoon 2**: The latest version of Harpoon for lightning-fast file switching.
- **Optimized UI**: Includes Rose Pine, Tokyonight, and support for transparent backgrounds.

---

## 🛠️ Installation & Setup

### 1. Prerequisite
Ensure you have `ripgrep` installed:
```bash
# Arch Linux
sudo pacman -S ripgrep
```

### 2. Fix Permissions
If you encounter permission denied errors, ensure your config is owned by your user:
```bash
sudo chown -R $USER:$USER ~/.config/nvim
```

### 3. Apply Config
If you are using the `antigravity` fix files:
```bash
cp -r /home/tanishq/.gemini/antigravity/scratch/nvim_fix/* ~/.config/nvim/
```

---

## ⌨️ Essential Keybinds

### Navigation
- `<leader>pv`: Open File Explorer (Netrw)
- `<C-d>` / `<C-u>`: Scroll Down/Up (Centered)
- `n` / `N`: Next/Prev Search Result (Centered)

### The "Super-Powers"
- `<leader>p`: Paste over selection without losing your yanked text.
- `<leader>y`: Yank directly to system clipboard.
- `<leader>s`: Global search and replace for the word under cursor.

### Harpoon 2
- `<leader>a`: Add file to marks.
- `<C-e>`: Toggle Harpoon menu.
- `<Alt+1..4>`: Instantly jump to marks.

---

## 💎 Credits
- **Original Base**: [ThePrimeagen](https://github.com/ThePrimeagen)
- **Error-Free Remake**: **Trifalic47**
