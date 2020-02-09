# ci


### Gitflow :

1. develop branch is created from master
2. release branch is created from develop
3. feature branches are created from develop
4. When a feature is complete it is merged into the develop branch
5. When the release branch is done it is merged into develop and master
6. If an issue in master is detected a hotfix branch is created from master
7. Once the hotfix is complete it is merged to both develop and master

### Merging To Master:

1. setup the git-flow project
2. create branches and merge everything to develop
3. run the command git flow release start <version_number>
4. then provide a meaningful message for the release
5. run the command git flow release finish <version_number>
6. it will merge everything into master and change the branch to master.
7. run the command git push to publish the changes to the remote master.

References:
1. https://www.toptal.com/software/trunk-based-development-git-flow
2. https://github.com/nvie/gitflow