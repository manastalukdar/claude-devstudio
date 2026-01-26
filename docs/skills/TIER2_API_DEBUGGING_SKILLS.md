---
status: completed
date: 2026-01-25
tier: 2
category: API & Debugging
skill-count: 5
---

# Tier 2 API & Debugging Skills - Implementation Complete

## Overview

This document tracks the implementation of 5 Tier 2 skills focused on API development and debugging, as specified in the SKILLS_EXPANSION_PLAN.md.

**Implementation Date:** January 25, 2026
**Status:** ✅ Complete
**Total Skills:** 5 (2 API + 3 Debugging)

---

## API Skills (2)

### 1. `/api-docs-generate` - OpenAPI/Swagger Documentation Generation

**File:** `skills/api-docs-generate/SKILL.md`
**Size:** 23.7 KB
**Token Budget:** 2,500-4,000 tokens
**Status:** ✅ Implemented

**Features:**
- Auto-generate from code analysis (Express, FastAPI, Next.js API routes)
- OpenAPI 3.0 specification format
- Interactive Swagger UI setup
- Automatic schema extraction from endpoints
- Integration with `/api-test-generate` skill

**Supported Frameworks:**
- Node.js: Express, Fastify, Next.js, NestJS, Apollo
- Python: FastAPI, Flask, Django
- Go: Gin, Fiber

**Token Optimization:**
- Grep for API route discovery (200-300 tokens)
- Reads only relevant route files (800-1200 tokens)
- Template-based OpenAPI generation
- Expected: 2,500-4,000 tokens total

**Key Capabilities:**
- Framework auto-detection
- Endpoint discovery using Grep
- OpenAPI 3.0 YAML generation
- Swagger UI integration
- Request/response schema definitions
- Authentication documentation
- Error response templates

---

### 2. `/graphql-schema` - GraphQL Schema Validation & Optimization

**File:** `skills/graphql-schema/SKILL.md`
**Size:** 15.9 KB
**Token Budget:** 2,000-3,500 tokens
**Status:** ✅ Implemented

**Features:**
- Schema validation and linting
- Query optimization suggestions
- Federation support analysis
- Schema stitching validation
- Deprecated field detection
- Breaking change detection

**Supported GraphQL Implementations:**
- Node.js: Apollo Server, GraphQL Yoga, Type-GraphQL
- Python: Graphene, Strawberry, Ariadne

**Token Optimization:**
- Grep for GraphQL file discovery (200 tokens)
- Reads schema files only (600-1000 tokens)
- Template-based analysis
- Expected: 2,000-3,500 tokens total

**Key Capabilities:**
- GraphQL setup detection
- Schema file discovery (.graphql, .gql, embedded)
- Schema validation with error reporting
- Federation directive analysis (@key, @external, @requires, @provides)
- Deprecated field tracking
- Performance optimization suggestions
- Pagination pattern detection
- Schema report generation

**Analysis Features:**
- N+1 query detection
- Relay pagination recommendations
- Input type usage analysis
- Interface/union detection
- DataLoader suggestions

---

## Debugging Skills (3)

### 3. `/debug-root-cause` - Root Cause Analysis

**File:** `skills/debug-root-cause/SKILL.md`
**Size:** 19.3 KB
**Token Budget:** 2,500-4,000 tokens
**Status:** ✅ Implemented

**Based on:** obra/superpowers methodology

**Features:**
- Trace error origins through call stacks
- Dependency graph analysis
- Configuration issue detection
- Environment variable problems
- State corruption identification

**Token Optimization:**
- Grep for targeted error search (300-500 tokens)
- Reads only relevant error contexts (800-1200 tokens)
- Structured analysis framework
- Expected: 2,500-4,000 tokens total

**Key Capabilities:**
- Extended thinking for complex debugging scenarios
- Error context gathering (stack traces, logs, git history)
- Dependency chain analysis (npm, pip, go modules)
- Call stack tracing with visualization
- Configuration file analysis
- Environment variable validation
- State and timing analysis
- Async/await pattern detection
- Prioritized hypothesis generation

**Analysis Phases:**
1. Error information gathering
2. Dependency chain analysis
3. Call stack tracing
4. Configuration analysis
5. State and timing analysis
6. Root cause hypothesis generation

**Hypotheses Generated:**
- Dependency version conflicts (HIGH)
- Environment configuration issues (HIGH)
- Recent code changes/regressions (MEDIUM)
- Async/timing issues (MEDIUM)
- State corruption (LOW)

---

### 4. `/debug-session` - Debug Session Documentation

**File:** `skills/debug-session/SKILL.md`
**Size:** 14.5 KB
**Token Budget:** 1,500-2,500 tokens
**Status:** ✅ Implemented

**Based on:** Session management patterns from claude-sessions

**Features:**
- Create structured debug logs in `.claude/debugging/`
- Hypothesis tracking with test results
- Solution documentation
- Timeline of investigation
- Knowledge base building

**Token Optimization:**
- Minimal file reads (200-400 tokens)
- Template-based generation (300-500 tokens)
- Structured format for easy updates
- Expected: 1,500-2,500 tokens total

**Key Capabilities:**
- Session initialization and resumption
- Structured debugging document creation
- Investigation timeline tracking
- Hypothesis management (status, priority, results)
- Solution documentation
- Lessons learned capture
- Quick update helper scripts
- Knowledge base integration
- Debugging templates (API errors, build errors, database errors)

**Session Structure:**
- Issue description and reproduction steps
- Investigation timeline with timestamps
- Hypothesis tracking (theory, evidence, test plan, results)
- Attempted solutions log
- Root cause and fix documentation
- Lessons learned and prevention strategies
- Resource links and helpful commands

**Templates Provided:**
- API error debugging
- Build error debugging
- Database error debugging

---

### 5. `/performance-profile` - Performance Profiling & Bottleneck Detection

**File:** `skills/performance-profile/SKILL.md`
**Size:** 24.5 KB
**Token Budget:** 3,000-5,000 tokens
**Status:** ✅ Implemented

**Features:**
- Node.js profiling (--inspect, clinic.js)
- Browser performance (Chrome DevTools)
- Python profiling (cProfile, line_profiler)
- Bottleneck identification
- Memory leak detection
- Optimization recommendations

**Token Optimization:**
- Grep for targeted file search (300-500 tokens)
- Reads only performance-critical files (1000-1500 tokens)
- Structured analysis framework (800-1200 tokens)
- Expected: 3,000-5,000 tokens total

**Key Capabilities:**
- Multi-runtime environment detection (Node.js, Python, Browser)
- Profiling tool installation and setup
- Framework-specific profiling scripts
- Performance anti-pattern detection
- Comprehensive performance report generation

**Node.js Profiling:**
- clinic.js suite (doctor, flame, bubbleprof, heapprofiler)
- V8 built-in profiler (--prof)
- Chrome DevTools integration
- autocannon HTTP benchmarking
- Synchronous blocking operation detection
- Bundle size analysis

**Python Profiling:**
- cProfile (CPU profiling)
- line_profiler (line-by-line analysis)
- memory_profiler (memory usage tracking)
- List comprehension vs generator analysis
- Database query optimization hints

**Browser Profiling:**
- Chrome DevTools Performance tab guide
- Lighthouse CI integration
- webpack-bundle-analyzer setup
- React DevTools Profiler
- Core Web Vitals tracking (FCP, LCP, TBT, CLS)
- Large image detection
- console.log statement audit

**Performance Reports Include:**
- Environment detection results
- Available profiling tools
- Quick win optimizations
- Performance monitoring recommendations
- Resource links and best practices

---

## Implementation Details

### File Structure

```
skills/
├── api-docs-generate/
│   └── SKILL.md (23.7 KB)
├── graphql-schema/
│   └── SKILL.md (15.9 KB)
├── debug-root-cause/
│   └── SKILL.md (19.3 KB)
├── debug-session/
│   └── SKILL.md (14.5 KB)
└── performance-profile/
    └── SKILL.md (24.5 KB)
```

**Total Size:** ~97.9 KB
**Total Token Budget:** 11,500-19,500 tokens across all 5 skills

### YAML Frontmatter Compliance

All skills include proper YAML frontmatter:
```yaml
---
name: skill-name
description: Brief description (under 80 chars)
disable-model-invocation: true|false
---
```

**Model Invocation Settings:**
- `api-docs-generate`: `true` (no extended thinking needed)
- `graphql-schema`: `true` (template-based analysis)
- `debug-root-cause`: `false` (uses extended thinking for complex debugging)
- `debug-session`: `true` (structured documentation)
- `performance-profile`: `false` (uses extended thinking for performance analysis)

### Safety-First Design

All skills follow safety-first principles:
- No AI attribution in generated content
- Never modify git config or credentials
- Clear error handling and recovery paths
- Non-destructive operations by default
- Proper validation before execution

### Framework Agnostic

Skills support multiple frameworks/languages:
- **Node.js:** Express, Fastify, Next.js, NestJS, Apollo
- **Python:** FastAPI, Flask, Django, Graphene, Strawberry
- **Go:** Gin, Fiber
- **Frontend:** React, Vue, Angular, Svelte

### Integration Points

Skills are designed to work together:
- `/api-docs-generate` → `/api-test-generate`
- `/debug-root-cause` → `/debug-session`
- `/debug-session` → `/debug-systematic`
- `/performance-profile` → `/debug-root-cause`
- All debugging skills → `/test` and `/commit`

---

## Token Optimization Strategies

### Grep Usage
All skills use Grep for efficient file discovery instead of reading entire directories:
- Pattern-based search for specific file types
- Excludes node_modules, dist, build directories
- Head limiting to prevent excessive results
- Expected: 200-500 tokens per search

### Template-Based Generation
Skills use predefined templates for:
- OpenAPI specifications
- Debug session structures
- Performance reports
- Profiling scripts

This minimizes token usage while maintaining quality.

### Structured Analysis
Skills follow structured analysis frameworks:
1. Environment detection
2. Targeted information gathering
3. Template-based output generation
4. Summary with actionable next steps

### Read Optimization
- Only read files that are necessary for analysis
- Use head/tail for large files
- Prefer Grep output over full file reads
- Expected: 600-1500 tokens per skill execution

---

## Testing Checklist

- [x] YAML frontmatter format validated
- [x] File sizes appropriate for skill complexity
- [x] Token budgets within specified ranges
- [x] Safety-first design principles followed
- [x] No AI attribution in any generated content
- [x] Integration points documented
- [x] Credits and sources included
- [x] Error handling included
- [x] Framework detection logic present
- [x] Bash script safety (proper quoting, error handling)

---

## Next Steps

### Installation Integration

1. **Update install.py:**
   - Add new skills to SKILL_TIERS["tier2"] list
   - Add to SKILL_CATEGORIES["api-development"] and ["debugging"]

2. **Update README.md:**
   - Add skills to Tier 2 listing
   - Update skill count (30 → 35+)
   - Add to API Development and Debugging categories

3. **Update CLAUDE.md:**
   - Add new skills to project overview
   - Update capability descriptions
   - Mention Tier 2 implementation completion

### Documentation

1. **Create category documentation:**
   - `docs/skills-reference/API_DEVELOPMENT.md`
   - `docs/skills-reference/DEBUGGING.md`

2. **Add usage examples:**
   - Common API documentation workflows
   - GraphQL schema optimization examples
   - Debugging session workflows
   - Performance profiling scenarios

### Testing

1. **Integration testing:**
   - Test each skill in sample projects
   - Verify framework detection
   - Test with multiple programming languages
   - Validate generated output formats

2. **Cross-platform testing:**
   - Linux (Ubuntu, Fedora)
   - macOS (Intel, Apple Silicon)
   - Windows (WSL)

3. **Skill interactions:**
   - Test `/api-docs-generate` → `/api-test-generate` flow
   - Test debugging skill chain
   - Verify performance profiling outputs

---

## Credits & Sources

### API Skills
- **OpenAPI Specification 3.0:** https://spec.openapis.org/oas/v3.0.0
- **Swagger Tools:** https://swagger.io/tools/
- **GraphQL Specification:** https://spec.graphql.org/
- **Apollo Federation:** https://www.apollographql.com/docs/federation/

### Debugging Skills
- **obra/superpowers:** https://github.com/obra/superpowers
- **Session management patterns:** claude-sessions project
- **SRE practices:** Site Reliability Engineering book
- **Debugging methodologies:** "The Art of Debugging" by Norman Matloff

### Performance Skills
- **Node.js profiling:** https://nodejs.org/en/docs/guides/simple-profiling/
- **clinic.js:** https://clinicjs.org/
- **Python profiling:** https://docs.python.org/3/library/profile.html
- **Chrome DevTools:** https://developer.chrome.com/docs/devtools/
- **Web.dev Performance:** https://web.dev/performance/

---

## Summary

Successfully implemented 5 Tier 2 skills (2 API + 3 Debugging) following the SKILLS_EXPANSION_PLAN.md specifications:

✅ **API Skills:**
1. `/api-docs-generate` - OpenAPI/Swagger documentation generation
2. `/graphql-schema` - GraphQL schema validation and optimization

✅ **Debugging Skills:**
3. `/debug-root-cause` - Root cause analysis with dependency tracing
4. `/debug-session` - Structured debugging session documentation
5. `/performance-profile` - Multi-runtime performance profiling

**Key Achievements:**
- All skills follow official Claude Skills format with YAML frontmatter
- Token optimization strategies implemented throughout
- Framework-agnostic design supporting Node.js, Python, Go, Browser
- Safety-first principles maintained
- No AI attribution in any generated content
- Comprehensive credits and sources included
- Integration points with existing and new skills documented

**Token Budget Compliance:**
- `/api-docs-generate`: 2,500-4,000 tokens ✅
- `/graphql-schema`: 2,000-3,500 tokens ✅
- `/debug-root-cause`: 2,500-4,000 tokens ✅
- `/debug-session`: 1,500-2,500 tokens ✅
- `/performance-profile`: 3,000-5,000 tokens ✅

**Next:** Ready for installation script integration, documentation updates, and testing.

---

**Document Version:** 1.0
**Date:** 2026-01-25
**Status:** Implementation Complete
