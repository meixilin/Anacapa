```bash
# get to "New-Master"
git checkout New-Master
# add Emily's stuff as the upstream github
git remote add upstream https://github.com/limey-bean/Anacapa.git
# git 
git fetch upstream 
# rebase meixi's New-Master to Emily's New-Master
git rebase upstream/New-Master
# now get to meixi's meixi branch 
git checkout meixi
# rebase meixi's meixi branch to meixi's New-Master
git rebase New-Master
## WARNING: THERE MIGHT BE A MERGE CONFLICT
```

here is a record on what I did: 

```bash
1007  git branch
 1008  git status
 1009  git log
 1010  git log 
 1011  git branch meixi
 1012  git log
 1013  git checkout New-Master
 1014  git branch
 1015  git checkout meixi
 1016  git log
 1017  git checkout New-Master
 1018  git reset --hard 755168360287a677c4be81794a484bc5dc0d70f4
 1019  git log
 1020  git remote --v
 1021  git remote add upstream https://github.com/limey-bean/Anacapa.git
 1022  git branch
 1023  git fetch upstream
 1024  git checkout New-Master
 1025  git rebase upstream/master
 1026  git checkout meixi
 1027  git rebase New-Master
 1028  git log
 1029  git checkout New-Master
 1030  git rebase upstream/New-Master
 1031  git log
 1032  git branch
 1033  git checkout meixi
 1034  git rebase New-Master
 1035  git log
```