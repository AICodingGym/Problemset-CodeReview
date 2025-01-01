#!/usr/bin/env bash
#
# load-problems.sh — Create orphan+linked branch pairs for all 50 code review problems.
#
# Run from the Problemset-CodeReview repo root:
#   cd /Users/charlie_nus/Desktop/Code/AICodingGymProblems/cr/sentry-0001
#   bash load-problems.sh
#
# Prerequisites: gh CLI authenticated, git configured.
#
set -euo pipefail

REPO_DIR="$(pwd)"

# ─── Problem definitions ───────────────────────────────────────────────────────
# Format: SLUG|SOURCE_REPO|PR_NUM|PR_TITLE
PROBLEMS=(
  # Sentry (sentry-greptile) — PR #1 already done
  "sentry-0002|sentry-greptile|2|Optimize spans buffer insertion with eviction during insert"
  "sentry-0003|sentry-greptile|3|feat(upsampling) - Support upsampled error count with performance optimizations"
  "sentry-0004|sentry-greptile|4|GitHub OAuth Security Enhancement"
  "sentry-0005|sentry-greptile|5|Replays Self-Serve Bulk Delete System"
  "sentry-0006|sentry-greptile|6|Span Buffer Multiprocess Enhancement with Health Monitoring"
  "sentry-0007|sentry-greptile|7|feat(ecosystem): Implement cross-system issue synchronization"
  "sentry-0008|sentry-greptile|8|ref(crons): Reorganize incident creation / issue occurrence logic"
  "sentry-0009|sentry-greptile|9|feat(uptime): Add ability to use queues to manage parallelism"
  "sentry-0010|sentry-greptile|10|feat(workflow_engine): Add in hook for producing occurrences from the stateful detector"

  # Cal.com (cal.com-greptile) — PRs #2-#11
  "calcom-0001|cal.com-greptile|2|Async import of the appStore packages"
  "calcom-0002|cal.com-greptile|3|feat: 2fa backup codes"
  "calcom-0003|cal.com-greptile|4|fix: handle collective multiple host on destinationCalendar"
  "calcom-0004|cal.com-greptile|5|feat: convert InsightsBookingService to use Prisma.sql raw queries"
  "calcom-0005|cal.com-greptile|6|Comprehensive workflow reminder management for booking lifecycle events"
  "calcom-0006|cal.com-greptile|7|Advanced date override handling and timezone compatibility improvements"
  "calcom-0007|cal.com-greptile|8|OAuth credential sync and app integration enhancements"
  "calcom-0008|cal.com-greptile|9|SMS workflow reminder retry count tracking"
  "calcom-0009|cal.com-greptile|10|Add guest management functionality to existing bookings"
  "calcom-0010|cal.com-greptile|11|feat: add calendar cache status and actions"

  # Discourse (discourse-greptile) — PRs #1-#10
  "discourse-0001|discourse-greptile|1|FEATURE: automatically downsize large images"
  "discourse-0002|discourse-greptile|2|FEATURE: per-topic unsubscribe option in emails"
  "discourse-0003|discourse-greptile|3|Add comprehensive email validation for blocked users"
  "discourse-0004|discourse-greptile|4|Enhance embed URL handling and validation system"
  "discourse-0005|discourse-greptile|5|Optimize header layout performance with flexbox mixins"
  "discourse-0006|discourse-greptile|6|UX: show complete URL path if website domain is same as instance domain"
  "discourse-0007|discourse-greptile|7|scale-color lightness must use secondary for dark themes"
  "discourse-0008|discourse-greptile|8|FIX: proper handling of group memberships"
  "discourse-0009|discourse-greptile|9|FEATURE: Localization fallbacks (server-side)"
  "discourse-0010|discourse-greptile|10|FEATURE: Can edit category/host relationships for embedding"

  # Grafana (grafana-greptile) — PRs #1-#10
  "grafana-0001|grafana-greptile|1|Anonymous: Add configurable device limit"
  "grafana-0002|grafana-greptile|2|AuthZService: improve authz caching"
  "grafana-0003|grafana-greptile|3|Plugins: Chore: Renamed instrumentation middleware to metrics middleware"
  "grafana-0004|grafana-greptile|4|Advanced Query Processing Architecture"
  "grafana-0005|grafana-greptile|5|Notification Rule Processing Engine"
  "grafana-0006|grafana-greptile|6|Dual Storage Architecture"
  "grafana-0007|grafana-greptile|7|Database Performance Optimizations"
  "grafana-0008|grafana-greptile|8|Frontend Asset Optimization"
  "grafana-0009|grafana-greptile|9|Advanced SQL Analytics Framework"
  "grafana-0010|grafana-greptile|10|Unified Storage Performance Optimizations"

  # Keycloak (keycloak-greptile) — PRs #1-#10
  "keycloak-0001|keycloak-greptile|1|Fixing Re-authentication with passkeys"
  "keycloak-0002|keycloak-greptile|2|Add caching support for IdentityProviderStorageProvider.getForLogin operations"
  "keycloak-0003|keycloak-greptile|3|Add AuthzClientCryptoProvider for authorization client cryptographic operations"
  "keycloak-0004|keycloak-greptile|4|Add rolling-updates feature flag and compatibility framework"
  "keycloak-0005|keycloak-greptile|5|Add Client resource type and scopes to authorization schema"
  "keycloak-0006|keycloak-greptile|6|Add Groups resource type and scopes to authorization schema"
  "keycloak-0007|keycloak-greptile|7|Add HTML sanitizer for translated message resources"
  "keycloak-0008|keycloak-greptile|8|Implement access token context encoding framework"
  "keycloak-0009|keycloak-greptile|9|Implement recovery key support for user storage providers"
  "keycloak-0010|keycloak-greptile|10|Fix concurrent group access to prevent NullPointerException"
)

# Track which remotes we've added (bash 3.2 compatible)
REMOTES_ADDED=""

add_remote_if_needed() {
  local source_repo="$1"
  if ! echo "${REMOTES_ADDED}" | grep -q "|${source_repo}|"; then
    echo "  Adding remote: ${source_repo}"
    git remote add "${source_repo}" "https://github.com/ai-code-review-evaluation/${source_repo}.git" 2>/dev/null || true
    REMOTES_ADDED="${REMOTES_ADDED}|${source_repo}|"
  fi
}

create_problem_branches() {
  local slug="$1"
  local source_repo="$2"
  local pr_num="$3"
  local pr_title="$4"

  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "Processing: ${slug} (${source_repo} PR #${pr_num})"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  # Check if branches already exist on remote
  if git ls-remote --heads origin "${slug}/base" | grep -q "${slug}/base"; then
    echo "  ⏭ Branches already exist on remote, skipping."
    return 0
  fi

  add_remote_if_needed "${source_repo}"

  # Step 1: Get head commit SHA from PR
  echo "  Fetching PR #${pr_num} metadata..."
  local head_sha
  head_sha=$(gh api "repos/ai-code-review-evaluation/${source_repo}/pulls/${pr_num}" --jq '.head.sha')
  echo "  HEAD SHA: ${head_sha}"

  # Step 2: Fetch the PR head ref (more reliable than fetching arbitrary SHAs)
  echo "  Fetching PR ref..."
  git fetch "${source_repo}" "refs/pull/${pr_num}/head:refs/remotes/${source_repo}/pr-${pr_num}" --depth=2 2>&1 || {
    echo "  Shallow fetch failed, trying full fetch of PR ref..."
    git fetch "${source_repo}" "refs/pull/${pr_num}/head:refs/remotes/${source_repo}/pr-${pr_num}" 2>&1
  }

  # Step 3: Get parent SHA
  local fetched_head_sha parent_sha
  fetched_head_sha=$(git rev-parse "refs/remotes/${source_repo}/pr-${pr_num}")
  echo "  Fetched HEAD: ${fetched_head_sha}"

  # Try to get parent; if not available, deepen
  parent_sha=$(git rev-parse "${fetched_head_sha}^" 2>/dev/null) || {
    echo "  Parent not available, deepening fetch..."
    git fetch "${source_repo}" "refs/pull/${pr_num}/head:refs/remotes/${source_repo}/pr-${pr_num}" --deepen=1 2>&1
    parent_sha=$(git rev-parse "${fetched_head_sha}^")
  }
  echo "  PARENT SHA: ${parent_sha}"

  # Step 4: Create orphan base branch from parent commit's tree
  echo "  Creating ${slug}/base..."
  git checkout --orphan "${slug}/base" 2>&1
  git rm -rf . 2>/dev/null || true
  git read-tree "${parent_sha}"
  git checkout -- . 2>&1
  GIT_AUTHOR_DATE="2025-01-01T00:00:00+00:00" \
  GIT_COMMITTER_DATE="2025-01-01T00:00:00+00:00" \
  git commit -m "Base state for ${slug}" --allow-empty 2>&1

  # Step 5: Create head branch (1 commit on top of base)
  echo "  Creating ${slug}/head..."
  git checkout -b "${slug}/head" 2>&1
  git rm -rf . 2>/dev/null || true
  git read-tree "${fetched_head_sha}"
  git checkout -- . 2>&1
  # Stage any deletions too
  git add -A 2>&1
  GIT_AUTHOR_DATE="2025-01-01T00:01:00+00:00" \
  GIT_COMMITTER_DATE="2025-01-01T00:01:00+00:00" \
  git commit -m "${pr_title}" --allow-empty 2>&1

  # Step 6: Push both branches
  echo "  Pushing branches..."
  git push origin "${slug}/base" "${slug}/head" 2>&1

  # Clean up fetched ref
  git update-ref -d "refs/remotes/${source_repo}/pr-${pr_num}" 2>/dev/null || true

  echo "  ✓ Done: ${slug}"
}

# ─── Main ──────────────────────────────────────────────────────────────────────

echo "Loading 49 code review problems into Problemset-CodeReview..."
echo "Repo: ${REPO_DIR}"
echo ""

# Save current branch to return to
ORIGINAL_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "sentry-0001/base")

SUCCESS=0
FAIL=0
SKIP=0

for entry in "${PROBLEMS[@]}"; do
  IFS='|' read -r slug source_repo pr_num pr_title <<< "${entry}"

  if create_problem_branches "${slug}" "${source_repo}" "${pr_num}" "${pr_title}"; then
    ((SUCCESS++)) || true
  else
    echo "  ✗ FAILED: ${slug}"
    ((FAIL++)) || true
  fi

  # Return to a known branch between problems
  git checkout "${ORIGINAL_BRANCH}" 2>/dev/null || git checkout "sentry-0001/base" 2>/dev/null || true
done

# Clean up remotes
echo ""
echo "Cleaning up temporary remotes..."
for remote in sentry-greptile cal.com-greptile discourse-greptile grafana-greptile keycloak-greptile; do
  git remote remove "${remote}" 2>/dev/null || true
done

echo ""
echo "════════════════════════════════════════════════════════════════════"
echo "Done! Success: ${SUCCESS}, Failed: ${FAIL}"
echo "════════════════════════════════════════════════════════════════════"
