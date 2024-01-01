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
sudo apt-get update
echo "Package repositories updated successfully."

#install chorme 
echo "Installing Chrome..."
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
echo "Chrome installed successfully."

# Install CURL
echo "Installing CURL..."
sudo apt-get install -y curl
echo "CURL installed successfully."

Install Oh My Zsh
echo "Installing Oh My Zsh..."
sudo apt-get install -y zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "Oh My Zsh installed successfully."

# Configure Zsh environment
echo "Configuring Zsh environment..."
# You can customize the Zsh theme and plugins based on your preferences
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="your_theme"/' ~/.zshrc

# Clone zsh-autosuggestions plugin
echo "Cloning zsh-autosuggestions plugin..."
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
echo "zsh-autosuggestions plugin installed successfully."

# Update Zsh configuration to enable the plugin
echo "Enabling zsh-autosuggestions plugin..."
sed -i 's/plugins=(git your_plugins)/plugins=(git zsh-autosuggestions)/' ~/.zshrc
echo "zsh-autosuggestions plugin enabled successfully."



# Set Zsh as the default shell
chsh -s /bin/zsh

# Install NVM
echo "Installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
echo "NVM installed successfully."

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Install Node.js
echo "Installing Node.js..."
nvm install stable
echo "Node.js installed successfully."

# Install pnpm
echo "Installing pnpm..."
npm install -g pnpm
echo "pnpm installed successfully."

# Install Yarn
echo "Installing Yarn..."
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install -y yarn
echo "Yarn installed successfully."


# Install Docker Compose
echo "Installing Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo "Docker Compose installed successfully."

# Verify installation
docker-compose --version
# Add user to the docker group and apply changes
sudo usermod -aG docker $USER
newgrp docker

# Install Visual Studio Code
echo "Installing Visual Studio Code..."
sudo apt-get install -y code
echo "Visual Studio Code installed successfully."

# Install cloudflare-warp
sudo apt install cloudflare-warp



# Set up environment variables for Android Studio (adjust paths as needed)
echo "export ANDROID_HOME=$HOME/Android/Sdk" >> ~/.zshrc
echo "export PATH=$PATH:$ANDROID_HOME/emulator" >> ~/.zshrc
echo "export PATH=$PATH:$ANDROID_HOME/platform-tools" >> ~/.zshrc


# Finish
echo "Finished Installing Programs!"
