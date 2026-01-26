---
name: mcp-setup
description: Set up and configure MCP servers
disable-model-invocation: true
---

# MCP Server Setup

I'll help you set up and configure Model Context Protocol (MCP) servers for enhanced Claude Code capabilities.

Arguments: `$ARGUMENTS` - server name, provider, or configuration type

## MCP Overview

**Model Context Protocol (MCP)** enables Claude Code to connect to external tools and data sources:
- Database access
- API integrations
- File system operations
- Custom tools and services

**Token Optimization:**
- Quick configuration checks (200 tokens)
- Minimal file reading (500 tokens)
- Expected: 700-1,000 tokens

## Phase 1: MCP Configuration Detection

First, let me check your existing MCP setup:

```bash
#!/bin/bash
# Detect existing MCP configuration

detect_mcp_config() {
    echo "=== MCP Configuration Detection ==="
    echo ""

    # Check Claude Code config directory
    CLAUDE_CONFIG="$HOME/.claude"

    if [ ! -d "$CLAUDE_CONFIG" ]; then
        echo "⚠️  Claude Code config directory not found"
        echo "Creating: $CLAUDE_CONFIG"
        mkdir -p "$CLAUDE_CONFIG"
    else
        echo "✓ Claude Code config directory exists"
    fi

    # Check for MCP config file
    MCP_CONFIG="$CLAUDE_CONFIG/config.json"

    if [ -f "$MCP_CONFIG" ]; then
        echo "✓ MCP config file exists: $MCP_CONFIG"
        echo ""
        echo "Configured servers:"
        cat "$MCP_CONFIG" | grep -o '"[^"]*":' | grep -v "mcpServers" | sed 's/"//g' | sed 's/://g' | sed 's/^/  /'
    else
        echo "⚠️  No MCP config file found"
        echo "Will create: $MCP_CONFIG"
    fi

    echo ""
}

detect_mcp_config
```

## Phase 2: Available MCP Servers

Here are the official and community MCP servers:

### Official MCP Servers

1. **Filesystem** - Local file operations
2. **GitHub** - GitHub repository access
3. **PostgreSQL** - Database access
4. **SQLite** - Local database access
5. **Brave Search** - Web search
6. **Fetch** - HTTP requests
7. **Memory** - Persistent memory
8. **Puppeteer** - Browser automation

### Community MCP Servers

9. **MongoDB** - NoSQL database access
10. **Redis** - Cache and pub/sub
11. **Slack** - Slack workspace integration
12. **Linear** - Issue tracking
13. **Google Drive** - Cloud storage
14. **AWS S3** - Object storage

## Phase 3: Server Configuration Templates

I'll create configurations for commonly used servers:

### GitHub Server

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-github"
      ],
      "env": {
        "GITHUB_TOKEN": "your-github-token-here"
      }
    }
  }
}
```

**Setup Script:**

```bash
#!/bin/bash
# Set up GitHub MCP server

setup_github_mcp() {
    echo "=== Setting up GitHub MCP Server ==="
    echo ""

    # Check for GitHub token
    if [ -z "$GITHUB_TOKEN" ]; then
        echo "Please provide your GitHub personal access token:"
        read -s GITHUB_TOKEN
        echo ""
    fi

    # Update MCP config
    cat > "$HOME/.claude/config.json" << EOF
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "$GITHUB_TOKEN"
      }
    }
  }
}
EOF

    echo "✓ GitHub MCP server configured"
    echo ""
    echo "Available capabilities:"
    echo "  - Read repository contents"
    echo "  - Create/update files"
    echo "  - Create issues and PRs"
    echo "  - Search code"
}

setup_github_mcp
```

### PostgreSQL Server

```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-postgres"
      ],
      "env": {
        "POSTGRES_CONNECTION_STRING": "postgresql://user:password@localhost:5432/database"
      }
    }
  }
}
```

**Setup Script:**

```bash
#!/bin/bash
# Set up PostgreSQL MCP server

setup_postgres_mcp() {
    echo "=== Setting up PostgreSQL MCP Server ==="
    echo ""

    echo "Enter PostgreSQL connection details:"
    read -p "Host (default: localhost): " PG_HOST
    PG_HOST=${PG_HOST:-localhost}

    read -p "Port (default: 5432): " PG_PORT
    PG_PORT=${PG_PORT:-5432}

    read -p "Database name: " PG_DB
    read -p "Username: " PG_USER
    read -s -p "Password: " PG_PASS
    echo ""

    CONNECTION_STRING="postgresql://${PG_USER}:${PG_PASS}@${PG_HOST}:${PG_PORT}/${PG_DB}"

    # Test connection
    echo "Testing connection..."
    if psql "$CONNECTION_STRING" -c "SELECT 1;" > /dev/null 2>&1; then
        echo "✓ Connection successful"
    else
        echo "❌ Connection failed"
        return 1
    fi

    # Add to MCP config
    update_mcp_config "postgres" "$CONNECTION_STRING"

    echo ""
    echo "✓ PostgreSQL MCP server configured"
    echo ""
    echo "Available capabilities:"
    echo "  - Query database"
    echo "  - Run migrations"
    echo "  - Inspect schema"
}

update_mcp_config() {
    local server_name="$1"
    local connection_string="$2"

    # Read existing config or create new
    if [ -f "$HOME/.claude/config.json" ]; then
        EXISTING_CONFIG=$(cat "$HOME/.claude/config.json")
    else
        EXISTING_CONFIG='{"mcpServers":{}}'
    fi

    # Add new server (simplified - use jq in practice)
    cat > "$HOME/.claude/config.json" << EOF
{
  "mcpServers": {
    "$server_name": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-$server_name"],
      "env": {
        "POSTGRES_CONNECTION_STRING": "$connection_string"
      }
    }
  }
}
EOF
}

setup_postgres_mcp
```

### Filesystem Server

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/path/to/allowed/directory"
      ]
    }
  }
}
```

**Setup Script:**

```bash
#!/bin/bash
# Set up Filesystem MCP server

setup_filesystem_mcp() {
    echo "=== Setting up Filesystem MCP Server ==="
    echo ""

    echo "Enter directories to allow access (comma-separated):"
    read -p "Directories: " ALLOWED_DIRS

    IFS=',' read -ra DIR_ARRAY <<< "$ALLOWED_DIRS"

    # Build args array
    ARGS_JSON=""
    for dir in "${DIR_ARRAY[@]}"; do
        dir=$(echo "$dir" | xargs)  # trim whitespace
        ARGS_JSON="$ARGS_JSON\"$dir\","
    done
    ARGS_JSON=${ARGS_JSON%,}  # remove trailing comma

    cat > "$HOME/.claude/config.json" << EOF
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", $ARGS_JSON]
    }
  }
}
EOF

    echo "✓ Filesystem MCP server configured"
    echo ""
    echo "Allowed directories:"
    for dir in "${DIR_ARRAY[@]}"; do
        echo "  - $(echo "$dir" | xargs)"
    done
}

setup_filesystem_mcp
```

### Brave Search Server

```json
{
  "mcpServers": {
    "brave-search": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-brave-search"
      ],
      "env": {
        "BRAVE_API_KEY": "your-brave-api-key"
      }
    }
  }
}
```

## Phase 4: Multi-Server Configuration

Configure multiple MCP servers together:

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "ghp_xxxxxxxxxxxxx"
      }
    },
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {
        "POSTGRES_CONNECTION_STRING": "postgresql://localhost/mydb"
      }
    },
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/home/user/projects",
        "/home/user/documents"
      ]
    }
  }
}
```

**Complete Setup Script:**

```bash
#!/bin/bash
# Interactive MCP server setup

interactive_mcp_setup() {
    echo "=== Interactive MCP Server Setup ==="
    echo ""
    echo "Select servers to configure:"
    echo "1. GitHub"
    echo "2. PostgreSQL"
    echo "3. SQLite"
    echo "4. Filesystem"
    echo "5. Brave Search"
    echo "6. Memory"
    echo "7. All of the above"
    echo ""

    read -p "Enter numbers (comma-separated): " CHOICES

    CONFIG='{"mcpServers":{}}'

    IFS=',' read -ra CHOICE_ARRAY <<< "$CHOICES"

    for choice in "${CHOICE_ARRAY[@]}"; do
        case $(echo "$choice" | xargs) in
            1) setup_github_mcp ;;
            2) setup_postgres_mcp ;;
            3) setup_sqlite_mcp ;;
            4) setup_filesystem_mcp ;;
            5) setup_brave_search_mcp ;;
            6) setup_memory_mcp ;;
            7)
                setup_github_mcp
                setup_postgres_mcp
                setup_filesystem_mcp
                ;;
        esac
    done

    echo ""
    echo "✓ MCP server setup complete!"
    echo ""
    echo "To use these servers, restart Claude Code."
}

interactive_mcp_setup
```

## Phase 5: Custom MCP Server

Create a custom MCP server:

```typescript
// custom-mcp-server.ts
import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
} from '@modelcontextprotocol/sdk/types.js';

const server = new Server(
  {
    name: 'custom-server',
    version: '1.0.0',
  },
  {
    capabilities: {
      tools: {},
    },
  }
);

// Define available tools
server.setRequestHandler(ListToolsRequestSchema, async () => {
  return {
    tools: [
      {
        name: 'custom_tool',
        description: 'A custom tool for specific operations',
        inputSchema: {
          type: 'object',
          properties: {
            input: {
              type: 'string',
              description: 'Input for the tool',
            },
          },
          required: ['input'],
        },
      },
    ],
  };
});

// Handle tool calls
server.setRequestHandler(CallToolRequestSchema, async (request) => {
  if (request.params.name === 'custom_tool') {
    const { input } = request.params.arguments as { input: string };

    // Your custom logic here
    const result = `Processed: ${input}`;

    return {
      content: [
        {
          type: 'text',
          text: result,
        },
      ],
    };
  }

  throw new Error(`Unknown tool: ${request.params.name}`);
});

// Start server
async function main() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
}

main().catch(console.error);
```

**Configuration:**

```json
{
  "mcpServers": {
    "custom": {
      "command": "node",
      "args": ["path/to/custom-mcp-server.js"]
    }
  }
}
```

## Phase 6: Testing MCP Setup

Verify MCP servers are working:

```bash
#!/bin/bash
# Test MCP server configuration

test_mcp_servers() {
    echo "=== Testing MCP Server Configuration ==="
    echo ""

    MCP_CONFIG="$HOME/.claude/config.json"

    if [ ! -f "$MCP_CONFIG" ]; then
        echo "❌ No MCP configuration found"
        exit 1
    fi

    echo "Configured servers:"
    cat "$MCP_CONFIG" | grep -o '"[^"]*":' | grep -v "mcpServers" | sed 's/"//g' | sed 's/://g'

    echo ""
    echo "To test servers, restart Claude Code and check:"
    echo "  claude --list-tools"
}

test_mcp_servers
```

## Practical Examples

**Setup Specific Server:**
```bash
/mcp-setup github
/mcp-setup postgres
/mcp-setup filesystem
```

**Interactive Setup:**
```bash
/mcp-setup              # Interactive server selection
/mcp-setup --all        # Configure all common servers
```

**Custom Server:**
```bash
/mcp-setup custom path/to/server.js
```

## Security Best Practices

**Credential Management:**
- ✅ Use environment variables for secrets
- ✅ Never commit tokens to git
- ✅ Use read-only tokens when possible
- ✅ Rotate tokens regularly

**Access Control:**
- ✅ Limit filesystem access to necessary directories
- ✅ Use database users with minimal permissions
- ✅ Scope GitHub tokens appropriately
- ✅ Review MCP server capabilities

## Troubleshooting

**Server Not Working:**
```bash
# Check server installation
npx @modelcontextprotocol/server-github --version

# Verify config syntax
cat ~/.claude/config.json | python -m json.tool

# Check Claude Code logs
tail -f ~/.claude/logs/claude.log
```

**Connection Issues:**
```bash
# Test database connection
psql "$POSTGRES_CONNECTION_STRING" -c "SELECT 1;"

# Test GitHub token
curl -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/user
```

## What I'll Actually Do

1. **Detect config** - Check existing MCP setup
2. **Gather requirements** - Ask for necessary credentials
3. **Generate config** - Create proper JSON configuration
4. **Test connection** - Verify server accessibility
5. **Document setup** - Explain capabilities

**Important:** I will NEVER:
- Store credentials in plain text in git
- Configure servers without permission
- Skip security validation
- Add AI attribution

All MCP servers will be properly configured, secured, and documented.

**Credits:** Based on Model Context Protocol specification and official MCP server implementations.
