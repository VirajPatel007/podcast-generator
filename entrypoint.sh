#!/bin/bash
# This line indicates that the script should be run using the Bash shell.

# Print a separator line to make the output more readable
echo "================================="

# Configure Git with the username and email globally, using the environment variables GITHUB_ACTOR and INPUT_EMAIL.
# GITHUB_ACTOR is typically set in GitHub Actions workflows to the username of the person triggering the action. ${GITHUB_ACTOR} is an environment variable that represents the GitHub username of the user triggering the GitHub Actions workflow.
# INPUT_EMAIL is expected to be an input variable, possibly passed from a GitHub Action or environment. ${INPUT_EMAIL} is expected to be an environment variable (possibly provided by a GitHub Actions workflow input) that contains the email to be used for commits.
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${INPUT_EMAIL}"

# Configure Git to treat the current workspace as a "safe directory" for Git operations.
# This is needed because, in certain contexts (like GitHub Actions), Git might consider the workspace unsafe due to potential issues with ownership or security, and it needs to be explicitly marked as "safe" for Git to operate.
git config --global --add safe.directory /github/workspace

# Execute the Python script feed.py using Python 3.
# This script is likely designed to update or generate some kind of feed, possibly modifying files in the repository.
python3 /usr/bin/feed.py

# Stage all changes (including new files, modified files, and deleted files) in the repository for commit.
# `git add -A` stages everything in the repository, ensuring that all changes are prepared for commit.
# Commit the staged changes with a message "Update Feed". This creates a new commit in the local repository that contains the changes from the previous step.
git add -A && git commit -m "Update Feed"

# Push the local changes to the remote repository. 
git push --set-upstream origin main
# The --set-upstream flag tells Git to set the upstream branch for the local branch, so that Git knows which remote branch the local branch should track. It simplifies future interactions with the remote repository for that branch.
# --set-upstream: This flag is telling Git to set up a "tracking relationship" between our local branch and the corresponding branch on the remote repository. In this case, we're associating our local main branch with the remote origin/main branch.
# The --set-upstream flag is used to establish a tracking relationship between the local and remote branches. This allows future git push and git pull operations to work without specifying the remote and branch explicitly. It associates the local `main` branch with the remote `origin/main` branch.

# Print a separator line to mark the end of the script output
echo "================================="