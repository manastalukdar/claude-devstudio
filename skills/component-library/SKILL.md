---
name: component-library
description: Scaffold component library structure with Storybook and documentation
disable-model-invocation: false
---

# Component Library Scaffolding

I'll help you set up a complete component library with Storybook, testing, documentation, and build configuration.

Arguments: `$ARGUMENTS` - library type or framework (e.g., "react", "vue", "web-components", "storybook")

## Strategic Planning Process

<think>
Component library setup requires careful consideration:

1. **Framework Selection**
   - React, Vue, Angular, Svelte, Web Components?
   - TypeScript or JavaScript?
   - What's the target environment? (browser, Node.js, both)
   - Design system or utility components?

2. **Build & Distribution**
   - How will components be bundled? (Rollup, Vite, esbuild)
   - What formats? (ESM, CJS, UMD)
   - Tree-shaking support needed?
   - CSS bundling strategy
   - Type definitions generation

3. **Documentation & Development**
   - Storybook for component showcase
   - Documentation site (Docusaurus, VitePress, etc.)
   - Live playground/examples
   - Design tokens documentation
   - Accessibility guidelines

4. **Quality Assurance**
   - Unit testing (Jest, Vitest)
   - Visual regression testing (Chromatic)
   - Accessibility testing (axe, jest-axe)
   - Build validation
   - Bundle size tracking

5. **Publishing Strategy**
   - npm package setup
   - Versioning strategy (semantic versioning)
   - Changelog generation
   - CI/CD for releases
</think>

## Phase 1: Project Detection & Setup

**MANDATORY FIRST STEPS:**
1. Detect existing project or create new structure
2. Identify framework and build tool preferences
3. Determine component library scope
4. Check for existing Storybook installation

Let me analyze your project:

```bash
# Detect framework and setup
echo "=== Component Library Setup Analysis ==="

# Check for existing framework
FRAMEWORK=""
if grep -q "\"react\"" package.json 2>/dev/null; then
    FRAMEWORK="React"
    echo "Detected: React"
elif grep -q "\"vue\"" package.json 2>/dev/null; then
    FRAMEWORK="Vue"
    echo "Detected: Vue"
elif grep -q "@angular/core" package.json 2>/dev/null; then
    FRAMEWORK="Angular"
    echo "Detected: Angular"
elif grep -q "\"svelte\"" package.json 2>/dev/null; then
    FRAMEWORK="Svelte"
    echo "Detected: Svelte"
else
    echo "No framework detected - will set up for your choice"
fi

# Check for TypeScript
if [ -f "tsconfig.json" ]; then
    echo "TypeScript: ✓"
else
    echo "TypeScript: ✗"
fi

# Check for Storybook
if [ -d ".storybook" ]; then
    echo "Storybook: Already installed"
    ls -la .storybook/
else
    echo "Storybook: Not installed (will configure)"
fi

# Check for build tools
if [ -f "vite.config.js" ] || [ -f "vite.config.ts" ]; then
    echo "Build tool: Vite"
elif [ -f "rollup.config.js" ]; then
    echo "Build tool: Rollup"
elif [ -f "webpack.config.js" ]; then
    echo "Build tool: Webpack"
else
    echo "Build tool: None detected (will configure)"
fi

# Check for existing components
if [ -d "src/components" ]; then
    echo ""
    echo "Existing components:"
    find src/components -type f -name "*.tsx" -o -name "*.jsx" -o -name "*.vue" 2>/dev/null | head -10
fi
```

## Phase 2: Component Library Structure

I'll create a comprehensive component library structure:

**Directory Structure:**
```
component-library/
├── src/
│   ├── components/          # Component source files
│   │   ├── Button/
│   │   │   ├── Button.tsx
│   │   │   ├── Button.test.tsx
│   │   │   ├── Button.stories.tsx
│   │   │   ├── Button.module.css
│   │   │   └── index.ts
│   │   ├── Input/
│   │   │   ├── Input.tsx
│   │   │   ├── Input.test.tsx
│   │   │   ├── Input.stories.tsx
│   │   │   └── index.ts
│   │   └── index.ts         # Main exports
│   ├── hooks/               # Shared React hooks
│   ├── utils/               # Utility functions
│   ├── types/               # TypeScript types
│   └── index.ts             # Library entry point
├── .storybook/              # Storybook configuration
│   ├── main.ts
│   ├── preview.ts
│   └── theme.ts
├── docs/                    # Documentation
│   ├── getting-started.md
│   ├── components/
│   └── design-tokens.md
├── dist/                    # Build output
│   ├── esm/                 # ES Modules
│   ├── cjs/                 # CommonJS
│   └── types/               # Type definitions
├── package.json
├── tsconfig.json
├── tsconfig.build.json
├── vite.config.ts           # Build configuration
├── vitest.config.ts         # Test configuration
├── .npmignore
└── README.md
```

## Phase 3: Storybook Setup

I'll configure Storybook for component development:

**Install Storybook:**
```bash
# Initialize Storybook (auto-detects framework)
npx storybook@latest init

# Or manual installation for specific framework
npm install --save-dev @storybook/react @storybook/react-vite
npm install --save-dev @storybook/addon-essentials @storybook/addon-a11y
npm install --save-dev @storybook/addon-interactions @storybook/test
```

**Storybook Configuration (.storybook/main.ts):**
```typescript
import type { StorybookConfig } from '@storybook/react-vite';

const config: StorybookConfig = {
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|ts|tsx)'],
  addons: [
    '@storybook/addon-essentials',
    '@storybook/addon-a11y',
    '@storybook/addon-interactions',
    '@storybook/addon-links',
  ],
  framework: {
    name: '@storybook/react-vite',
    options: {},
  },
  docs: {
    autodocs: 'tag',
  },
  staticDirs: ['../public'],
};

export default config;
```

**Storybook Preview (.storybook/preview.ts):**
```typescript
import type { Preview } from '@storybook/react';
import '../src/styles/global.css';

const preview: Preview = {
  parameters: {
    actions: { argTypesRegex: '^on[A-Z].*' },
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/,
      },
    },
    backgrounds: {
      default: 'light',
      values: [
        { name: 'light', value: '#ffffff' },
        { name: 'dark', value: '#1a1a1a' },
      ],
    },
  },
};

export default preview;
```

## Phase 4: Component Templates

I'll create example component templates:

**Button Component (src/components/Button/Button.tsx):**
```typescript
import React from 'react';
import styles from './Button.module.css';

export interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  /**
   * Button variant
   */
  variant?: 'primary' | 'secondary' | 'outline';
  /**
   * Button size
   */
  size?: 'small' | 'medium' | 'large';
  /**
   * Loading state
   */
  loading?: boolean;
  /**
   * Full width button
   */
  fullWidth?: boolean;
}

/**
 * Primary UI component for user interaction
 */
export const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  (
    {
      variant = 'primary',
      size = 'medium',
      loading = false,
      fullWidth = false,
      children,
      disabled,
      className,
      ...props
    },
    ref
  ) => {
    const classes = [
      styles.button,
      styles[variant],
      styles[size],
      fullWidth && styles.fullWidth,
      className,
    ]
      .filter(Boolean)
      .join(' ');

    return (
      <button
        ref={ref}
        className={classes}
        disabled={disabled || loading}
        {...props}
      >
        {loading ? <span className={styles.spinner} /> : children}
      </button>
    );
  }
);

Button.displayName = 'Button';
```

**Button Stories (src/components/Button/Button.stories.tsx):**
```typescript
import type { Meta, StoryObj } from '@storybook/react';
import { Button } from './Button';

const meta = {
  title: 'Components/Button',
  component: Button,
  parameters: {
    layout: 'centered',
  },
  tags: ['autodocs'],
  argTypes: {
    variant: {
      control: 'select',
      options: ['primary', 'secondary', 'outline'],
    },
    size: {
      control: 'select',
      options: ['small', 'medium', 'large'],
    },
  },
} satisfies Meta<typeof Button>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  args: {
    variant: 'primary',
    children: 'Button',
  },
};

export const Secondary: Story = {
  args: {
    variant: 'secondary',
    children: 'Button',
  },
};

export const Large: Story = {
  args: {
    size: 'large',
    children: 'Large Button',
  },
};

export const Loading: Story = {
  args: {
    loading: true,
    children: 'Loading...',
  },
};

export const Disabled: Story = {
  args: {
    disabled: true,
    children: 'Disabled',
  },
};
```

**Button Test (src/components/Button/Button.test.tsx):**
```typescript
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { describe, it, expect, vi } from 'vitest';
import { Button } from './Button';

describe('Button', () => {
  it('renders children correctly', () => {
    render(<Button>Click me</Button>);
    expect(screen.getByText('Click me')).toBeInTheDocument();
  });

  it('applies variant class', () => {
    render(<Button variant="secondary">Button</Button>);
    const button = screen.getByRole('button');
    expect(button).toHaveClass('secondary');
  });

  it('handles click events', async () => {
    const handleClick = vi.fn();
    render(<Button onClick={handleClick}>Click</Button>);

    await userEvent.click(screen.getByRole('button'));
    expect(handleClick).toHaveBeenCalledTimes(1);
  });

  it('disables button when loading', () => {
    render(<Button loading>Loading</Button>);
    expect(screen.getByRole('button')).toBeDisabled();
  });

  it('disables button when disabled prop is true', () => {
    render(<Button disabled>Disabled</Button>);
    expect(screen.getByRole('button')).toBeDisabled();
  });
});
```

## Phase 5: Build Configuration

I'll set up build configuration for library distribution:

**Vite Config (vite.config.ts):**
```typescript
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import { resolve } from 'path';
import dts from 'vite-plugin-dts';

export default defineConfig({
  plugins: [
    react(),
    dts({
      insertTypesEntry: true,
      include: ['src/**/*'],
      exclude: ['**/*.test.tsx', '**/*.stories.tsx'],
    }),
  ],
  build: {
    lib: {
      entry: resolve(__dirname, 'src/index.ts'),
      name: 'ComponentLibrary',
      formats: ['es', 'cjs'],
      fileName: (format) => `index.${format === 'es' ? 'mjs' : 'cjs'}`,
    },
    rollupOptions: {
      external: ['react', 'react-dom'],
      output: {
        globals: {
          react: 'React',
          'react-dom': 'ReactDOM',
        },
        assetFileNames: 'assets/[name][extname]',
        chunkFileNames: 'chunks/[name].[hash].js',
      },
    },
    sourcemap: true,
    emptyOutDir: true,
  },
  css: {
    modules: {
      localsConvention: 'camelCase',
    },
  },
});
```

**Package.json Configuration:**
```json
{
  "name": "@your-org/component-library",
  "version": "1.0.0",
  "description": "A React component library",
  "main": "./dist/index.cjs",
  "module": "./dist/index.mjs",
  "types": "./dist/index.d.ts",
  "exports": {
    ".": {
      "import": "./dist/index.mjs",
      "require": "./dist/index.cjs",
      "types": "./dist/index.d.ts"
    },
    "./styles": "./dist/style.css"
  },
  "files": [
    "dist"
  ],
  "scripts": {
    "dev": "vite",
    "build": "tsc && vite build",
    "test": "vitest",
    "test:ui": "vitest --ui",
    "lint": "eslint src --ext ts,tsx",
    "storybook": "storybook dev -p 6006",
    "build-storybook": "storybook build",
    "prepublishOnly": "npm run build"
  },
  "peerDependencies": {
    "react": "^18.0.0",
    "react-dom": "^18.0.0"
  },
  "devDependencies": {
    "@storybook/react": "^7.6.0",
    "@storybook/react-vite": "^7.6.0",
    "@testing-library/react": "^14.0.0",
    "@testing-library/user-event": "^14.0.0",
    "@types/react": "^18.2.0",
    "@vitejs/plugin-react": "^4.2.0",
    "typescript": "^5.3.0",
    "vite": "^5.0.0",
    "vite-plugin-dts": "^3.7.0",
    "vitest": "^1.0.0"
  }
}
```

**TypeScript Configuration (tsconfig.json):**
```json
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,

    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",

    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,

    "declaration": true,
    "declarationMap": true,
    "sourceMap": true,

    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"]
    }
  },
  "include": ["src"],
  "exclude": ["node_modules", "dist", "**/*.stories.tsx", "**/*.test.tsx"]
}
```

## Phase 6: Documentation Setup

I'll create comprehensive documentation:

**README.md:**
```markdown
# Component Library

A modern React component library built with TypeScript, Storybook, and Vite.

## Installation

```bash
npm install @your-org/component-library
# or
yarn add @your-org/component-library
```

## Usage

```tsx
import { Button } from '@your-org/component-library';
import '@your-org/component-library/styles';

function App() {
  return (
    <Button variant="primary" size="large">
      Click me
    </Button>
  );
}
```

## Components

- **Button** - Versatile button component with variants and sizes
- **Input** - Form input with validation support
- **Card** - Container component for content
- [See full component list in Storybook]

## Development

```bash
# Install dependencies
npm install

# Start Storybook
npm run storybook

# Run tests
npm test

# Build library
npm run build
```

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines.

## License

MIT
```

**Getting Started Guide (docs/getting-started.md):**
```markdown
# Getting Started

## Installation

Install the component library in your React project:

```bash
npm install @your-org/component-library
```

## Basic Setup

Import components and styles:

```tsx
import { Button, Input, Card } from '@your-org/component-library';
import '@your-org/component-library/styles';
```

## TypeScript Support

The library is written in TypeScript and includes type definitions:

```tsx
import type { ButtonProps } from '@your-org/component-library';

const MyButton: React.FC<{ onClick: () => void }> = ({ onClick }) => {
  return <Button variant="primary" onClick={onClick}>Click</Button>;
};
```

## Theming

Customize component styles with CSS variables:

```css
:root {
  --primary-color: #007bff;
  --secondary-color: #6c757d;
  --border-radius: 4px;
}
```

## Next Steps

- Browse components in [Storybook](http://localhost:6006)
- Read component documentation
- Check out examples
```

## Token Optimization Strategy

**Efficient Scaffolding:**
- Generate only requested framework setup
- Create essential files first
- Provide templates that can be expanded
- Reference documentation instead of full explanations
- Focus on high-value components

**Targeted Setup:**
- Detect existing setup early
- Skip already configured tools
- Provide incremental additions
- Focus on user's specific needs

## Integration Points

**Synergistic Skills:**
- `/scaffold` - General feature scaffolding
- `/types-generate` - Generate TypeScript types
- `/docs` - Documentation management
- `/test` - Run component tests
- `/format` - Format component code

Suggests `/scaffold` when:
- Need to add new components quickly
- Following existing patterns
- Creating feature-specific components

Suggests `/docs` when:
- Need to enhance documentation
- Create API documentation
- Build documentation site

## Framework Support

**React:**
- Component structure with TypeScript
- Storybook with React
- Jest/Vitest testing
- CSS Modules or Styled Components

**Vue:**
- Single File Components
- Storybook for Vue
- Vue Test Utils
- Scoped styles

**Web Components:**
- Custom Elements API
- Lit or Stencil
- Framework-agnostic approach
- Shadow DOM styling

**Svelte:**
- Svelte components
- Storybook for Svelte
- Svelte Testing Library
- Component-scoped styles

## Expected Outputs

**Files Created:**
- Complete directory structure
- Example components with stories
- Storybook configuration
- Build configuration (Vite/Rollup)
- Test setup and examples
- Documentation files
- Package.json with scripts
- TypeScript configurations
- README and guides

**Ready to Use:**
- `npm run storybook` - Start component development
- `npm test` - Run tests
- `npm run build` - Build library for distribution
- `npm publish` - Publish to npm (after setup)

## Safety Mechanisms

**Protection Measures:**
- Create git checkpoint before scaffolding
- Preview structure before creation
- Non-destructive for existing files
- Validate package names
- Check for conflicts

**Validation Steps:**
1. Verify framework compatibility
2. Check TypeScript configuration
3. Validate build outputs
4. Test Storybook startup
5. Verify tests run

## Common Scenarios

**Scenario 1: New Component Library**
- Create complete structure from scratch
- Set up all tooling
- Create example components
- Configure publishing

**Scenario 2: Add to Existing Project**
- Integrate Storybook into existing codebase
- Add missing configurations
- Create component templates
- Set up testing

**Scenario 3: Migrate to Component Library**
- Extract components from application
- Set up build for distribution
- Add Storybook stories
- Configure exports

## Important Notes

**I will NEVER:**
- Overwrite existing components without confirmation
- Add AI attribution to component files
- Break existing build configuration
- Remove existing Storybook setup
- Modify package.json without validation

**Best Practices:**
- Follow framework conventions
- Use semantic versioning
- Document all components
- Include accessibility features
- Provide usage examples

## Credits

**Inspired by:**
- [Shadcn/ui](https://ui.shadcn.com/) - Component library patterns
- [Radix UI](https://www.radix-ui.com/) - Accessible components
- [Chakra UI](https://chakra-ui.com/) - Design system approach
- [Material-UI](https://mui.com/) - Component library architecture
- [Storybook Best Practices](https://storybook.js.org/docs/react/writing-stories/introduction)

This skill helps you quickly scaffold a production-ready component library with all essential tooling configured.
