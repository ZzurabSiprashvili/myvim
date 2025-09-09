#!/bin/bash

# ============================================================================
# NEOVIM CONFIGURATION BOOTSTRAP SCRIPT
# ============================================================================
# This script automates the setup of a complete Neovim development environment
# with LSP support, formatters, linters, and all necessary tools.

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Get OS information
get_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
        echo "windows"
    else
        echo "unknown"
    fi
}

# Check prerequisites
check_prerequisites() {
    log_info "Checking prerequisites..."

    local missing_deps=()

    # Check Neovim
    if ! command_exists nvim; then
        missing_deps+=("neovim")
    else
        local nvim_version=$(nvim --version | head -n1 | grep -oP '\d+\.\d+\.\d+')
        log_info "Neovim version: $nvim_version"
        if [[ "$(printf '%s\n' "$nvim_version" "0.11.0" | sort -V | head -n1)" != "0.11.0" ]]; then
            log_warning "Neovim version $nvim_version detected. Recommended: 0.11.0+"
        fi
    fi

    # Check Git
    if ! command_exists git; then
        missing_deps+=("git")
    fi

    # Check Node.js
    if ! command_exists node; then
        missing_deps+=("nodejs")
    else
        local node_version=$(node --version | sed 's/v//')
        log_info "Node.js version: $node_version"
    fi

    # Check Python
    if ! command_exists python3; then
        missing_deps+=("python3")
    else
        local python_version=$(python3 --version 2>&1 | grep -oP '\d+\.\d+')
        log_info "Python version: $python_version"
    fi

    # Check ripgrep
    if ! command_exists rg; then
        missing_deps+=("ripgrep")
    fi

    # Check fd
    if ! command_exists fd; then
        missing_deps+=("fd")
    fi

    if [ ${#missing_deps[@]} -ne 0 ]; then
        log_error "Missing dependencies: ${missing_deps[*]}"
        log_info "Please install missing dependencies and run the script again."
        exit 1
    fi

    log_success "All prerequisites met!"
}

# Install system dependencies
install_system_deps() {
    local os=$(get_os)

    case $os in
        "macos")
            log_info "Installing dependencies on macOS..."

            if command_exists brew; then
                brew install ripgrep fd neovim node python3 git
            else
                log_error "Homebrew not found. Please install Homebrew first:"
                log_info "https://brew.sh/"
                exit 1
            fi
            ;;

        "linux")
            log_info "Installing dependencies on Linux..."

            if command_exists apt; then
                sudo apt update
                sudo apt install -y ripgrep fd-find neovim nodejs npm python3 python3-pip git
            elif command_exists dnf; then
                sudo dnf install -y ripgrep fd-find neovim nodejs npm python3 python3-pip git
            elif command_exists pacman; then
                sudo pacman -S --noconfirm ripgrep fd neovim nodejs npm python python-pip git
            else
                log_warning "Unknown package manager. Please install dependencies manually:"
                log_info "  - ripgrep"
                log_info "  - fd"
                log_info "  - neovim"
                log_info "  - nodejs"
                log_info "  - python3"
                log_info "  - git"
            fi
            ;;

        *)
            log_warning "Unsupported OS: $os"
            log_info "Please install dependencies manually and run the script again."
            exit 1
            ;;
    esac
}

# Setup Python environment
setup_python() {
    log_info "Setting up Python environment..."

    # Install pip if not present
    if ! command_exists pip3; then
        python3 -m ensurepip --upgrade
    fi

    # Install Python LSP and tools
    pip3 install --user --upgrade \
        python-lsp-server \
        pylsp-mypy \
        pylsp-rope \
        pylsp-black \
        python-lsp-ruff \
        ruff \
        black \
        isort \
        mypy

    log_success "Python environment configured!"
}

# Setup Node.js environment
setup_nodejs() {
    log_info "Setting up Node.js environment..."

    # Install TypeScript and related tools
    npm install -g typescript typescript-language-server \
        @typescript-eslint/eslint-plugin \
        @typescript-eslint/parser \
        eslint \
        prettier \
        vscode-langservers-extracted \
        yaml-language-server \
        bash-language-server

    log_success "Node.js environment configured!"
}

# Backup existing configuration
backup_existing_config() {
    local config_dir="$HOME/.config/nvim"
    local backup_dir="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"

    if [ -d "$config_dir" ] && [ ! -L "$config_dir" ]; then
        log_warning "Existing Neovim configuration found."
        log_info "Creating backup: $backup_dir"
        cp -r "$config_dir" "$backup_dir"
        log_success "Backup created successfully!"
    fi
}

# Install Neovim configuration
install_config() {
    local config_dir="$HOME/.config/nvim"

    log_info "Installing Neovim configuration..."

    # Create config directory
    mkdir -p "$config_dir"

    # Copy configuration files
    cp -r . "$config_dir/"

    # Remove bootstrap script from config
    rm -f "$config_dir/bootstrap.sh"

    log_success "Configuration installed successfully!"
}

# Install plugins
install_plugins() {
    log_info "Installing Neovim plugins..."

    # Install plugins using Lazy
    nvim --headless -c 'Lazy sync' -c 'qa'

    log_success "Plugins installed successfully!"
}

# Install language servers and tools
install_language_servers() {
    log_info "Installing language servers and tools..."

    # Install using Mason
    nvim --headless -c 'MasonInstall \
        pyright \
        ruff \
        black \
        isort \
        typescript-language-server \
        eslint-lsp \
        prettier \
        gopls \
        golangci-lint \
        rust-analyzer \
        clangd \
        lua-language-server \
        stylua \
        json-lsp \
        yaml-language-server \
        bash-language-server \
        dockerfile-language-server \
        terraform-lsp' -c 'qa'

    log_success "Language servers installed successfully!"
}

# Setup completion
setup_completion() {
    log_info "Setting up completion..."

    # Install friendly snippets
    nvim --headless -c 'Lazy load friendly-snippets' -c 'qa'

    log_success "Completion setup complete!"
}

# Post-installation message
post_install_message() {
    log_success "🎉 Neovim configuration setup complete!"
    echo
    log_info "Next steps:"
    echo "1. Start Neovim: nvim"
    echo "2. Run health check: :checkhealth"
    echo "3. Install additional language servers as needed: :Mason"
    echo
    log_info "Key mappings:"
    echo "  <leader>ff - Find files"
    echo "  <leader>fg - Live grep"
    echo "  <leader>gg - Open LazyGit"
    echo "  <leader>e  - Open file manager"
    echo "  gd         - Go to definition"
    echo "  <leader>ca - Code actions"
    echo
    log_info "Useful commands:"
    echo "  :Lazy     - Plugin manager"
    echo "  :Mason    - Language server manager"
    echo "  :LspInfo  - LSP status"
    echo "  :checkhealth - System health check"
    echo
    log_warning "If you encounter issues:"
    echo "1. Check the README.md for troubleshooting"
    echo "2. Run :checkhealth for diagnostics"
    echo "3. Check Mason for missing language servers"
}

# Main installation function
main() {
    echo "🚀 Neovim Configuration Bootstrap"
    echo "================================="
    echo

    # Check if we're in the right directory
    if [ ! -f "init.lua" ] || [ ! -f "lua/plugins/init.lua" ]; then
        log_error "Please run this script from the Neovim configuration directory."
        exit 1
    fi

    # Run installation steps
    check_prerequisites
    install_system_deps
    setup_python
    setup_nodejs
    backup_existing_config
    install_config
    install_plugins
    install_language_servers
    setup_completion
    post_install_message

    log_success "Setup complete! Happy coding! 🎉"
}

# Run main function
main "$@"
