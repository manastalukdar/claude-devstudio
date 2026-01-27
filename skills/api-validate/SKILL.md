---
name: api-validate
description: API contract validation and breaking change detection
disable-model-invocation: false
---

# API Contract Validation

I'll analyze your API contracts for breaking changes, compatibility issues, and schema validation.

Arguments: `$ARGUMENTS` - API spec paths, comparison targets, or validation focus

**Token Optimization:**
- ✅ Session-based contract baseline (already implemented)
- ✅ Grep to find API spec files (100 tokens vs 3,000+ reading all files)
- ✅ Schema-based comparison (no full file reads)
- ✅ Early exit when no changes detected - saves 95%
- ✅ Progressive disclosure (breaking → non-breaking changes)
- ✅ Caching baseline contracts and previous validations
- **Expected tokens:** 1,000-2,500 (vs. 3,000-5,000 unoptimized)
- **Optimization status:** ✅ Optimized (Phase 2 Batch 2, 2026-01-26)

**Caching Behavior:**
- Session location: `api-validate/` (baseline.json, state.json, plan.md)
- Cache location: `.claude/cache/api/contracts.json`
- Caches: API contract baselines, endpoint schemas, validation results
- Cache validity: Until API spec files change (checksum-based)
- Shared with: `/api-test-generate`, `/api-docs-generate` skills

**Usage:**
- `api-validate` - Validate against baseline (default, 1,000-2,000 tokens)
- `api-validate baseline` - Create new baseline (1,500-2,500 tokens)
- `api-validate compare` - Compare specific versions (2,000-3,000 tokens)
- `api-validate status` - Check validation state (200-500 tokens)

## Session Intelligence

I'll maintain API validation continuity across sessions:

**Session Files (in current project directory):**
- `api-validate/plan.md` - Validation plan and findings
- `api-validate/state.json` - Session state and baseline contracts
- `api-validate/baseline.json` - API contract baseline for comparison

**IMPORTANT:** Session files are stored in an `api-validate` folder in your current project root

**Auto-Detection:**
- If session exists: Compare against baseline, track evolution
- If no session: Create baseline and validation plan
- Commands: `resume`, `baseline`, `compare`, `status`

## Phase 1: API Discovery & Analysis

### Extended Thinking for API Contract Analysis

For complex API ecosystems, I'll use extended thinking to identify subtle breaking changes:

<think>
When analyzing API contracts:
- Backward compatibility implications of field removals
- Type changes that break existing clients
- Required field additions that need migration strategies
- URL structure changes affecting routing
- Authentication changes requiring client updates
- Rate limiting changes affecting performance assumptions
</think>

**Optimization: Check for Existing Baseline**

```bash
# Check for existing baseline (95% savings if baseline exists and no changes)
BASELINE_FILE="api-validate/baseline.json"

if [ -f "$BASELINE_FILE" ]; then
    echo "✓ Found existing API baseline"

    # Quick checksum comparison with current API specs
    CURRENT_CHECKSUM=$(find . -name "*.openapi.*" -o -name "swagger.*" -o -name "api-spec.*" | \
        xargs md5sum 2>/dev/null | md5sum | cut -d' ' -f1)
    BASELINE_CHECKSUM=$(jq -r '.checksum' "$BASELINE_FILE" 2>/dev/null)

    if [ "$CURRENT_CHECKSUM" = "$BASELINE_CHECKSUM" ]; then
        echo "✓ No API changes detected since last validation"
        echo "API contract is stable"
        exit 0  # Early exit, saves 95% tokens
    fi

    echo "Changes detected, analyzing differences..."
else
    echo "No baseline found, creating initial baseline..."
fi
```

**Optimization: Grep-Based API Spec Discovery**

```bash
# Use Grep to find API specs efficiently (100 tokens vs 3,000+)
API_SPECS=$(Grep pattern="openapi|swagger|paths:|/api/" \
    glob="**/*.{json,yaml,yml,ts,js}" \
    output_mode="files_with_matches" \
    head_limit=20)

if [ -z "$API_SPECS" ]; then
    echo "No API specifications found"
    echo "Looking for: OpenAPI, Swagger, API route definitions"
    exit 0  # Early exit
fi

echo "Found API specifications:"
echo "$API_SPECS"
```

I'll analyze your API for:

**Breaking Changes (Critical):**
- Removed endpoints or fields
- Changed request/response types
- Modified authentication requirements
- Breaking versioning changes

**Non-Breaking Changes (Review):**
- Added endpoints or fields
- Deprecated features
- Documentation updates
- Optional parameter additions

**Progressive Disclosure:**

```
API VALIDATION RESULTS

Breaking Changes (3): REQUIRE IMMEDIATE ATTENTION
1. Removed field 'user.email' from GET /api/users (affects all clients)
2. Changed type of 'id' from string to number in POST /api/orders (incompatible)
3. Removed endpoint DELETE /api/legacy (used by mobile app v1.x)

Non-Breaking Changes (5): Review recommended
- Added optional field 'user.avatar' to GET /api/users
- Added new endpoint POST /api/webhooks
- Deprecated 'user.username' (still functional, removed in v3.0)

No Changes (12 endpoints): Stable

Run with --verbose for full contract comparison
```

## Phase 2: Contract Comparison

I'll perform detailed contract comparison:

**Comparison Strategy:**
- Schema-level diff (no full file reads)
- Endpoint-by-endpoint analysis
- Type compatibility checking
- Authentication flow validation

**Save Baseline:**

```bash
# Save current contract as baseline
mkdir -p api-validate .claude/cache/api

cat > api-validate/baseline.json <<EOF
{
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "checksum": "$CURRENT_CHECKSUM",
  "endpoints": $(echo "$API_SPECS" | wc -l),
  "version": "detected_version",
  "contracts": {}
}
EOF

cat > .claude/cache/api/contracts.json <<EOF
{
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "last_validation": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "baseline_checksum": "$CURRENT_CHECKSUM"
}
EOF

echo "✓ Baseline saved for future comparisons"
```

## Phase 3: Breaking Change Analysis

I'll identify and categorize all breaking changes:

**Impact Assessment:**
- Client compatibility impact
- Migration effort required
- Rollback complexity
- Timeline recommendations

## Phase 4: Recommendations

Based on validation findings:

**Critical Actions:**
- Version bump requirements (major/minor/patch)
- Migration guides needed
- Deprecation notices
- Client update coordination

**Best Practices:**
- Maintain backward compatibility
- Use versioned endpoints
- Provide migration paths
- Document all changes

This ensures your API changes are safe and won't break existing integrations.
