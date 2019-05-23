#!/bin/bash
ALL=0
PACKAGE_FILE="package-list.txt"
CHANGED_CONFIG_FILE="modified-configs.txt"

# Usage and getopts
print_usage() {
  printf "Description: Save list of packages installed in this system via yay"
  printf "Usage:"
  printf "\t-a\tSave all packages rather than those explicitly installed."
  printf "\t-f\tFile to save the list to. Default: $PACKAGE_FILE"
  printf "\t-g\tFile to save list of modified configs to. Default $OPTIONS_FILE"
}

while getopts 'af:g:' flag; do
  case "${flag}" in
    a) ALL=1 ;;
    f) PACKAGE_FILE="${OPTARG}" ;;
    g) CHANGED_CONFIG_FILE="${OPTARG}" ;;
    *) print_usage
       exit 1 ;;
  esac
done

# Save list of installed packages
echo "Saving list of packages installed into $PACKAGE_FILE. Use the -f flag to specify saving to a different file..."

if [ $ALL -eq 1 ]; then
	yay -Qeq > $PACKAGE_FILE
else
	yay -Qeeq > $PACKAGE_FILE
fi

echo "List of packages saved into $PACKAGE_FILE"
echo "To install the packages, yay -Syu --needed \$(cat package-list.txt)"
echo -e "Alternatively, run the full_install_arch.sh script which will first install yay, and then run the above command.\n"

# Saving of modified config files
echo "Saving list of modified config files installed into $CHANGED_CONFIG_FILE... Use the -g flag to specify saving to a different file."

yay -Qii | grep -e "^MODIFIED" | cut -f 2 > $CHANGED_CONFIG_FILE

echo "List of modified configs saved into $CHANGED_CONFIG_FILE"
