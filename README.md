# greenify_contribution_graph
This script modifies the commit history of a Git repository, changing the name and email of all commits.

## DISCLAIMER
I use git filter-branch on my script, which although is the traditional solution, 
has recently been considered slow and deprecated). 
GitHub now recommends using git filter-repo instead. 
To do this, simply download [git-filter-repo](https://raw.githubusercontent.com/newren/git-filter-repo/main/git-filter-repo) 
and run the following commands:
```
git clone --bare *repository_link_here*
cp git-filter-repo *repository*
cd *repository*
python3 git-filter-repo --email-callback 'return email if email == b"your_official_email@email.com" else b"your_official_email@email.com"'
git fetch
git push --force --tags origin 'refs/heads/*'
```
(if you're lazy you can just place this script in your $PATH, then you can shorten commands by replacing python3 git-filter-repo with git filter-repo all over the place)

If for some reason the 1st way doesn't work, you can use the following script. 
This is based on a popular/most used solution used across the internet. 
To do this run the following script on the desired repository (after running git clone --bare *repo_link*), 
and please carefully read all the comments before doing so.

## INSTRUCTIONS
<ol>
<li>Save the script to a file: e.g. "update_commit_identity.sh"</li>
<li>Replace the NAME and EMAIL variables with the ones associated with your account on GitHub.com</li>
<li>Change file permissions with the chmod 777 command: <code>chmod 777 update_commit_identity.sh</code></li>
<li>Create a bare clone of the desired repository: <code>git clone --bare https://github.com/user/repo.git</code></li>
<li>Run the script inside the repository with the "./" command: <code>./update_commit_identity.sh</code></li>
</ol>

## WARNING
Be careful if you have a multi-user repository.
This script will modify the commit history of the repository, which can
cause conflicts if other people have already cloned or forked the repository.
It is best to do this only on repositories that you own and have complete control over.
