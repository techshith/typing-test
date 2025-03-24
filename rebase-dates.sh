#!/bin/bash

# 🛠️ STEP 1: Start an interactive rebase from the root
echo "Starting interactive rebase..."
git rebase -i --root

# 🔁 STEP 2: Replace 'pick' with 'edit' for all commits, save and close the editor
echo "📌 IMPORTANT: Replace 'pick' with 'edit' for each commit, then save and exit the editor."

read -p "Press [Enter] once you've edited and saved the rebase file..."

# 📅 STEP 3: Backdate each commit
commits=(
  "2021-09-18T10:15:34"
  "2021-09-20T14:45:50"
  "2021-09-23T11:22:45"
  "2021-09-28T16:08:12"
  "2021-10-05T12:11:05"
  "2021-10-10T13:28:00"
  "2021-10-10T18:20:30"
  "2021-11-21T10:30:00"
)

i=0

for date in "${commits[@]}"; do
  echo "⏳ Amending commit $((i+1)) with date: $date"
  GIT_COMMITTER_DATE="$date" git commit --amend --no-edit --date "$date"
  git rebase --continue
  ((i++))
done

echo "✅ All commits have been backdated successfully!"
