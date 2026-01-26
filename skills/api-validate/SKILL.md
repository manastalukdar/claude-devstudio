---
name: api-validate
description: API contract validation and breaking change detection
disable-model-invocation: false
---

# API Contract Validation

I'll analyze your API contracts for breaking changes, compatibility issues, and schema validation.

Arguments: `$ARGUMENTS` - API spec paths, comparison targets, or validation focus

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
- Semantic versioning compatibility implications
- Consumer impact of field removals or type changes
- Backward compatibility with existing clients
- Forward compatibility strategies
- Migration paths for breaking changes
- Authentication and authorization contract changes
</think>

**Triggers for Extended Analysis:**
- Public API modifications
- Multi-version API support
- Complex schema dependencies
- Authentication/authorization changes
- Microservices contract updates

**MANDATORY FIRST STEPS:**
1. Check if `api-validate` directory exists in current working directory
2. If directory exists, check for session files:
   - Look for `api-validate/state.json`
   - Look for `api-validate/baseline.json`
   - If found, resume with baseline comparison
3. If no directory or session exists:
   - Discover API specifications
   - Create baseline snapshot
   - Initialize validation tracking

**API Specification Discovery:**
I'll use **Grep** to find API contracts efficiently:

```bash
# Find OpenAPI/Swagger specs (token-efficient)
find_api_specs() {
    # OpenAPI specs
    grep -l "openapi:" --include="*.yaml" --include="*.yml" --include="*.json" -r . 2>/dev/null || true

    # GraphQL schemas
    grep -l "type Query" --include="*.graphql" --include="*.gql" -r . 2>/dev/null || true

    # AsyncAPI specs
    grep -l "asyncapi:" --include="*.yaml" --include="*.yml" -r . 2>/dev/null || true

    # Protocol Buffers
    find . -name "*.proto" 2>/dev/null || true

    # Common locations
    ls -1 docs/api/*.{yaml,yml,json} 2>/dev/null || true
    ls -1 api/spec/*.{yaml,yml,json} 2>/dev/null || true
}

API_SPECS=$(find_api_specs)

if [ -z "$API_SPECS" ]; then
    echo "No API specifications found"
    echo "Supported formats: OpenAPI, GraphQL, AsyncAPI, Protocol Buffers"
    exit 1
fi

echo "Found API specifications:"
echo "$API_SPECS" | sed 's/^/  /'
```

**Analysis Focus:**
- Endpoint changes (additions, removals, modifications)
- Request/response schema changes
- Authentication requirements
- Rate limiting and quotas
- Deprecation notices

## Phase 2: Breaking Change Detection

I'll analyze changes for compatibility impact:

**Breaking Changes:**
- ❌ Removed endpoints or operations
- ❌ Removed required fields
- ❌ Changed field types
- ❌ New required parameters
- ❌ Changed authentication schemes
- ❌ Stricter validation rules

**Non-Breaking Changes:**
- ✅ New optional fields
- ✅ New endpoints
- ✅ Relaxed validation
- ✅ Additional response codes
- ✅ Expanded enums (with default handling)

**Validation Script:**

```bash
#!/bin/bash
# API Contract Breaking Change Detector

validate_openapi_changes() {
    local baseline="$1"
    local current="$2"

    # Extract endpoints from baseline
    baseline_endpoints=$(grep -o '"\/[^"]*"' "$baseline" | sort -u)
    current_endpoints=$(grep -o '"\/[^"]*"' "$current" | sort -u)

    # Check for removed endpoints
    removed_endpoints=$(comm -23 <(echo "$baseline_endpoints") <(echo "$current_endpoints"))

    if [ ! -z "$removed_endpoints" ]; then
        echo "❌ BREAKING: Removed endpoints detected:"
        echo "$removed_endpoints" | sed 's/^/  /'
    fi

    # Check for new required fields
    baseline_required=$(grep -o '"required":\s*\[[^]]*\]' "$baseline" | sort)
    current_required=$(grep -o '"required":\s*\[[^]]*\]' "$current" | sort)

    new_required=$(comm -13 <(echo "$baseline_required") <(echo "$current_required"))

    if [ ! -z "$new_required" ]; then
        echo "❌ BREAKING: New required fields detected:"
        echo "$new_required" | sed 's/^/  /'
    fi

    # Check for type changes
    baseline_types=$(grep -o '"[^"]*":\s*{\s*"type":\s*"[^"]*"' "$baseline" | sort)
    current_types=$(grep -o '"[^"]*":\s*{\s*"type":\s*"[^"]*"' "$current" | sort)

    type_changes=$(diff <(echo "$baseline_types") <(echo "$current_types") | grep '^[<>]' || true)

    if [ ! -z "$type_changes" ]; then
        echo "⚠️  WARNING: Type changes detected:"
        echo "$type_changes" | sed 's/^/  /'
    fi
}

# Compare baseline with current
if [ -f "api-validate/baseline.json" ]; then
    for spec in $API_SPECS; do
        echo "Validating: $spec"
        validate_openapi_changes "api-validate/baseline.json" "$spec"
    done
else
    echo "No baseline found. Creating baseline snapshot..."
    mkdir -p api-validate
    cp "$API_SPECS" api-validate/baseline.json 2>/dev/null || true
fi
```

## Phase 3: Schema Validation

I'll validate API schemas for correctness:

**Validation Checks:**
- Schema syntax correctness
- Required field completeness
- Type consistency
- Reference resolution
- Example validity
- Security definitions

**OpenAPI Validation:**

```bash
#!/bin/bash
# OpenAPI Schema Validator

validate_openapi_schema() {
    local spec="$1"

    # Check for basic OpenAPI structure
    if ! grep -q "openapi:" "$spec"; then
        echo "❌ Invalid OpenAPI spec: missing 'openapi' field"
        return 1
    fi

    # Validate paths exist
    if ! grep -q "paths:" "$spec"; then
        echo "❌ Invalid OpenAPI spec: missing 'paths' section"
        return 1
    fi

    # Check for security definitions if used
    if grep -q "security:" "$spec"; then
        if ! grep -q "securitySchemes:" "$spec"; then
            echo "⚠️  WARNING: 'security' used without 'securitySchemes' definition"
        fi
    fi

    # Validate response codes
    invalid_codes=$(grep -o '"[0-9]\{3\}"' "$spec" | grep -v '"[1-5][0-9][0-9]"' || true)

    if [ ! -z "$invalid_codes" ]; then
        echo "⚠️  WARNING: Invalid HTTP status codes found:"
        echo "$invalid_codes" | sort -u | sed 's/^/  /'
    fi

    echo "✓ Schema validation passed: $spec"
}

# Validate all specs
for spec in $API_SPECS; do
    validate_openapi_schema "$spec"
done
```

## Phase 4: Compatibility Analysis

I'll analyze compatibility across API versions:

**Version Compatibility:**
- Major version changes (breaking allowed)
- Minor version changes (backward compatible)
- Patch version changes (no API changes)

**Client Impact Assessment:**

```markdown
# API Change Impact Report

## Breaking Changes: 2
1. **Removed endpoint**: `DELETE /api/v1/users/{id}`
   - **Impact**: HIGH - Used by admin dashboard
   - **Migration**: Use `POST /api/v2/users/{id}/deactivate`

2. **New required field**: `email` in `CreateUserRequest`
   - **Impact**: HIGH - All user creation flows affected
   - **Migration**: Update all clients to provide email

## Non-Breaking Changes: 5
1. **New endpoint**: `GET /api/v2/users/search`
   - **Impact**: NONE - Additive change

2. **New optional field**: `avatar_url` in `UserResponse`
   - **Impact**: LOW - Existing clients can ignore

## Deprecation Warnings: 1
1. **Deprecated**: `GET /api/v1/users/list`
   - **Replacement**: `GET /api/v2/users`
   - **Removal**: Planned for v3.0.0 (6 months)
```

## Phase 5: Security Contract Validation

I'll validate API security contracts:

**Security Checks:**
- Authentication scheme changes
- Authorization rule modifications
- CORS policy updates
- Rate limiting changes
- API key requirements

```bash
#!/bin/bash
# API Security Contract Validator

validate_api_security() {
    local spec="$1"

    # Check for authentication
    if ! grep -q "securitySchemes:" "$spec"; then
        echo "⚠️  WARNING: No security schemes defined"
    fi

    # Check for HTTPS enforcement
    if grep -q '"scheme": "http"' "$spec"; then
        echo "❌ SECURITY: HTTP scheme detected (use HTTPS)"
    fi

    # Check for sensitive data in URLs
    sensitive_in_path=$(grep -o '"\/[^"]*password[^"]*"' "$spec" || true)
    if [ ! -z "$sensitive_in_path" ]; then
        echo "❌ SECURITY: Sensitive data in URL path:"
        echo "$sensitive_in_path" | sed 's/^/  /'
    fi

    # Check for rate limiting
    if ! grep -q "x-rate-limit" "$spec"; then
        echo "⚠️  INFO: No rate limiting defined"
    fi
}

for spec in $API_SPECS; do
    validate_api_security "$spec"
done
```

## Phase 6: Documentation & Migration

I'll generate comprehensive validation reports:

**Validation Report Structure:**
```markdown
# API Validation Report - [timestamp]

## Executive Summary
- **Total Changes**: 12
- **Breaking Changes**: 2 ❌
- **Deprecations**: 1 ⚠️
- **New Features**: 9 ✅

## Semantic Versioning Recommendation
- Current: v1.5.3
- Recommended: v2.0.0 (breaking changes detected)

## Detailed Change Analysis
[Per-endpoint breakdown]

## Migration Guide
[Step-by-step migration instructions]

## Consumer Impact
- **Web App**: HIGH (requires updates)
- **Mobile App**: MEDIUM (optional features)
- **Third-Party**: HIGH (breaking changes)

## Timeline
- Deprecation notices: Immediate
- Migration period: 90 days
- Removal date: [date]
```

## Context Continuity

**Session Resume:**
When you return and run `/api-validate` or `/api-validate resume`:
- Load baseline contracts
- Compare current state
- Show new changes since last validation
- Track change history

**Progress Example:**
```
RESUMING API VALIDATION
├── Baseline: v1.5.2 (2025-01-15)
├── Current: v1.6.0-dev
├── Changes since baseline: 8
├── Breaking changes: 0
└── Status: Compatible ✓

Analyzing changes...
```

## Practical Examples

**Initial Validation:**
```
/api-validate                    # Auto-discover and validate
/api-validate docs/openapi.yaml  # Validate specific spec
/api-validate baseline           # Create new baseline
```

**Comparison Mode:**
```
/api-validate compare v1.5.0 v1.6.0  # Compare versions
/api-validate diff main feature/api  # Compare git branches
```

**Session Control:**
```
/api-validate resume    # Continue from last session
/api-validate status    # Show validation summary
/api-validate report    # Generate detailed report
```

## Safety Guarantees

**Protection Measures:**
- Read-only analysis (no API modifications)
- Git checkpoint before baseline updates
- Clear change categorization
- Migration path documentation

**Important:** I will NEVER:
- Modify API specifications without confirmation
- Auto-apply breaking changes
- Skip security validation
- Add AI attribution

## Skill Integration

When appropriate, I may suggest:
- `/security-scan` - Validate API security implementation
- `/docs` - Update API documentation
- `/commit` - Commit baseline snapshots

## Advanced Validation

**Contract Testing:**
```bash
# Validate API contract matches implementation
test_contract_compliance() {
    # Start API server
    npm start &
    API_PID=$!
    sleep 5

    # Test each endpoint
    for endpoint in $(grep -o '"\/api\/[^"]*"' openapi.yaml); do
        response=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:3000$endpoint")

        if [ "$response" = "404" ]; then
            echo "❌ Endpoint not implemented: $endpoint"
        fi
    done

    # Cleanup
    kill $API_PID
}
```

**GraphQL Schema Validation:**
```bash
# Validate GraphQL schema changes
validate_graphql_schema() {
    local baseline="$1"
    local current="$2"

    # Check for removed types
    baseline_types=$(grep "^type " "$baseline" | awk '{print $2}' | sort)
    current_types=$(grep "^type " "$current" | awk '{print $2}' | sort)

    removed_types=$(comm -23 <(echo "$baseline_types") <(echo "$current_types"))

    if [ ! -z "$removed_types" ]; then
        echo "❌ BREAKING: Removed GraphQL types:"
        echo "$removed_types" | sed 's/^/  /'
    fi

    # Check for removed fields
    baseline_fields=$(grep -E "^\s+[a-zA-Z]+" "$baseline" | sort)
    current_fields=$(grep -E "^\s+[a-zA-Z]+" "$current" | sort)

    removed_fields=$(comm -23 <(echo "$baseline_fields") <(echo "$current_fields"))

    if [ ! -z "$removed_fields" ]; then
        echo "❌ BREAKING: Removed fields:"
        echo "$removed_fields" | sed 's/^/  /'
    fi
}
```

## What I'll Actually Do

1. **Discover APIs** - Find all API specifications using Grep
2. **Create baseline** - Snapshot current contract state
3. **Deep analysis** - Use extended thinking for complex changes
4. **Detect breaks** - Identify breaking vs non-breaking changes
5. **Validate security** - Check security contract integrity
6. **Generate report** - Comprehensive change documentation
7. **Track evolution** - Maintain validation history

I'll ensure perfect API contract continuity, detecting all breaking changes and providing clear migration paths for API consumers.

**Credits:** API validation methodology based on OpenAPI specification standards and semantic versioning best practices.
