<!--
 Copyright (c) 2025 Manas Talukdar
 
 This software is released under the MIT License.
 https://opensource.org/licenses/MIT
-->

# Claude DevStudio - Professional Claude Code Skills

## Project Overview

Claude DevStudio is a comprehensive development environment featuring 46 professional skills for Claude Code CLI that automate repetitive development tasks and provide enterprise-grade workflows. This intelligent development studio extends Claude Code's capabilities with intelligent skills that save 8-10 hours per week through:

- **Automated Development Workflows**: Smart commits, TDD enforcement, testing, formatting, and scaffolding
- **Code Quality & Security**: Multi-agent analysis, vulnerability scanning, secrets detection, and issue prediction
- **CI/CD & DevOps**: Pipeline setup, deployment validation, and automation workflows
- **API Development & Testing**: Auto-generated API tests, contract validation, and endpoint testing
- **Advanced Session Management**: Professional development session tracking with full context preservation
- **Database & Schema Management**: Migration generation, type generation, and schema validation
- **Intelligent Analysis**: Architecture review, systematic debugging, code explanation, and contribution readiness
- **MCP Integration**: Model Context Protocol server setup and external tool connections

## Key Features

### Core Skill Categories

1. **Development Workflow Skills** (10 skills)
   - `/cleanproject` - Remove debug artifacts safely
   - `/commit` - Smart conventional commits
   - `/format` - Auto-detect and apply formatting
   - `/scaffold` - Generate complete features
   - `/test` - Intelligent test execution
   - `/implement` - Import and adapt code with validation
   - `/refactor` - Structured code restructuring
   - `/undo` - Safe rollback with git checkpoints
   - `/tdd-red-green` - Enforce RED→GREEN→REFACTOR TDD workflow
   - `/e2e-generate` - Generate E2E tests with Playwright

2. **Code Quality & Security Skills** (10 skills)
   - `/review` - Multi-agent code analysis
   - `/security-scan` - Vulnerability detection and remediation
   - `/predict-issues` - Proactive problem identification
   - `/remove-comments` - Clean obvious comments
   - `/fix-imports` - Repair broken imports
   - `/find-todos` - Locate development tasks
   - `/create-todos` - Add contextual TODO comments
   - `/fix-todos` - Intelligent TODO resolution
   - `/dependency-audit` - Comprehensive dependency security and license audit
   - `/secrets-scan` - Scan for exposed secrets and credentials

3. **CI/CD & DevOps Skills** (2 skills)
   - `/ci-setup` - Configure CI/CD pipelines (GitHub Actions, GitLab CI, CircleCI)
   - `/deploy-validate` - Pre-deployment validation with environment and security checks

4. **API Development & Testing Skills** (2 skills)
   - `/api-test-generate` - Auto-generate comprehensive API tests for REST/GraphQL
   - `/api-validate` - API contract validation and breaking change detection

5. **Database Management Skills** (1 skill)
   - `/migration-generate` - Generate database migrations from schema changes

6. **Code Generation & Type Safety Skills** (2 skills)
   - `/types-generate` - Generate TypeScript types from schemas/APIs
   - `/changelog-auto` - Auto-generate changelogs from commit history

7. **Advanced Analysis & Debugging Skills** (5 skills)
   - `/understand` - Project architecture analysis
   - `/explain-like-senior` - Senior-level code explanations
   - `/contributing` - Contribution readiness assessment
   - `/make-it-pretty` - Improve code readability
   - `/debug-systematic` - Systematic debugging workflow with hypothesis testing

8. **Collaboration & Planning Skills** (2 skills)
   - `/brainstorm` - Interactive design refinement with structured exploration
   - `/write-plan` - Create detailed implementation plans with task breakdown

9. **MCP & Tool Integration Skills** (2 skills)
   - `/mcp-setup` - Set up and configure MCP servers
   - `/tool-connect` - Connect to external tools via MCP (GitHub, DB, APIs)

10. **Session & Project Management Skills** (10 skills)
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

**Q1 2026 - Tier 1 Skills Expansion (16 new skills)**
- TDD workflow enforcement with RED→GREEN→REFACTOR cycle
- E2E test generation with Playwright
- CI/CD pipeline configuration (GitHub Actions, GitLab CI, CircleCI)
- Pre-deployment validation with environment and security checks
- API test generation for REST and GraphQL endpoints
- API contract validation and breaking change detection
- Database migration generation
- TypeScript type generation from schemas
- Automated changelog generation
- Comprehensive dependency security and license auditing
- Secrets scanning for exposed credentials
- Systematic debugging workflow with hypothesis testing
- Interactive design brainstorming
- Detailed implementation planning
- MCP server setup and configuration
- External tool integration via Model Context Protocol

**Previous Releases**
- Complete session management system with 8 session skills
- Integration with Claude Code's native memory system
- Comprehensive session documentation and workflows
- Enhanced README with session management examples
- Updated installation scripts to include all new skills
- Updated terminology from "slash commands" to "Claude Skills" per Claude Code deprecation

### File Structure

```plaintext
claude-devstudio/
├── skills/                # Claude Skills (46 directories)
│   ├── commit/
│   │   └── SKILL.md      # Smart Git Commit skill
│   ├── session-start/
│   │   └── SKILL.md      # Session management skill
│   ├── tdd-red-green/
│   │   └── SKILL.md      # TDD workflow enforcement
│   ├── ci-setup/
│   │   └── SKILL.md      # CI/CD pipeline configuration
│   ├── api-test-generate/
│   │   └── SKILL.md      # API test generation
│   └── [41 other skills]
├── docs/                  # Documentation organized by feature area
│   ├── session-management/
│   │   └── sessions.md   # Session management documentation
│   ├── migration/        # Migration documentation
│   │   ├── MIGRATION-PLAN.md
│   │   ├── MIGRATION_CHECKLIST.md
│   │   └── MIGRATION_SUMMARY.md
│   ├── development/      # Future contributor documentation
│   └── installation/     # Future installation guides
├── scripts/              # Utility scripts
│   └── migrate_skills.py # Legacy migration script
├── install.py/.sh        # Installation scripts (installs to ~/.claude/skills/)
├── uninstall.py/.sh      # Uninstallation scripts
├── SKILLS_EXPANSION_PLAN.md  # Roadmap for 75+ skills (Q1-Q3 2026)
├── TOKEN_OPTIMIZATION_GUIDE.md  # Token efficiency strategies
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
- **obra/superpowers**: TDD methodology, RED/GREEN/REFACTOR workflow, YAGNI/DRY principles
- **Anthropic Skills**: Official Claude Skills examples and best practices
- **Model Context Protocol (MCP)**: Integration standards and server specifications

### Enhanced Capabilities

This fork extends the original with:

- **Comprehensive Skill Library**: Expanded from 30 to 46 professional skills
- **TDD & Testing**: Enforced TDD workflow, E2E test generation, API test automation
- **CI/CD Integration**: Pipeline configuration for GitHub Actions, GitLab CI, CircleCI
- **Security & Quality**: Secrets scanning, dependency auditing, systematic debugging
- **Database & Schema Management**: Migration generation, type generation from schemas
- **MCP Integration**: Model Context Protocol server setup and external tool connections
- **Integrated Session Management**: Professional development session tracking
- **Enhanced Skill Validation**: Comprehensive validation and refinement phases
- **Token Optimization**: Efficient tool usage patterns reducing costs by 60-90%
- **Comprehensive Documentation**: Detailed guides and real-world examples
- **Updated Installation**: Automated scripts for all 46 skills
- **Claude Skills Architecture**: Full migration from legacy slash commands

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

1. **Time Savings**: Reduce repetitive development tasks by 8-10 hours per week through 46 professional skills
2. **Quality Improvement**: Provide professional-grade code analysis, security scanning, and vulnerability detection
3. **DevOps Automation**: Streamline CI/CD setup, deployment validation, and testing workflows
4. **Context Preservation**: Enable seamless development session continuity across conversations
5. **Knowledge Transfer**: Facilitate team collaboration through detailed documentation and session tracking
6. **Universal Compatibility**: Work across all technology stacks, frameworks, and project types
7. **Token Efficiency**: Optimize Claude API costs through intelligent tool usage patterns (60-90% savings)

This project represents a mature, production-ready enhancement to Claude Code CLI that combines practical automation with professional development practices, expanded from 30 to 46 skills with comprehensive CI/CD, API testing, database management, and MCP integration capabilities.
