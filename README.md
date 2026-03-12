# Problemset-CodeReview

Code review challenges for [AICodingGym](https://github.com/AICodingGym/AICodingGym). Each challenge lives on a pair of branches: `<slug>/base` and `<slug>/head`. The diff between them is the "PR" to review.

## Branch structure

Each challenge has two branches with minimal history:

- **`<slug>/base`** — a single orphan commit containing the repo state _before_ the PR
- **`<slug>/head`** — one commit on top of base containing the PR changes

This keeps fetches fast (2 commits per challenge) while preserving a clean `git diff base..head`.

## How to add a new challenge

The source PRs come from [ai-code-review-evaluation](https://github.com/ai-code-review-evaluation) repos, with golden comments from the [code-review-benchmark](https://github.com/withmartian/code-review-benchmark/tree/main/offline/golden_comments).

### 1. Identify the source PR

Find the PR on the source repo (e.g. `ai-code-review-evaluation/sentry-greptile#1`) and note:

- The **head commit SHA** (the tip of the PR branch)
- The **parent commit SHA** of the head commit (this is your base)

```bash
# Get parent of head commit via GitHub API
gh api repos/<org>/<repo>/commits/<head-sha> --jq '.parents[].sha'
```

### 2. Clone this repo and add the source as a remote

```bash
git clone https://github.com/AICodingGym/Problemset-CodeReview.git
cd Problemset-CodeReview
git remote add upstream https://github.com/<org>/<source-repo>.git
```

### 3. Fetch the two commits

```bash
git fetch upstream <parent-sha> --depth=1
git fetch upstream <head-sha> --depth=1
```

### 4. Create the base branch (orphan)

```bash
git checkout --orphan <slug>/base
git rm -rf .
git checkout <parent-sha> -- .
git commit -m "base: <original commit message>"
```

### 5. Create the head branch (on top of base)

```bash
git checkout -b <slug>/head
git checkout <head-sha> -- .
git commit -m "<original PR commit message>"
```

### 6. Verify and push

```bash
# Should show only the PR's changed files
git diff <slug>/base..<slug>/head --stat

git push origin <slug>/base
git push origin <slug>/head
```

### 7. Add golden comments

Add the golden comments from the benchmark to `AICodingGym/backend/data/code-review-golden.json` under the key matching the challenge's `title` field (e.g. `cr/sentry-0001`).

## Current challenges

| Slug | Source PR | Files changed |
|------|-----------|---------------|
| `sentry-0001` | [sentry-greptile#1](https://github.com/ai-code-review-evaluation/sentry-greptile/pull/1) — Enhanced Pagination Performance for High-Volume Audit Logs | `organization_auditlogs.py`, `paginator.py`, `cursors.py` |
