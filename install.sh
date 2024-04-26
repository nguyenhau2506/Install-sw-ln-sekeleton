#!/bin/bash

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (sudo)."
    exit 1
fi

# Exit immediately on non-zero status
set -e

# Update package repositories
echo "Updating package repositories..."
apt update
echo "Package repositories updated successfully."

# Install necessary packages for Docker and Chrome
echo "Installing prerequisites..."
apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common wget

# Install Git
echo "Installing Git..."
apt install -y git
echo "Git installed successfully."

# Install Docker
echo "Installing Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt update
apt install -y docker-ce docker-ce-cli containerd.io
echo "Docker installed successfully."

# Install Google Chrome
echo "Installing Chrome..."
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
apt update
apt install -y google-chrome-stable
echo "Chrome installed successfully."

# Install CURL
echo "Installing CURL..."
apt install -y curl
echo "CURL installed successfully."

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
apt install -y zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "Oh My Zsh installed successfully."

# Configure Zsh environment
echo "Configuring Zsh environment..."
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="your_theme"/' ~/.zshrc

# Clone zsh-autosuggestions plugin
echo "Cloning zsh-autosuggestions plugin..."
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
echo "zsh-autosuggestions plugin installed successfully."

# Update Zsh configuration to enable the plugin
echo "Enabling zsh-autosuggestions plugin..."
sed -i 's/plugins=(git your_plugins)/plugins=(git zsh-autosuggestions)/' ~/.zshrc
echo "zsh-autosuggestions plugin enabled successfully."

# Set Zsh as the default shell
chsh -s /usr/bin/zsh $USER

# Install NVM (Node Version Manager)
echo "Installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
echo "NVM installed successfully."

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Install Node.js
echo "Installing Node.js..."
nvm install node
echo "Node.js installed successfully."

# Install pnpm
echo "Installing pnpm..."
npm install -g pnpm
echo "pnpm installed successfully."

# Install Yarn
echo "Installing Yarn..."
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
apt update
apt install -y yarn
echo "Yarn installed successfully."

# Install Docker Compose
echo "Installing Docker Compose..."
apt install -y docker-compose
echo "Docker Compose installed successfully."

# Add user to the docker group and apply changes
usermod -aG docker $USER
newgrp docker

echo "Finished Installing Programs!"
