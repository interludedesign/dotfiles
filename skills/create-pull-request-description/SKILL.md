---
name: create-pull-request-description
description: Use this when writing a description for a new pull request the user is raising
---

- The changes will be in a feature branch, and will be merged into main
- Do not squash commits, push or pull branches, or merge branches unless explicitly asked to do so by the user
- If you don't have the information you need (e.g. branch name, acceptance criteria), ask the user for it, otherwise you probably have it in your context
- You are expected to amend the most recent commit on the feature branch with the description you write

## Get the diff

Use `dot-git-branch-diff` to retrieve the commits and file changes introduced on the branch:

```bash
dot-git-branch-diff        # diffs current branch against main
dot-git-branch-diff main my-feature-branch
```

## Write the pull request description

- Start with a short one-line description that will become the PR title
- Proceed with a short description of the business domain and why it is being changed
- No co-authoring attribution
- Assume the reader understands the general domain, but not what this feature is and why it exists
- List acceptance criteria in a condensed format, starting with the happy path (the reader can refer to the work item for the full acceptance criteria)
- List only the most relevant component changes — no need to explain how the tests are comprehensive or DI was wired up
- Make sure to use proper markdown formatting

### Template

```
**Changes:**
- <what changed> — <why, one sentence>
- ...

**Acceptance criteria:**
- <scenario> → <outcome>
- ...
```

### Example

```
Add rate limiting to the public search API

The public search API has no request throttling, allowing clients to exceed acceptable load. This adds per-client rate limiting to protect downstream services.

### Changes:

- Added RateLimitMiddleware — enforces per-client request quotas on all public API routes
- Added IRateLimitStore and RedisRateLimitStore — persists per-client counters with TTL

### Acceptance criteria:

- Client within quota → request succeeds with 200
- Client exceeds quota → 429 with Retry-After header
- Counter resets after window expires → subsequent requests succeed
- Unknown client ID → treated as a new client, quota starts fresh
```
