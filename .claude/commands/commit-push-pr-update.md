---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git push:*), Bash(git commit:*), Bash(gh pr edit:*), Bash(gh pr view:*)
description: Commit, push, and update existing PR description
---

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -10`
- Existing PR: !`gh pr view --json title,body,number 2>/dev/null || echo "No PR found"`
- All commits in PR: !`gh pr view --json commits --jq '.commits[].messageHeadline' 2>/dev/null || echo "No PR found"`

## Your task

Based on the above changes:

1. Create a single commit with an appropriate message
2. Push the branch to origin
3. Update the existing pull request's title and body using `gh pr edit` to reflect all commits in the PR

You have the capability to call multiple tools in a single response. You MUST do all of the above in a single message. Do not use any other tools or do anything else. Do not send any other text or messages besides these tool calls.
