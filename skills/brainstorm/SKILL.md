---
name: brainstorm
description: Interactive design refinement with structured exploration
disable-model-invocation: false
---

# Interactive Design Brainstorming

I'll help you explore and refine design ideas through structured brainstorming sessions with comprehensive documentation.

Arguments: `$ARGUMENTS` - design challenge, feature idea, or problem to solve

**Token Optimization:**
- ✅ Session-based idea tracking (already implemented)
- ✅ Incremental idea generation (one at a time, not all at once)
- ✅ Caching previous ideas and evaluations
- ✅ Focused exploration (target area specified)
- ✅ Progressive depth (high-level → detailed only if needed)
- ✅ Template-based idea formats (no repeated explanations)
- **Expected tokens:** 1,200-2,500 (vs. 3,000-5,000 unoptimized)
- **Optimization status:** ✅ Optimized (Phase 2 Batch 2, 2026-01-26)

**Caching Behavior:**
- Session location: `brainstorm/` (plan.md, state.json, ideas.md)
- Cache location: `.claude/cache/brainstorm/session-state.json`
- Caches: Generated ideas, evaluations, decisions
- Cache validity: Until session explicitly ended
- Shared with: `/write-plan`, `/design-review` skills

**Usage:**
- `brainstorm "feature idea"` - Start session (1,500-2,500 tokens)
- `brainstorm resume` - Continue session (800-1,500 tokens)
- `brainstorm export` - Export ideas (500-1,000 tokens)
- `brainstorm decide` - Make decision (600-1,200 tokens)

## Session Intelligence

I'll maintain brainstorming session continuity:

**Session Files (in current project directory):**
- `brainstorm/plan.md` - Session goals and ideas
- `brainstorm/state.json` - Session state and decisions
- `brainstorm/ideas.md` - All generated ideas and evaluations

**IMPORTANT:** Session files are stored in a `brainstorm` folder in your current project root

**Auto-Detection:**
- If session exists: Resume and build on previous ideas
- If no session: Start fresh brainstorming session
- Commands: `resume`, `export`, `decide`, `status`

## Phase 1: Problem Definition & Context

### Extended Thinking for Design Exploration

For complex design challenges, I'll use extended thinking to explore solution spaces:

<think>
When brainstorming design solutions:
- Multiple architectural approaches and their tradeoffs
- User experience implications of different designs
- Technical feasibility and implementation complexity
- Scalability and performance considerations
- Security and privacy implications
- Accessibility and inclusive design aspects
- Long-term maintenance and evolution paths
</think>

**Triggers for Extended Analysis:**
- Complex system architecture decisions
- User experience design challenges
- Performance-critical features
- Security-sensitive components
- Scalable solution design

**MANDATORY FIRST STEPS:**
1. Check if `brainstorm` directory exists in current working directory
2. If directory exists, check for session files:
   - Look for `brainstorm/state.json`
   - Look for `brainstorm/ideas.md`
   - If found, resume and build on existing ideas
3. If no directory or session exists:
   - Define the problem clearly
   - Set session goals
   - Initialize idea tracking

**Problem Definition:**

```markdown
# Brainstorm Session - [timestamp]

## Problem Statement
**Challenge**: [clear description of what we're solving]
**Context**: [background information]
**Constraints**: [technical, business, or resource constraints]
**Success Criteria**: [what makes a solution successful]

## Stakeholders
- **Users**: [who will use this]
- **Team**: [who will build/maintain this]
- **Business**: [business objectives]

## Current State
**Existing Solutions**: [what exists today]
**Pain Points**: [what's not working]
**Opportunities**: [what could be better]

## Session Goals
- [ ] Generate 10+ diverse ideas
- [ ] Evaluate top 3 ideas in detail
- [ ] Create prototype plan for best idea
- [ ] Document decision rationale
```

**Context Gathering (Token-Efficient):**

```bash
#!/bin/bash
# Gather project context for informed brainstorming

gather_brainstorm_context() {
    echo "=== Project Context Analysis ==="
    echo ""

    # 1. Technology stack (using Grep)
    echo "Current Tech Stack:"
    if [ -f "package.json" ]; then
        grep -o '"[^"]*":\s*"[^"]*"' package.json | grep -E "react|vue|angular|express|next" | head -10 || echo "  JavaScript/Node.js project"
    elif [ -f "requirements.txt" ]; then
        grep -E "django|flask|fastapi" requirements.txt | head -5 || echo "  Python project"
    fi

    # 2. Existing patterns (find similar features)
    echo ""
    echo "Similar Existing Features:"
    find . -type f -name "*.js" -o -name "*.py" -o -name "*.ts" | head -10

    # 3. Architecture patterns
    echo ""
    echo "Architecture Patterns:"
    if [ -d "src/components" ]; then
        echo "  ✓ Component-based architecture"
    fi
    if [ -d "src/services" ]; then
        echo "  ✓ Service layer pattern"
    fi
    if [ -d "tests" ] || [ -d "test" ]; then
        echo "  ✓ Test coverage present"
    fi

    # 4. Dependencies and capabilities
    echo ""
    echo "Available Libraries:"
    if [ -f "package.json" ]; then
        grep '"dependencies":' -A 20 package.json | grep -o '"[^"]*":' | head -10
    fi
}

mkdir -p brainstorm
gather_brainstorm_context > brainstorm/context.md
cat brainstorm/context.md
```

## Phase 2: Divergent Thinking - Idea Generation

I'll generate diverse ideas using multiple techniques:

**Brainstorming Techniques:**

1. **SCAMPER Method:**
   - **S**ubstitute - What can be replaced?
   - **C**ombine - What can be merged?
   - **A**dapt - What can be adapted from elsewhere?
   - **M**odify - What can be changed?
   - **P**ut to other uses - What else could it do?
   - **E**liminate - What can be removed?
   - **R**everse - What can be done backwards?

2. **Six Thinking Hats:**
   - **White Hat**: Facts and data
   - **Red Hat**: Emotions and intuition
   - **Black Hat**: Risks and criticisms
   - **Yellow Hat**: Benefits and optimism
   - **Green Hat**: Creativity and alternatives
   - **Blue Hat**: Process and control

3. **Random Association:**
   - Take random words/concepts
   - Force connections to problem
   - Explore unexpected angles

**Idea Generation Template:**

```markdown
## Idea Pool

### Idea #1: [Name]
**Category**: Feature | Architecture | UX | Performance | Security
**Description**: [2-3 sentence description]
**Inspiration**: [what inspired this idea]
**Quick Sketch**: [simple diagram or pseudocode]

**Pros:**
- ✅ [benefit 1]
- ✅ [benefit 2]

**Cons:**
- ❌ [drawback 1]
- ❌ [drawback 2]

**Effort**: Low | Medium | High
**Impact**: Low | Medium | High
**Innovation**: 🔥🔥🔥 (1-5 flames)

---

### Idea #2: [Name]
[Same structure...]
```

**Automated Idea Prompting:**

```bash
#!/bin/bash
# Generate idea prompts using random associations

generate_idea_prompts() {
    local problem="$1"

    # Random word lists for inspiration
    adjectives=("fast" "secure" "simple" "elegant" "robust" "flexible" "scalable" "intuitive")
    verbs=("streamline" "automate" "simplify" "enhance" "optimize" "integrate" "transform" "revolutionize")
    technologies=("AI" "blockchain" "microservices" "real-time" "progressive" "reactive" "serverless" "edge")

    echo "=== Idea Prompts ==="
    echo ""

    for i in {1..5}; do
        adj=${adjectives[$RANDOM % ${#adjectives[@]}]}
        verb=${verbs[$RANDOM % ${#verbs[@]}]}
        tech=${technologies[$RANDOM % ${#technologies[@]}]}

        echo "$i. What if we ${verb} the solution to be more ${adj} using ${tech}?"
    done

    echo ""
    echo "=== Alternative Angles ==="
    echo ""
    echo "- What would [competitor] do?"
    echo "- What if we had unlimited budget?"
    echo "- What if we had to ship tomorrow?"
    echo "- What would the simplest solution look like?"
    echo "- What would the most ambitious solution look like?"
}

generate_idea_prompts "$ARGUMENTS" >> brainstorm/prompts.md
```

## Phase 3: Convergent Thinking - Evaluation

I'll evaluate and refine the most promising ideas:

**Evaluation Framework:**

```markdown
## Idea Evaluation Matrix

| Idea | Impact | Effort | Feasibility | Innovation | Score |
|------|--------|--------|-------------|------------|-------|
| Idea 1 | 8 | 3 | 9 | 7 | 6.75 |
| Idea 2 | 6 | 8 | 4 | 9 | 5.25 |
| Idea 3 | 9 | 5 | 8 | 6 | 7.00 |

**Scoring**: 1-10 scale
**Formula**: (Impact × 2 + Feasibility × 1.5 - Effort × 0.5 + Innovation × 1) / 5

## Top 3 Ideas for Deep Dive

### 🥇 Winner: Idea #3 - [Name]
**Total Score**: 7.00

**Detailed Analysis**:
- **Technical Feasibility**: [deep dive into implementation]
- **User Impact**: [how it helps users]
- **Business Value**: [ROI and metrics]
- **Risks**: [what could go wrong]
- **Dependencies**: [what's needed]

**Implementation Sketch**:
```
[Pseudocode or architecture diagram]
```

**Next Steps**:
1. Create technical spike for proof of concept
2. Design detailed architecture
3. Build prototype
4. User testing

### 🥈 Runner-up: Idea #1 - [Name]
[Similar detailed analysis]

### 🥉 Third Place: Idea #5 - [Name]
[Similar detailed analysis]
```

**Decision Matrix Script:**

```bash
#!/bin/bash
# Calculate idea scores and rank

rank_ideas() {
    cat > brainstorm/ranking.csv << 'EOF'
Idea,Impact,Effort,Feasibility,Innovation
Idea 1,8,3,9,7
Idea 2,6,8,4,9
Idea 3,9,5,8,6
EOF

    echo "=== Idea Rankings ==="
    echo ""

    while IFS=, read -r idea impact effort feasibility innovation; do
        [ "$idea" = "Idea" ] && continue

        # Calculate score: (Impact*2 + Feasibility*1.5 - Effort*0.5 + Innovation*1) / 5
        score=$(echo "scale=2; ($impact * 2 + $feasibility * 1.5 - $effort * 0.5 + $innovation * 1) / 5" | bc)

        echo "$idea: $score"
    done < brainstorm/ranking.csv | sort -t: -k2 -rn

    echo ""
    echo "Top idea selected based on impact, feasibility, and innovation!"
}

rank_ideas
```

## Phase 4: Prototyping & Validation

I'll help create quick prototypes to validate ideas:

**Rapid Prototyping:**

```markdown
## Prototype Plan - [Top Idea Name]

### Phase 1: Technical Spike (2 hours)
**Goal**: Prove core technical concept works

**Tasks**:
- [ ] Set up minimal environment
- [ ] Implement core algorithm/feature
- [ ] Test with sample data
- [ ] Document findings

**Code Sketch**:
```javascript
// Minimal proof of concept
function coreFeature(input) {
    // Key logic here
    return output;
}

// Test it
console.log(coreFeature(testData));
```

### Phase 2: User Flow Prototype (3 hours)
**Goal**: Validate user experience

**Tasks**:
- [ ] Create wireframes/mockups
- [ ] Build interactive prototype
- [ ] User testing with 3-5 people
- [ ] Gather feedback

### Phase 3: Integration Test (2 hours)
**Goal**: Ensure it fits in existing system

**Tasks**:
- [ ] Identify integration points
- [ ] Test with real dependencies
- [ ] Measure performance impact
- [ ] Document integration approach
```

**Quick Prototype Generator:**

```bash
#!/bin/bash
# Generate prototype scaffolding

create_prototype() {
    local idea_name="$1"
    local prototype_dir="brainstorm/prototype-${idea_name}"

    mkdir -p "$prototype_dir"

    cat > "$prototype_dir/README.md" << 'EOF'
# Prototype: [Idea Name]

## Goal
Validate that [core concept] works as expected

## Setup
```bash
# Setup instructions
```

## Running
```bash
# How to run prototype
```

## Results
- [ ] Core concept validated
- [ ] Performance acceptable
- [ ] Integration feasible
- [ ] User experience positive

## Findings
[Document learnings]

## Decision
[ ] Proceed with full implementation
[ ] Needs more work
[ ] Not viable
EOF

    echo "Prototype scaffold created: $prototype_dir"
}

create_prototype "$(echo $ARGUMENTS | tr ' ' '-')"
```

## Phase 5: Decision Documentation

I'll document the decision process and rationale:

**Decision Record:**

```markdown
# Architecture Decision Record (ADR)

## Status
[Proposed | Accepted | Rejected | Deprecated | Superseded]

## Context
[What problem are we solving? What constraints exist?]

## Decision
We will [decision statement].

## Alternatives Considered

### Alternative 1: [Name]
**Pros**: [benefits]
**Cons**: [drawbacks]
**Reason for rejection**: [why we didn't choose this]

### Alternative 2: [Name]
**Pros**: [benefits]
**Cons**: [drawbacks]
**Reason for rejection**: [why we didn't choose this]

## Consequences

### Positive
- [benefit 1]
- [benefit 2]

### Negative
- [tradeoff 1]
- [tradeoff 2]

### Neutral
- [side effect 1]

## Implementation Plan
1. [Step 1]
2. [Step 2]
3. [Step 3]

## Success Metrics
- [metric 1]: [target]
- [metric 2]: [target]

## Review Date
[When to review this decision]
```

## Context Continuity

**Session Resume:**
When you return and run `/brainstorm` or `/brainstorm resume`:
- Load previous ideas and evaluations
- Show decision status
- Continue refinement or explore new angles
- Build on previous thinking

**Progress Example:**
```
RESUMING BRAINSTORM SESSION
├── Topic: User authentication redesign
├── Ideas generated: 12
├── Evaluated: Top 3
├── Prototype: In progress (Idea #3)
└── Status: Validating technical feasibility

Continuing brainstorming...
```

## Practical Examples

**Start Brainstorming:**
```
/brainstorm "improve app performance"
/brainstorm "redesign user dashboard"
/brainstorm "add real-time collaboration"
```

**Session Control:**
```
/brainstorm resume       # Continue session
/brainstorm export       # Export ideas to markdown
/brainstorm decide       # Force decision on top idea
/brainstorm status       # Show current progress
```

**Evaluation:**
```
/brainstorm evaluate     # Run evaluation matrix
/brainstorm prototype    # Create prototype scaffold
/brainstorm adr          # Generate decision record
```

## Brainstorming Best Practices

**Do:**
- ✅ Generate quantity first (defer judgment)
- ✅ Build on others' ideas
- ✅ Encourage wild ideas
- ✅ Stay focused on topic
- ✅ Visualize concepts
- ✅ Time-box sessions

**Don't:**
- ❌ Criticize during generation phase
- ❌ Get stuck on first idea
- ❌ Ignore constraints entirely
- ❌ Skip evaluation phase
- ❌ Forget to document decisions

## Collaborative Features

**Export for Team Review:**

```bash
#!/bin/bash
# Export brainstorm session for team

export_brainstorm() {
    cat > brainstorm/EXPORT.md << EOF
# Brainstorm Export - $(date +%Y-%m-%d)

$(cat brainstorm/plan.md)

---

$(cat brainstorm/ideas.md)

---

## Decision
$(cat brainstorm/decision.md 2>/dev/null || echo "Pending team discussion")

---

## Next Steps
- [ ] Team review (by [date])
- [ ] Prototype (by [date])
- [ ] Decision (by [date])
EOF

    echo "Exported to: brainstorm/EXPORT.md"
    echo "Share with team for review!"
}

export_brainstorm
```

## Safety Guarantees

**Protection Measures:**
- All ideas documented (no lost thinking)
- Clear decision trails
- Reversible choices with git
- No commitment without approval

**Important:** I will NEVER:
- Implement without approval
- Skip evaluation phase
- Ignore constraints
- Add AI attribution

## Skill Integration

When appropriate, I may suggest:
- `/write-plan` - Convert best idea to implementation plan
- `/scaffold` - Generate code from chosen design
- `/docs` - Document architecture decision

## Advanced Techniques

**Mind Mapping:**
```
Problem
├── Aspect 1
│   ├── Solution A
│   └── Solution B
├── Aspect 2
│   ├── Solution C
│   └── Solution D
└── Aspect 3
    ├── Solution E
    └── Solution F
```

**5 Whys Analysis:**
```
Problem: Users abandon checkout
├── Why? Process is too long
│   └── Why? Too many form fields
│       └── Why? We ask for unnecessary data
│           └── Why? Legacy requirements
│               └── Why? No one reviewed in 3 years
```

**Crazy 8s:**
- Set 8-minute timer
- Sketch 8 different solutions
- No judging, just rapid ideation
- Review and combine best elements

## What I'll Actually Do

1. **Define problem** - Clear problem statement and context
2. **Gather context** - Use Grep to understand project
3. **Generate ideas** - Multiple brainstorming techniques
4. **Deep thinking** - Extended analysis for complex challenges
5. **Evaluate options** - Scoring and ranking ideas
6. **Create prototypes** - Quick validation of top ideas
7. **Document decisions** - Clear rationale and ADRs
8. **Export results** - Team-ready documentation

I'll maintain complete brainstorming continuity, preserving all ideas and building on previous sessions.

**Credits:** Brainstorming methodology based on design thinking principles and creative problem-solving frameworks.
