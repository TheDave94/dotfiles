#!/bin/sh

echo "Start Git configuration now."
echo "Press enter to continue..."
read

echo "----------------------------------"
echo "Perform Git configuration."
echo "----------------------------------"

echo "Enter the name you want to use for Git:"
read git_name
echo "---------------------------------------------------------------"
echo "Enter the e-mail you want to use for Git:"
read git_email

git config --global user.name "$git_name"
git config --global user.email "$git_email"

echo "---------------------------------------------------------------"
echo "The following name has been set:"
git config --global user.name

echo "---------------------------------------------------------------"
echo "The following email has been set:"
git config --global user.email