#!/bin/bash
function check_git_status() {
 if git status | grep -q "nothing to commit, working tree clean"; then
  echo "Nothing to commit, working tree clean"
  return 0
else
  echo "Có sự thay đổi trong code."
  return 1
fi
}
function check_merge_conflict() {
# Kiểm tra xem Git hiện tại có bị conflict hay không
if git status | grep -q "both modified\|both deleted"; then
  echo "Git hiện tại đang bị conflict -- tu fix bang tay di"
  git merge --abort
else
  echo "Git hiện tại không bị conflict"
fi
}
function pull_master_branch() {
  git checkout master
  git pull origin master
  git checkout -
}
echo "pull code project MP IELTS"
echo "tam thời thì mặc định pull origin master, sau này thêm params sau"
pwd

# Kiểm tra trạng thái của repository
if check_git_status "1 -eq 1"; then
  echo "True"
  pull_master_branch
  git merge master
  check_merge_conflict

else
  echo "False"
  git stash
  pull_master_branch
  git merge master
  git merge master
  check_merge_conflict
  git stash pop
fi

# next to es_game
cd ..
cd es_game
echo "PULL ES_GAMEEEEEEEEE"
# Kiểm tra trạng thái của repository
if check_git_status "1 -eq 1"; then
  echo "True"
  pull_master_branch
  git merge master
  check_merge_conflict

else
  echo "False"
  git stash
  pull_master_branch
  git merge master
  git merge master
  check_merge_conflict
  git stash pop
fi
# next to es_models
cd ..
cd es_models
echo "PULLlllllllllll es_models"

if check_git_status "1 -eq 1"; then
  echo "True"
  pull_master_branch
  git merge master
  check_merge_conflict

else
  echo "False"
  git stash
  pull_master_branch
  git merge master
  git merge master
  check_merge_conflict
  git stash pop
fi

# next to mp_models

cd ..
cd mp_models
echo "PULLlllllllllll es_models"

if check_git_status "1 -eq 1"; then
  echo "True"
  pull_master_branch
  git merge master
  check_merge_conflict

else
  echo "False"
  git stash
  pull_master_branch
  git merge master
  git merge master
  check_merge_conflict
  git stash pop
fi