<!--
 Copyright (c) 2025 Manas Talukdar
 
 This software is released under the MIT License.
 https://opensource.org/licenses/MIT
-->

# Claude DevStudio - Professional Claude Code Skills

## Project Overview

Claude DevStudio is a comprehensive development environment featuring 29 professional skills for Claude Code CLI that automate repetitive development tasks and provide enterprise-grade workflows. This intelligent development studio extends Claude Code's capabilities with intelligent skills that save 4-5 hours per week through:

- **Automated Development Workflows**: Smart commits, testing, formatting, and scaffolding
- **Code Quality & Security**: Multi-agent analysis, vulnerability scanning, and issue prediction
- **Advanced Session Management**: Professional development session tracking with full context preservation
- **Intelligent Analysis**: Architecture review, code explanation, and contribution readiness

## Key Features

### Core Skill Categories

1. **Development Workflow Skills** (8 skills)
   - `/cleanproject` - Remove debug artifacts safely
   - `/commit` - Smart conventional commits
   - `/format` - Auto-detect and apply formatting
   - `/scaffold` - Generate complete features
   - `/test` - Intelligent test execution
   - `/implement` - Import and adapt code with validation
   - `/refactor` - Structured code restructuring
   - `/undo` - Safe rollback with git checkpoints

2. **Code Quality & Security Skills** (8 skills)
   - `/review` - Multi-agent code analysis
   - `/security-scan` - Vulnerability detection and remediation
   - `/predict-issues` - Proactive problem identification
   - `/remove-comments` - Clean obvious comments
   - `/fix-imports` - Repair broken imports
   - `/find-todos` - Locate development tasks
   - `/create-todos` - Add contextual TODO comments
   - `/fix-todos` - Intelligent TODO resolution

3. **Advanced Analysis Skills** (4 skills)
   - `/understand` - Project architecture analysis
   - `/explain-like-senior` - Senior-level code explanations
   - `/contributing` - Contribution readiness assessment
   - `/make-it-pretty` - Improve code readability

4. **Session & Project Management Skills** (10 skills)
   - `/session-start [name]` - Begin documented sessions
   - `/session-update [notes]` - Track progress with timestamps
   - `/session-end` - Generate comprehensive summaries
   - `/session-current` - View active session status
   - `/session-list` - List all past sessions
   - `/session-help` - Session system help
   - `/session-resume` - Resume previous work
   - `/sessions-init` - Initialize session organization
   - `/docs` - Smart documentation management
   - `/todos-to-issues` - Convert TODOs to GitHub issues

### Advanced Session Management System

The project includes a sophisticated session management system that:

- **Integrates with Claude Code Memory**: Uses `.claude/sessions/` directory structure
- **Preserves Development Context**: Full session history with goals, progress, and outcomes
- **Enables Knowledge Transfer**: Detailed documentation for team collaboration
- **Supports Session Continuity**: Resume work across multiple Claude conversations
- **Tracks Git State**: Monitors changes, commits, and repository status

## Technical Architecture

### Safety-First Design

- Automatic git checkpoints before destructive operations
- **NEVER use Claude credentials to commit code**: All commits must use the developer's own git credentials
- No AI attribution in commits or generated content
- Safe rollback capabilities with clear recovery paths

### Performance Optimizations

- Reduced verbosity for senior developer efficiency
- Smart caching of project analysis results
- Parallel execution of independent tasks
- Incremental processing for large codebases

### Framework Agnostic

- Auto-detection of project technology stack
- Universal compatibility across programming languages
- Adapts to existing project conventions and patterns

## Installation

The project provides multiple installation methods:

### Quick Install

```bash
# Mac/Linux
curl -sSL https://raw.githubusercontent.com/manastalukdar/claude-devstudio/main/install.sh | bash

# Windows/Cross-platform
python install.py
```

### Manual Install

```bash
git clone https://github.com/manastalukdar/claude-devstudio.git
cd claude-devstudio
python install.py
```

## Current State

### Recently Added Features

- Complete session management system with 8 session skills
- Integration with Claude Code's native memory system
- Comprehensive session documentation and workflows
- Enhanced README with session management examples
- Updated installation scripts to include all new skills
- Updated terminology from "slash commands" to "Claude Skills" per Claude Code deprecation

### File Structure

```plaintext
claude-devstudio/
├── commands/              # Claude Skill definitions (29 .md files)
│   ├── session-*.md      # Session management skills
│   ├── README-sessions.md # Detailed session documentation
│   └── [other skills]
├── install.py/.sh        # Installation scripts
├── uninstall.py/.sh      # Uninstallation scripts
├── README.md             # Main documentation
├── CLAUDE.md             # This file - project memory
├── AGENTS.md             # AI agent interaction guidelines
├── CONTRIBUTING.md       # Contribution guidelines
└── LICENSE               # MIT license
```

## Development Context

### Original Foundation

Built upon excellent open-source work:

- **CCPlugins by brennercruvinel**: Original command framework and development workflows
- **claude-sessions by iannuttall**: Session management architecture and patterns

### Enhanced Capabilities

This fork extends the original with:

- Integrated session management system
- Enhanced skill validation and refinement
- Professional development tracking
- Comprehensive documentation and examples
- Updated installation and maintenance scripts
- Migration from slash commands to Claude Skills architecture

## Usage Patterns

### Typical Development Session

```bash
# Start focused session
claude "/session-start feature-authentication"

# Development workflow
claude "/security-scan"
claude "/scaffold user-management" 
claude "/session-update Added OAuth integration"
claude "/review"
claude "/test"
claude "/session-update Fixed async handling issues"

# Session management
claude "/session-current"  # Check progress
claude "/commit"          # Safe commit
claude "/session-end"     # Comprehensive summary
```

### Quality Assurance Pipeline

```bash
claude "/security-scan" && claude "/review" && claude "/test"
claude "/create-todos" && claude "/todos-to-issues"
claude "/find-todos" && claude "/fix-todos"
```

## Next Steps

### Potential Enhancements

- Additional specialized skills for specific frameworks
- Enhanced session analytics and reporting
- Integration with additional development tools
- Advanced project architecture analysis
- Team collaboration features

### Maintenance Tasks

- Regular testing with latest Claude Code CLI versions
- Documentation updates based on user feedback
- Skill refinement based on real-world usage patterns
- Performance optimizations for large codebases
- Ensure compatibility with Claude Skills architecture updates

## Project Goals

1. **Time Savings**: Reduce repetitive development tasks by 4-5 hours per week
2. **Quality Improvement**: Provide professional-grade code analysis and security scanning
3. **Context Preservation**: Enable seamless development session continuity
4. **Knowledge Transfer**: Facilitate team collaboration through detailed documentation
5. **Universal Compatibility**: Work across all technology stacks and project types

This project represents a mature, production-ready enhancement to Claude Code CLI that combines practical automation with professional development practices.
