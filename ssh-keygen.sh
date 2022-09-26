#!/bin/bash
sudo apt install keychain
ssh-keygen -t ed25519 -C samleocw@gmail.com

# Print the public key to copy to GitHub
echo "Copy the following public key to GitHub > Settings > Add SSH key"
cat ~/.ssh/id_ed25519.pub

# Start the ssh-agent in the background
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Add to ssh config
echo -e "Host *\n    AddKeysToAgent yes\n    UseKeychain yes\n    IdentityFile ~/.ssh/id_ed25519" >>~/.ssh/config
