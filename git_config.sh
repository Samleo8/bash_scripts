#!/bin/sh

git config --global alias.subinit '!git pull && git submodule update --init --recursive'
git config --global alias.update '!git pull && git submodule update --remote --recursive --merge'
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --globa alias.stat 'status'
