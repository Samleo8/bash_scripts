#!/bin/bash
sudo apt install keychain
ssh-keygen -t ed25519 -C samleocw@gmail.com

# Add the following to ~/.bashrc
echo "eval `keychain --eval --agents ssh id_ed25519`" >> `~/.bashrc`

# Start the ssh-agent in the background
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Print the public key to copy to GitHub
echo "Copy the following public key to GitHub > Settings > Add SSH key"
cat ~/.ssh/id_ed25519.pub