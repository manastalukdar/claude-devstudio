<!--
 Copyright (c) 2025 Manas Talukdar

 This software is released under the MIT License.
 https://opensource.org/licenses/MIT
-->

# AGENTS.md - AI Agent Guidelines for Claude DevStudio

## Purpose

This document provides guidelines for AI assistants (particularly Claude Code) when working with the Claude DevStudio project. It ensures consistent, safe, and effective collaboration between human developers and AI agents.

## Project Identity

**Claude DevStudio** is a professional development environment that extends Claude Code CLI with 29 intelligent commands for automated workflows, code quality analysis, and session management.

**Core Philosophy**: Time-saving automation with safety-first design and professional-grade code quality.

## Critical Safety Rules

### 1. Git Credentials and Commits

**ABSOLUTE REQUIREMENT**: Never use Claude or AI credentials for git commits.

- ✅ **CORRECT**: All commits must use the developer's configured git credentials
- ❌ **NEVER**: Use "Claude Sonnet 4.5 <noreply@anthropic.com>" or any AI identity
- ❌ **NEVER**: Include "Co-Authored-By: Claude" or similar AI attribution in commits
- ❌ **NEVER**: Modify git config to set AI credentials

**Rationale**: Commits represent legal authorship and accountability. AI assistants are tools, not authors.

### 2. File Operations

- Always read files before editing or writing
- Use Edit tool for existing files, Write tool only for genuinely new files
- Preserve existing code style, formatting, and conventions
- Never create unnecessary documentation files unless explicitly requested

### 3. Command Development

- All commands are Markdown files in the `commands/` directory
- Commands must be self-contained with clear instructions
- Test commands thoroughly before marking as complete
- Follow the existing command template structure

## Development Workflows

### Working with Commands

1. **Reading Commands**: Use `Read` tool to examine command files in `commands/`
2. **Creating Commands**: Follow the template structure from existing commands
3. **Testing Commands**: Verify command syntax and behavior before committing
4. **Documentation**: Update README.md and CLAUDE.md when adding/modifying commands

### Installation Scripts

- `install.py` and `install.sh` must be kept in sync
- `uninstall.py` and `uninstall.sh` must be kept in sync
- Test installation on multiple platforms when possible
- Ensure all 29 commands are included in installation manifests

### Session Management

Commands in the `session-*` family require special attention:

- Must integrate with `.claude/sessions/` directory structure
- Should preserve full context and history
- Must handle edge cases (no active session, corrupt session files, etc.)
- Follow the patterns established in `commands/README-sessions.md`

## Code Quality Standards

### Style and Formatting

- **Python**: Follow PEP 8, use type hints where beneficial
- **Shell Scripts**: Use shellcheck-compliant syntax
- **Markdown**: Use consistent formatting, proper headers, code blocks
- **Commands**: Clear structure with purpose, usage, examples, and edge cases

### Documentation

- Keep README.md as the primary user-facing documentation
- Use CLAUDE.md for project context and memory
- Use AGENTS.md (this file) for AI interaction guidelines
- Update CONTRIBUTING.md for contributor workflows

### Testing

- Manually test installation scripts on supported platforms
- Verify command behavior with Claude Code CLI
- Test edge cases and error handling
- Ensure backwards compatibility when modifying existing commands

## Command Development Guidelines

### Command Structure

Each command file should include:

```markdown
# Command Name

## Purpose
Clear one-line description

## Usage
How to invoke the command

## Behavior
Step-by-step process

## Examples
Real-world use cases

## Edge Cases
How to handle errors and unusual situations

## Safety Considerations
Any risks or precautions
```

### Command Categories

1. **Development Workflow**: Automate repetitive tasks
2. **Code Quality & Security**: Analysis and improvement
3. **Advanced Analysis**: Deep understanding and explanation
4. **Session & Project Management**: Context preservation and collaboration

### Command Naming

- Use kebab-case: `session-start`, `fix-todos`, `security-scan`
- Be descriptive but concise
- Follow established patterns in the command family
- Avoid abbreviations unless universally understood

## Integration Points

### Claude Code CLI

- Commands are invoked via `/command-name` syntax
- Commands receive context from Claude Code conversation history
- Commands can use Claude Code's built-in tools (Read, Write, Edit, Bash, etc.)
- Commands should be autonomous and minimize user interaction

### Git Integration

- Commands may read git status and history
- Commands should never commit without explicit user request
- Use git checkpoints for safety before destructive operations
- Respect user's git configuration and credentials

### File System

- Primary workspace: Project root directory
- Session data: `.claude/sessions/` directory
- Command definitions: `commands/` directory
- Installation: `~/.claude/commands/` (user-specific)

## Common Patterns

### Error Handling

```markdown
If [error condition]:
1. Inform user of the issue
2. Provide clear error message
3. Suggest corrective action
4. Exit gracefully without making changes
```

### User Confirmation

For destructive operations:
1. Explain what will happen
2. Ask for explicit confirmation
3. Provide option to preview changes
4. Allow user to cancel

### Progress Feedback

For long-running operations:
1. Show clear progress indicators
2. Provide intermediate status updates
3. Estimate completion when possible
4. Allow interruption/cancellation

## Anti-Patterns to Avoid

### Never Do These

- ❌ Use AI credentials for git operations
- ❌ Commit code without explicit user request
- ❌ Make destructive changes without checkpoints
- ❌ Skip reading files before editing them
- ❌ Create unnecessary documentation files
- ❌ Add AI attribution to any generated content
- ❌ Override user's git configuration
- ❌ Modify files outside the project directory without permission
- ❌ Execute commands that could cause data loss without confirmation
- ❌ Hardcode paths or assume specific directory structures

### Discouraged Practices

- Creating new files when editing existing ones would suffice
- Over-engineering simple solutions
- Adding unnecessary abstractions
- Verbose explanations when concise ones work
- Using emoji in commits or generated code
- Adding comments to self-explanatory code

## Collaboration with Developers

### Communication Style

- **Concise**: Developers prefer brevity over verbosity
- **Technical**: Use precise technical terminology
- **Action-Oriented**: Focus on what needs to be done
- **Evidence-Based**: Reference specific files and line numbers

### Asking Questions

When clarification is needed:
1. Ask specific, focused questions
2. Provide context for why the information is needed
3. Suggest reasonable defaults when applicable
4. Don't ask questions with obvious answers

### Providing Options

When multiple approaches are valid:
1. Present 2-3 viable options
2. Explain trade-offs clearly
3. Recommend the best option with rationale
4. Let the developer make the final decision

## Project Maintenance

### Regular Tasks

- Update command descriptions when behavior changes
- Sync installation scripts with new commands
- Keep documentation current with codebase
- Test commands with new Claude Code CLI versions
- Review and close obsolete issues/TODOs

### Version Control

- Use conventional commit messages
- Keep commits focused and atomic
- Write clear commit messages explaining "why"
- Reference issues/PRs when applicable

### Release Process

1. Update version numbers consistently
2. Update CHANGELOG.md with changes
3. Test installation on all supported platforms
4. Verify all commands work with current Claude Code version
5. Tag releases with semantic versioning

## Security Considerations

### Code Scanning

- Use `/security-scan` command for vulnerability detection
- Never commit sensitive data (API keys, passwords, credentials)
- Be cautious with file operations outside project directory
- Validate user input in command implementations

### Privacy

- Session data may contain sensitive project information
- Never share session data without explicit permission
- Respect `.gitignore` patterns
- Don't expose internal implementation details unnecessarily

## Extension and Customization

### Adding New Commands

1. Create command file in `commands/` directory
2. Follow the established template structure
3. Test thoroughly with various scenarios
4. Update installation scripts to include new command
5. Document in README.md and CLAUDE.md
6. Update this file if new patterns are introduced

### Modifying Existing Commands

1. Read and understand current implementation
2. Identify specific changes needed
3. Maintain backwards compatibility when possible
4. Test all documented use cases
5. Update documentation if behavior changes
6. Consider impact on dependent commands

### Framework-Specific Extensions

When adding framework-specific features:
- Keep core commands framework-agnostic
- Create separate commands for framework-specific functionality
- Auto-detect framework when possible
- Gracefully handle absence of framework
- Document framework requirements clearly

## Success Metrics

A successful interaction with Claude DevStudio:

1. **Time Saved**: Automates repetitive tasks effectively
2. **Quality Maintained**: Code quality matches or exceeds manual work
3. **Context Preserved**: Session continuity across conversations
4. **Safety Ensured**: No accidental data loss or corruption
5. **Standards Followed**: All guidelines in this document are followed

## Resources

- **Main Documentation**: README.md
- **Project Context**: CLAUDE.md
- **Contribution Guidelines**: CONTRIBUTING.md
- **Session System**: commands/README-sessions.md
- **License**: LICENSE (MIT)

## Revision History

- **2025-01-25**: Initial creation with comprehensive AI agent guidelines
- Added critical safety rules for git credentials
- Documented command development patterns
- Established code quality standards
- Defined anti-patterns and best practices

---

**Remember**: Claude DevStudio is a tool to enhance developer productivity. Always prioritize the developer's needs, maintain code quality, and follow safety-first principles.
