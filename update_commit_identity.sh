#!/bin/sh

# DESCRIPTION:
# This script modifies the commit history of a Git repository, changing the name and email of all commits.

# DISCLAIMER:
# I use git filter-branch on my script, which although is the traditional solution, 
# has recently been considered slow and deprecated). 
# GitHub now recommends using git filter-repo instead. 
# To do this, simply download this file (https://raw.githubusercontent.com/newren/git-filter-repo/main/git-filter-repo) 
# and run the following commands:
# git clone --bare *repository_link_here*
# cp git-filter-repo *repository*
# cd *repository*
# python3 git-filter-repo --email-callback 'return email if email == b"your_official_email@email.com" else b"your_official_email@email.com"'
# git fetch
# git push --force --tags origin 'refs/heads/*'

# (if you're lazy you can just place this script in your $PATH, then you can shorten commands by replacing python3 git-filter-repo with git filter-repo all over the place)

# INSTRUCTIONS:
# 1 - Save the script to a file: "update_commit_identity.sh"
# 2 - Replace the NAME and EMAIL variables with the ones associated with your account on GitHub.com
# 3 - Change file permissions with the chmod 777 command: chmod 777 update_commit_identity.sh
# 4 - Create a bare clone of the desired repository: git clone --bare https://github.com/user/repo.git
# 5 - Run the script inside the repository with the "./" command: ./update_commit_identity.sh

# WARNING:
# Be careful if you have a multi-user repository.
# This script will modify the commit history of the repository, which can
# cause conflicts if other people have already cloned or forked the repository.
# It is best to do this only on repositories that you own and have complete control over.


# Change these variables accordingly
NAME="YOUR_NAME_HERE"
EMAIL="YOUR_EMAIL_HERE"

# Setting right name and email on user's git config, to avoid having to run this script again in the future
if ! git config --get user.name | grep "$NAME";
then
        git config --global user.name "$NAME"
fi;
if ! git config --get user.email | grep "$EMAIL";
then
        git config --global user.email "$EMAIL"
fi;

# Modify the current repo's commits names and emails
git filter-branch --force --commit-filter '
        if [ "$GIT_COMMITTER_EMAIL" != '"$EMAIL"' -o "$GIT_COMMITTER_EMAIL" != '"$EMAIL"' ];
        then
                export GIT_COMMITTER_NAME='"$NAME"';
                export GIT_AUTHOR_NAME='"$NAME"';
                export GIT_COMMITTER_EMAIL='"$EMAIL"';
                export GIT_AUTHOR_EMAIL='"$EMAIL"';
        fi;
        git commit-tree $@
' --tag-name-filter cat -- --all

git filter-branch --env-filter;

# Delete replacement commits (https://stackoverflow.com/questions/47839542/failed-git-replace-replace-depth-too-high-for-object)
for HASHID in $(git replace -l) ; do
    git replace -d "${HASHID}"
done

git fetch;
git push --force --tags origin 'refs/heads/*'
