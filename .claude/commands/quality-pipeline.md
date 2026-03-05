---
description: Run the full quality pipeline — security scan, code review, and test suite — then generate a combined report
argument-hint: "[--quick] [--output=reports/]"
---

# Quality Pipeline Command

Run all quality checks in sequence and produce a combined report.

## Workflow

### Step 1: Gather Context

Use `Bash(git diff --staged --name-only)` to determine scope. If nothing is staged, use `Bash(git diff HEAD --name-only)`. Report the file count to the user before proceeding.

### Step 2: Security Scan

Use the Skill tool to invoke the `security-scan` skill:

```
Skill: security-scan
```

Capture the results. If critical vulnerabilities are found, pause and ask the user whether to continue.

### Step 3: Code Review

Use the Skill tool to invoke the `review` skill:

```
Skill: review
```

Capture the results.

### Step 4: Test Suite

Use the Skill tool to invoke the `test` skill:

```
Skill: test
```

Capture pass/fail summary.

### Step 5: Generate Report

Write a combined Markdown report to `reports/quality-pipeline-<YYYY-MM-DD>.md` with:

- Date and git branch
- Files analyzed
- Security: issue count by severity
- Review: issue count by category
- Tests: pass/fail/skip counts
- Overall status: PASS / NEEDS ATTENTION / FAIL

### Step 6: Summary

Print a one-line status to the user:

```
Quality Pipeline: [PASS|NEEDS ATTENTION|FAIL] — N security issues, N review issues, N/N tests passed
```

## Critical Requirements

1. **Sequential execution**: Complete each step before starting the next
2. **Non-blocking security**: Only block on CRITICAL severity; warn on HIGH
3. **Report always written**: Write the report even if checks fail
4. **No commits**: This command only analyzes — never commits

## Arguments

- `--quick`: Skip the full test suite, run only lint/type checks
- `--output=<dir>`: Override the reports output directory (default: `reports/`)
