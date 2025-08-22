# Claude Code Plugins

## What is `CCPlugins`?

Professional commands for Claude Code CLI that save 2-3 hours per week on repetitive development tasks.

### The Problem

😊 Ask Claude to fix a bug → Get 15 test files  
😤 Request a simple refactor → Receive a dissertation on clean code  
🤪 "Please add a button" → Complete UI framework rewrite  
😭 Every conversation → "Act like a senior engineer who doesn't overengineer"

🚧 **Active Development Notice**: CCPlugins is continuously evolving based on real-world usage. We thoroughly test each command and refine them as we discover gaps and opportunities. This ensures you're always getting battle-tested, production-ready tools that solve actual developer problems.

CCPlugins is a curated set of 29 professional commands that extend Claude Code CLI with enterprise-grade development workflows. These commands leverage Claude's contextual understanding while providing structured, predictable outcomes optimized for Opus 4 and Sonnet 4 models.

## Quick Links

- [🚀 Installation](#installation) - Get started in 30 seconds
- [💻 Commands](#commands) - See all available commands
- [🔧 How It Works](#how-it-works) - Understanding the magic
- [📚 Session Management](#session-management-workflow) - Professional development tracking
- [🧠 Technical Notes](#technical-notes) - Why conversational design matters
- [🤝 Contributing](#contributing) - Help make it better

## Installation

### Quick Install

**Mac/Linux:**

```bash
curl -sSL https://raw.githubusercontent.com/brennercruvinel/CCPlugins/main/install.sh | bash
```

**Windows/Cross-platform:**

```bash
python install.py
```

### Manual Install

```bash
git clone https://github.com/brennercruvinel/CCPlugins.git
cd CCPlugins
python install.py
```

### Uninstall

```bash
# Mac/Linux
./uninstall.sh

# Windows/Cross-platform
python uninstall.py
```

## Commands

29 professional commands optimized for Claude Code CLI's native capabilities with enhanced validation and refinement phases.

### 🚀 Development Workflow

```bash
/cleanproject                    # Remove debug artifacts with git safety
/commit                          # Smart conventional commits with analysis
/format                          # Auto-detect and apply project formatter
/scaffold feature-name           # Generate complete features from patterns
/test                            # Run tests with intelligent failure analysis
/implement url/path/feature      # Import and adapt code from any source with validation phase
/refactor                        # Intelligent code restructuring with validation & de-para mapping
/undo                           # Safe rollback with git checkpoint restore
```

### 🛡️ Code Quality & Security

```bash
/review                # Multi-agent analysis (security, performance, quality, architecture)
/security-scan         # Vulnerability analysis with extended thinking & remediation tracking
/predict-issues        # Proactive problem detection with timeline estimates
/remove-comments       # Clean obvious comments, preserve valuable docs
/fix-imports           # Repair broken imports after refactoring
/find-todos            # Locate and organize development tasks
/create-todos          # Add contextual TODO comments based on analysis results
/fix-todos             # Intelligently implement TODO fixes with context
```

### 🔍 Advanced Analysis

```bash
/understand            # Analyze entire project architecture and patterns
/explain-like-senior   # Senior-level code explanations with context
/contributing          # Complete contribution readiness analysis
/make-it-pretty        # Improve readability without functional changes
```

### 📋 Session & Project Management

```bash
/session-start [name]           # Begin documented sessions with Claude memory integration
/session-update [notes]         # Update current session with timestamped progress  
/session-end                    # Summarize and preserve session context
/session-current                # View current session status and recent updates
/session-list                   # List all past sessions with summaries
/session-help                   # Display session system help and commands
/session-resume                 # Resume previous session work
/sessions-init                  # Initialize and organize session directory structure
/docs                          # Smart documentation management and updates
/todos-to-issues               # Convert code TODOs to GitHub issues
```

## Enhanced Features

### 🔍 Validation & Refinement

Complex commands now include validation phases to ensure completeness:

```bash
/refactor validate   # Find remaining old patterns, verify 100% migration
/implement validate  # Check integration completeness, find loose ends
```

### 🧠 Extended Thinking

Advanced analysis for complex scenarios:

- **Refactoring**: Deep architectural analysis for large-scale changes
- **Security**: Sophisticated vulnerability detection with chain analysis

### 🔗 Pragmatic Command Integration

Natural workflow suggestions without over-engineering:

- Suggests `/test` after major changes
- Recommends `/commit` at logical checkpoints
- Maintains user control, no automatic execution

### 📚 Advanced Session Management

Professional development session tracking system:

- **Session Documentation**: Complete session tracking with goals, progress, and outcomes
- **Context Preservation**: Maintain development context across multiple Claude conversations
- **Session Continuity**: Resume previous work with full historical context
- **Progress Tracking**: Timestamped updates with git state and accomplishments
- **Knowledge Transfer**: Enable team collaboration with detailed session histories

## Real World Example

### Before `/cleanproject`

```plaintext
src/
├── UserService.js
├── UserService.test.js
├── UserService_backup.js    # Old version
├── debug.log               # Debug output
├── test_temp.js           # Temporary test
└── notes.txt              # Dev notes
```

### After `/cleanproject`

```plaintext
src/
├── UserService.js          # Clean production code
└── UserService.test.js     # Actual tests preserved
```

## 🔧 How It Works

### High-Level Architecture

CCPlugins transforms Claude Code CLI into an intelligent development assistant through a sophisticated yet elegant architecture:

```plaintext
Developer → /command → Claude Code CLI → Command Definition → Intelligent Execution
    ↑                                                                       ↓
    ←←←←←←←←←←←←←←←←← Clear Feedback & Results ←←←←←←←←←←←←←←←←←←←
```

### Execution Flow

When you type a command:

1. **Command Loading**: Claude reads the markdown definition from `~/.claude/commands/`
2. **Context Analysis**: Analyzes your project structure, technology stack, and current state
3. **Intelligent Planning**: Creates execution strategy based on your specific situation
4. **Safe Execution**: Performs actions with automatic checkpoints and validation
5. **Clear Feedback**: Provides results, next steps, and any warnings

### Core Architecture Components

**🧠 Intelligent Instructions**

- First-person conversational design activates collaborative reasoning
- Strategic thinking sections (`<think>`) for complex decision-making
- Context-aware adaptations without hardcoded assumptions

**🔧 Native Tool Integration**

- **Grep**: Lightning-fast pattern matching across codebases
- **Glob**: Intelligent file discovery and project mapping
- **Read**: Content analysis with full context understanding
- **Write**: Safe file modifications with automatic backups
- **TodoWrite**: Progress tracking and task management
- **Task**: Sub-agent orchestration for specialized analysis

**🛡️ Safety-First Design**

- Automatic git checkpoints before destructive operations
- Session persistence for cross-context continuity
- Rollback capabilities with clear recovery paths
- No AI attribution in commits or generated content

**🌐 Universal Compatibility**

- Framework-agnostic with intelligent auto-detection
- Cross-platform support (Windows, Linux, macOS)
- Works with any programming language or stack
- Adapts to your project's conventions and patterns

### Advanced Features

**🔄 Session Continuity**
Commands like `/implement` and `/refactor` maintain state across Claude sessions:

```
# Each command creates its own folder in project root:
refactor/                  # Created by /refactor command
├── plan.md               # Refactoring roadmap
└── state.json            # Completed transformations

implement/                 # Created by /implement command
├── plan.md               # Implementation progress
└── state.json            # Session state and decisions

fix-imports/              # Created by /fix-imports command
├── plan.md               # Import fixes plan
└── state.json            # Resolution progress

security-scan/            # Created by /security-scan command
├── plan.md               # Vulnerabilities and fixes
└── state.json            # Remediation progress

scaffold/                 # Created by /scaffold command
├── plan.md               # Scaffolding plan
└── state.json            # Created files tracking
```

**📚 Session Management System**
Advanced session tracking with Claude Code integration:

```
.claude/                   # Claude Code directory
├── sessions/             # Session storage directory
│   ├── .current-session # Tracks active session filename
│   ├── 2025-01-16-1347-feature-auth.md  # Named session file
│   ├── 2025-01-17-0930.md               # Timestamp-only session
│   └── feature-areas/    # Organized by project areas
│       ├── authentication/
│       ├── database/
│       └── ui-components/
└── CLAUDE.md            # Claude Code memory file
```

**🤖 Multi-Agent Architecture**
Complex commands orchestrate specialized sub-agents:

- Security analysis agent for vulnerability detection
- Performance optimization agent for bottleneck identification
- Architecture review agent for design pattern analysis
- Code quality agent for maintainability assessment

**📊 Performance Optimizations**

- Reduced verbosity for senior developer efficiency
- Smart caching of project analysis results
- Incremental processing for large codebases
- Parallel execution of independent tasks

## 🧠 Technical Notes

### Design Philosophy

**Why This Approach Works** (Based on Anthropic's Research):

- **Conversational Commands**: First-person language ("I'll help...") activates Claude's collaborative reasoning
- **Build-Agnostic Instructions**: No hardcoded tools = works everywhere
- **Think Tool Integration**: Strategic thinking improves decisions by 50%+ (Anthropic, 2025)
- **Native Tools Only**: Uses Claude Code's actual capabilities, not imaginary APIs

**Key Principles:**

- **Simplicity > Complexity**: Start simple, add only when proven necessary
- **Context Awareness**: Commands adapt to YOUR project, not vice versa
- **Safety First**: Git checkpoints before any destructive operation
- **Pattern Recognition**: Learn from your codebase, not assumptions

### Technical Architecture

**Native Tool Integration:**
All commands leverage Claude Code CLI's native capabilities:

- Grep tool for efficient pattern matching
- Glob tool for file discovery
- Read tool for content analysis
- TodoWrite for progress tracking
- Sub-agents for specialized analysis

**Safety-First Design:**

```bash
git add -A
git commit -m "Pre-operation checkpoint" || echo "No changes to commit"
```

**Conversational Interface:**
Commands use first-person collaborative language ("I'll analyze your code...") rather than imperative commands, creating a natural partnership interaction that improves model performance.

**Framework Agnostic:**
Intelligent detection without hardcoded assumptions enables universal compatibility across technology stacks.

### User Commands Indicator

Custom commands appear with a `(user)` tag in Claude Code CLI to distinguish them from built-in commands. This is normal and indicates your commands are properly installed.

```
/commit
    Smart Git Commit (user)    ← Your custom command
/help
    Show help                  ← Built-in command
```

## Performance Metrics

| Task | Manual Time | With CCPlugins | Time Saved |
|------|-------------|----------------|------------|
| Security analysis | 45-60 min | 3-5 min | ~50 min |
| Architecture review | 30-45 min | 5-8 min | ~35 min |
| Feature scaffolding | 25-40 min | 2-3 min | ~30 min |
| Git commits | 5-10 min | 30 sec | ~9 min |
| Code cleanup | 20-30 min | 1 min | ~25 min |
| Import fixing | 15-25 min | 1-2 min | ~20 min |
| Code review | 20-30 min | 2-4 min | ~20 min |
| Issue prediction | 60+ min | 5-10 min | ~50 min |
| TODO resolution | 30-45 min | 3-5 min | ~35 min |
| Code adaptation | 40-60 min | 3-5 min | ~45 min |

**Total: 4-5 hours saved per week with professional-grade analysis**

## Requirements

- Claude Code CLI
- Python 3.6+ (for installer)
- Git (for version control commands)

## Advanced Usage

### Creating Custom Commands

Create your own commands by adding markdown files to `~/.claude/commands/`:

```markdown
# My Custom Command

I'll help you with your specific workflow.

[Your instructions here]
```

### Using Arguments

Commands support arguments via `$ARGUMENTS`:

```bash
/mycommand some-file.js
# $ARGUMENTS will contain "some-file.js"
```

### CI/CD Integration

Use commands in automated workflows:

```bash
# Quality pipeline
claude "/security-scan" && claude "/review" && claude "/test"

# Pre-commit validation  
claude "/format" && claude "/commit"

# Feature development
claude "/scaffold api-users" && claude "/test"

# Complete workflow
claude "/security-scan" && claude "/create-todos" && claude "/todos-to-issues"

# TODO resolution workflow
claude "/find-todos" && claude "/fix-todos" && claude "/test"
```

### Manual Workflow Integration

Perfect for development routines:

```bash
# Morning routine
claude "/session-start feature-authentication"
claude "/security-scan"

# During development
claude "/scaffold user-management"
claude "/session-update Added OAuth integration"
claude "/review" 
claude "/format"

# Progress tracking
claude "/session-update Fixed Next.js 15 params Promise issue"
claude "/session-current"

# End of day
claude "/commit"
claude "/session-end"
```

### Session Management Workflow

Complete development session lifecycle:

```bash
# Starting a focused development session
claude "/session-start authentication-refactor"
# Define goals and begin work

# Regular progress updates during development
claude "/session-update Implemented Google OAuth middleware"
claude "/session-update Resolved async cookie handling issue"

# Check session status anytime
claude "/session-current"

# List and review past sessions
claude "/session-list"

# Resume previous work
claude "/session-resume"

# Initialize organized session structure
claude "/sessions-init"

# End with comprehensive summary
claude "/session-end"
```

## Security & Git Instructions

All commands that interact with git include security instructions to prevent AI attribution:

**Commands with git protection:**

- `/commit`, `/scaffold`, `/make-it-pretty`, `/cleanproject`, `/fix-imports`, `/review`, `/security-scan`
- `/contributing`, `/todos-to-issues`, `/predict-issues`, `/find-todos`, `/create-todos`, `/fix-todos`
- `/session-start`, `/session-update`, `/session-end`, `/session-current`, `/session-list`, `/session-resume`, `/sessions-init`

These commands will NEVER:

- Add "Co-authored-by" or AI signatures
- Include "Generated with Claude Code" messages
- Modify git config or credentials
- Add AI attribution to commits/issues

You can modify these instructions in individual command files if needed.

## Session Management Documentation

For comprehensive details about the session management system, see [commands/README-sessions.md](docs/sessions.md). This documentation covers:

- Complete session workflow and best practices
- Advanced command usage and examples
- Session file structure and organization
- Integration with Claude Code's memory system
- Tips for team collaboration and knowledge transfer

## Contributing

We welcome contributions that help developers save time. See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## Acknowledgements

This project builds upon and extends excellent work from the open-source community. We gratefully acknowledge the following projects that have contributed foundational concepts and implementations:

- **[CCPlugins](https://github.com/brennercruvinel/CCPlugins)** - Professional command framework and core development workflow commands
- **[claude-sessions](https://github.com/iannuttall/claude-sessions)** - Session management system architecture and documentation patterns

This repository enhances these foundations with additional commands, refined workflows, and integrated session management capabilities tailored for professional development environments.

## License

MIT License - see [LICENSE](LICENSE) file for details.
