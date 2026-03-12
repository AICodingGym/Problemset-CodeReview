# Problemset-CodeReview

Code review challenges for [AICodingGym](https://github.com/AICodingGym/AICodingGym). Each challenge lives on a pair of branches: `<slug>/base` and `<slug>/head`. The diff between them is the "PR" to review.

## Branch structure

Each challenge has two branches with minimal history:

- **`<slug>/base`** — a single orphan commit containing the repo state _before_ the PR
- **`<slug>/head`** — one commit on top of base containing the PR changes

This keeps fetches fast (2 commits per challenge) while preserving a clean `git diff base..head`.

## Current challenges (50)

### Sentry (Python / Django)

| Slug | Source PR | Difficulty |
|------|-----------|------------|
| `sentry-0001` | [sentry-greptile#1](https://github.com/ai-code-review-evaluation/sentry-greptile/pull/1) — Enhanced Pagination Performance for High-Volume Audit Logs | Hard |
| `sentry-0002` | [sentry-greptile#2](https://github.com/ai-code-review-evaluation/sentry-greptile/pull/2) — Optimize spans buffer insertion with eviction during insert | Hard |
| `sentry-0003` | [sentry-greptile#3](https://github.com/ai-code-review-evaluation/sentry-greptile/pull/3) — feat(upsampling) - Support upsampled error count with performance optimizations | Easy |
| `sentry-0004` | [sentry-greptile#4](https://github.com/ai-code-review-evaluation/sentry-greptile/pull/4) — GitHub OAuth Security Enhancement | Medium |
| `sentry-0005` | [sentry-greptile#5](https://github.com/ai-code-review-evaluation/sentry-greptile/pull/5) — Replays Self-Serve Bulk Delete System | Easy |
| `sentry-0006` | [sentry-greptile#6](https://github.com/ai-code-review-evaluation/sentry-greptile/pull/6) — Span Buffer Multiprocess Enhancement with Health Monitoring | Medium |
| `sentry-0007` | [sentry-greptile#7](https://github.com/ai-code-review-evaluation/sentry-greptile/pull/7) — feat(ecosystem): Implement cross-system issue synchronization | Easy |
| `sentry-0008` | [sentry-greptile#8](https://github.com/ai-code-review-evaluation/sentry-greptile/pull/8) — ref(crons): Reorganize incident creation / issue occurrence logic | Medium |
| `sentry-0009` | [sentry-greptile#9](https://github.com/ai-code-review-evaluation/sentry-greptile/pull/9) — feat(uptime): Add ability to use queues to manage parallelism | Medium |
| `sentry-0010` | [sentry-greptile#10](https://github.com/ai-code-review-evaluation/sentry-greptile/pull/10) — feat(workflow_engine): Add in hook for producing occurrences from the stateful detector | Medium |

### Cal.com (TypeScript / Next.js / Prisma)

| Slug | Source PR | Difficulty |
|------|-----------|------------|
| `calcom-0001` | [cal.com-greptile#2](https://github.com/ai-code-review-evaluation/cal.com-greptile/pull/2) — Async import of the appStore packages | Hard |
| `calcom-0002` | [cal.com-greptile#3](https://github.com/ai-code-review-evaluation/cal.com-greptile/pull/3) — feat: 2fa backup codes | Medium |
| `calcom-0003` | [cal.com-greptile#4](https://github.com/ai-code-review-evaluation/cal.com-greptile/pull/4) — fix: handle collective multiple host on destinationCalendar | Medium |
| `calcom-0004` | [cal.com-greptile#5](https://github.com/ai-code-review-evaluation/cal.com-greptile/pull/5) — feat: convert InsightsBookingService to use Prisma.sql raw queries | Easy |
| `calcom-0005` | [cal.com-greptile#6](https://github.com/ai-code-review-evaluation/cal.com-greptile/pull/6) — Comprehensive workflow reminder management for booking lifecycle events | Medium |
| `calcom-0006` | [cal.com-greptile#7](https://github.com/ai-code-review-evaluation/cal.com-greptile/pull/7) — Advanced date override handling and timezone compatibility improvements | Easy |
| `calcom-0007` | [cal.com-greptile#8](https://github.com/ai-code-review-evaluation/cal.com-greptile/pull/8) — OAuth credential sync and app integration enhancements | Hard |
| `calcom-0008` | [cal.com-greptile#9](https://github.com/ai-code-review-evaluation/cal.com-greptile/pull/9) — SMS workflow reminder retry count tracking | Medium |
| `calcom-0009` | [cal.com-greptile#10](https://github.com/ai-code-review-evaluation/cal.com-greptile/pull/10) — Add guest management functionality to existing bookings | Hard |
| `calcom-0010` | [cal.com-greptile#11](https://github.com/ai-code-review-evaluation/cal.com-greptile/pull/11) — feat: add calendar cache status and actions (#22532) | Easy |

### Discourse (Ruby / Rails / Ember.js)

| Slug | Source PR | Difficulty |
|------|-----------|------------|
| `discourse-0001` | [discourse-greptile#1](https://github.com/ai-code-review-evaluation/discourse-greptile/pull/1) — FEATURE: automatically downsize large images | Easy |
| `discourse-0002` | [discourse-greptile#2](https://github.com/ai-code-review-evaluation/discourse-greptile/pull/2) — FEATURE: per-topic unsubscribe option in emails | Medium |
| `discourse-0003` | [discourse-greptile#3](https://github.com/ai-code-review-evaluation/discourse-greptile/pull/3) — Add comprehensive email validation for blocked users | Easy |
| `discourse-0004` | [discourse-greptile#4](https://github.com/ai-code-review-evaluation/discourse-greptile/pull/4) — Enhance embed URL handling and validation system | Hard |
| `discourse-0005` | [discourse-greptile#5](https://github.com/ai-code-review-evaluation/discourse-greptile/pull/5) — Optimize header layout performance with flexbox mixins | Easy |
| `discourse-0006` | [discourse-greptile#6](https://github.com/ai-code-review-evaluation/discourse-greptile/pull/6) — UX: show complete URL path if website domain is same as instance domain | Easy |
| `discourse-0007` | [discourse-greptile#7](https://github.com/ai-code-review-evaluation/discourse-greptile/pull/7) — scale-color $lightness must use $secondary for dark themes | Easy |
| `discourse-0008` | [discourse-greptile#8](https://github.com/ai-code-review-evaluation/discourse-greptile/pull/8) — FIX: proper handling of group memberships | Medium |
| `discourse-0009` | [discourse-greptile#9](https://github.com/ai-code-review-evaluation/discourse-greptile/pull/9) — FEATURE: Localization fallbacks (server-side) | Easy |
| `discourse-0010` | [discourse-greptile#10](https://github.com/ai-code-review-evaluation/discourse-greptile/pull/10) — FEATURE: Can edit category/host relationships for embedding | Hard |

### Grafana (Go / React)

| Slug | Source PR | Difficulty |
|------|-----------|------------|
| `grafana-0001` | [grafana-greptile#1](https://github.com/ai-code-review-evaluation/grafana-greptile/pull/1) — Anonymous: Add configurable device limit | Medium |
| `grafana-0002` | [grafana-greptile#2](https://github.com/ai-code-review-evaluation/grafana-greptile/pull/2) — AuthZService: improve authz caching | Medium |
| `grafana-0003` | [grafana-greptile#3](https://github.com/ai-code-review-evaluation/grafana-greptile/pull/3) — Plugins: Chore: Renamed instrumentation middleware to metrics middleware | Medium |
| `grafana-0004` | [grafana-greptile#4](https://github.com/ai-code-review-evaluation/grafana-greptile/pull/4) — Advanced Query Processing Architecture | Easy |
| `grafana-0005` | [grafana-greptile#5](https://github.com/ai-code-review-evaluation/grafana-greptile/pull/5) — Notification Rule Processing Engine | Medium |
| `grafana-0006` | [grafana-greptile#6](https://github.com/ai-code-review-evaluation/grafana-greptile/pull/6) — Dual Storage Architecture | Medium |
| `grafana-0007` | [grafana-greptile#7](https://github.com/ai-code-review-evaluation/grafana-greptile/pull/7) — Database Performance Optimizations | Easy |
| `grafana-0008` | [grafana-greptile#8](https://github.com/ai-code-review-evaluation/grafana-greptile/pull/8) — Frontend Asset Optimization | Medium |
| `grafana-0009` | [grafana-greptile#9](https://github.com/ai-code-review-evaluation/grafana-greptile/pull/9) — Advanced SQL Analytics Framework | Hard |
| `grafana-0010` | [grafana-greptile#10](https://github.com/ai-code-review-evaluation/grafana-greptile/pull/10) — Unified Storage Performance Optimizations | Medium |

### Keycloak (Java)

| Slug | Source PR | Difficulty |
|------|-----------|------------|
| `keycloak-0001` | [keycloak-greptile#1](https://github.com/ai-code-review-evaluation/keycloak-greptile/pull/1) — Fixing Re-authentication with passkeys | Easy |
| `keycloak-0002` | [keycloak-greptile#2](https://github.com/ai-code-review-evaluation/keycloak-greptile/pull/2) — Add caching support for IdentityProviderStorageProvider.getForLogin operations | Hard |
| `keycloak-0003` | [keycloak-greptile#3](https://github.com/ai-code-review-evaluation/keycloak-greptile/pull/3) — Add AuthzClientCryptoProvider for authorization client cryptographic operations | Medium |
| `keycloak-0004` | [keycloak-greptile#4](https://github.com/ai-code-review-evaluation/keycloak-greptile/pull/4) — Add rolling-updates feature flag and compatibility framework | Easy |
| `keycloak-0005` | [keycloak-greptile#5](https://github.com/ai-code-review-evaluation/keycloak-greptile/pull/5) — Add Client resource type and scopes to authorization schema | Hard |
| `keycloak-0006` | [keycloak-greptile#6](https://github.com/ai-code-review-evaluation/keycloak-greptile/pull/6) — Add Groups resource type and scopes to authorization schema | Medium |
| `keycloak-0007` | [keycloak-greptile#7](https://github.com/ai-code-review-evaluation/keycloak-greptile/pull/7) — Add HTML sanitizer for translated message resources | Easy |
| `keycloak-0008` | [keycloak-greptile#8](https://github.com/ai-code-review-evaluation/keycloak-greptile/pull/8) — Implement access token context encoding framework | Hard |
| `keycloak-0009` | [keycloak-greptile#9](https://github.com/ai-code-review-evaluation/keycloak-greptile/pull/9) — Implement recovery key support for user storage providers | Easy |
| `keycloak-0010` | [keycloak-greptile#10](https://github.com/ai-code-review-evaluation/keycloak-greptile/pull/10) — Fix concurrent group access to prevent NullPointerException | Hard |
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
