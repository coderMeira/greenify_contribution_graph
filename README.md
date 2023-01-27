# greenify_contribution_graph
This script modifies the commit history of a Git repository, changing the name and email of all commits.

You might have noticed that the GitHub contribution graph (the green squares) on your main profile page do not do justice to the amount of hard-working commits you've done in the past. This might be because when you work on different computers, your local git is using by default a different email than your official one. When GitHub is patching the commits and it see's that these emails don't match, it doesn't associate them to your account So, the solution I found was the following: re-write all commits authorship in each of these "ghost repositories", in order for GitHub to take them into account and hopefully show the world a beautiful green garden in our calendar :green_heart:

## I propose you two ways of accomplishing this:
### 1) Official/very new solution - This is the recommended way. 
(I use git filter-branch on my script, which although is the traditional solution, has recently been considered slow and deprecated). GitHub now recommends using git filter-repo instead. To do this, simply download this file and run the following commands:
git clone --bare *repository_link_here*
cp git-filter-repo *repository*
cd *repository*
python3 git-filter-repo --email-callback 'return email if email == b"your_official_email@email.com" else b"your_official_email@email.com"'
git fetch
git push --force --tags origin 'refs/heads/*'
(if you're lazy you can just place this script in your $PATH, then you can shorten commands by replacing python3 git-filter-repo with git filter-repo all over the place)

