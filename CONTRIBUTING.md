# Contributing to ArtisansUi

Thank you for contributing to the ArtisansUi component library! This guide will help you create high-quality, consistent components.

---

## Table of Contents

1. [Getting Started](#getting-started)
2. [Component Design Principles](#component-design-principles)
3. [Creating a New Component](#creating-a-new-component)
4. [Component Structure](#component-structure)
5. [Testing Requirements](#testing-requirements)
6. [Code Style Guidelines](#code-style-guidelines)
7. [Documentation Standards](#documentation-standards)
8. [Pull Request Process](#pull-request-process)
9. [Review Checklist](#review-checklist)

---

## Getting Started

### Prerequisites

- Ruby 3.2+ installed
- Rails 7.0+ knowledge
- Familiarity with ViewComponent
- Understanding of Tailwind CSS
- Git access to gitgar.com

### Setup

```bash
# Clone repository
git clone git@gitgar.com:templates/view-components.git artisans_ui
cd artisans_ui

# Install dependencies
bundle install

# Run tests to verify setup
bundle exec rspec
```

---

## Component Design Principles

### 1. Single Responsibility

Each component should do one thing well.

**Good:**
```ruby
class ButtonComponent  # Renders a button
class CardComponent    # Renders a card
class ModalComponent   # Renders a modal
```

**Bad:**
```ruby
class ButtonCardModalComponent  # Does too many things
```

### 2. Composable

Components should work together to build complex UIs.

**Good:**
```erb
<%= render CardComponent.new do %>
  <%= render ButtonComponent.new(variant: :primary) do %>
    Action
  <% end %>
<% end %>
```

### 3. Accessible by Default

Every component must meet WCAG 2.1 Level AA standards.

**Required:**
- Proper HTML semantics
- Keyboard navigation
- Focus indicators
- ARIA attributes where needed
- Screen reader compatibility

### 4. Flexible but Opinionated

Provide sensible defaults while allowing customization.

**Good:**
```ruby
def initialize(variant: :primary, size: :medium, **html_options)
  # Defaults provided, but customizable
end
```

### 5. Testable

Components should be easy to test in isolation.

**Every component needs:**
- Unit tests for all variants
- Tests for props/options
- Tests for content rendering
- Edge case tests

### 6. Documented

Clear documentation helps adoption.

**Include:**
- Purpose and use cases
- All available options
- Code examples
- Accessibility notes

---

## Creating a New Component

### Step 1: Plan the Component

**Before coding, answer:**

1. **What problem does this solve?**
   - Is there a clear use case?
   - Will it be reused 3+ times?

2. **What are the variants?**
   - Different visual styles
   - Different sizes
   - Different states

3. **What props are needed?**
   - Required props
   - Optional props with defaults
   - HTML attributes support

4. **Where does it belong?**
   - `ui/` - Pure UI components (buttons, cards, badges)
   - `forms/` - Form-related (inputs, selects, checkboxes)
   - `layouts/` - Layout components (navbar, sidebar, footer)

### Step 2: Create Component Files

```bash
# Generate component
bin/rails generate view_component:component ArtisansUi::Ui::Alert level

# This creates:
# - app/components/artisans_ui/ui/alert_component.rb
# - app/components/artisans_ui/ui/alert_component.html.erb (optional)
```

### Step 3: Implement Component

See [Component Structure](#component-structure) below.

### Step 4: Write Tests

See [Testing Requirements](#testing-requirements) below.

### Step 5: Add Documentation

See [Documentation Standards](#documentation-standards) below.

### Step 6: Test in Real App

```bash
# In your Rails app
bundle config local.artisans_ui /Users/Indie/code/artisans_ui

# Use component in views and test manually
```

### Step 7: Submit for Review

See [Pull Request Process](#pull-request-process) below.

---

## Component Structure

### Basic Template

```ruby
# frozen_string_literal: true

module ArtisansUi
  module Ui
    # Brief description of what this component does
    #
    # @example Basic usage
    #   <%= render AlertComponent.new(level: :info) do %>
    #     Your alert message
    #   <% end %>
    #
    # @example With custom HTML options
    #   <%= render AlertComponent.new(
    #     level: :warning,
    #     dismissible: true,
    #     id: "my-alert"
    #   ) do %>
    #     Warning message
    #   <% end %>
    class AlertComponent < ApplicationViewComponent
      # Define valid options as constants
      LEVELS = %w[info success warning error].freeze

      # Use keyword arguments with defaults
      def initialize(level: :info, dismissible: false, **html_options)
        # Validate input
        raise ArgumentError, "Invalid level: #{level}" unless LEVELS.include?(level.to_s)

        # Store instance variables
        @level = level.to_s
        @dismissible = dismissible
        @html_options = html_options
      end

      # Main render method (optional if using template)
      def call
        tag.div(**alert_attributes) do
          safe_join([
            icon_html,
            content,
            (dismiss_button if @dismissible)
          ].compact)
        end
      end

      private

      # Build HTML attributes
      def alert_attributes
        {
          class: alert_classes,
          role: "alert",
          "aria-live": aria_live,
          **@html_options
        }
      end

      # Build CSS classes
      def alert_classes
        [
          base_classes,
          level_classes,
          (@dismissible ? "pr-12" : nil)
        ].compact.join(" ")
      end

      def base_classes
        "flex items-center gap-3 p-4 rounded-lg border"
      end

      def level_classes
        case @level
        when "info"
          "bg-blue-50 border-blue-200 text-blue-800"
        when "success"
          "bg-green-50 border-green-200 text-green-800"
        when "warning"
          "bg-yellow-50 border-yellow-200 text-yellow-800"
        when "error"
          "bg-red-50 border-red-200 text-red-800"
        end
      end

      def aria_live
        @level == "error" ? "assertive" : "polite"
      end

      def icon_html
        # Return icon based on level
        tag.svg(class: "w-5 h-5 flex-shrink-0", viewBox: "0 0 20 20", fill: "currentColor") do
          tag.path(d: icon_path)
        end
      end

      def icon_path
        # Different icon paths for different levels
        case @level
        when "info" then "M10 18a8 8 0 100-16 8 8 0 000 16zm1-11a1 1 0 10-2 0v4a1 1 0 002 0V7z"
        when "success" then "M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
        when "warning" then "M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92z"
        when "error" then "M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z"
        end
      end

      def dismiss_button
        tag.button(
          type: "button",
          class: "absolute right-2 top-2 p-1 rounded hover:bg-black/5",
          aria_label: "Dismiss",
          data: { action: "click->alert#dismiss" }
        ) do
          tag.svg(class: "w-4 h-4", viewBox: "0 0 20 20", fill: "currentColor") do
            tag.path(d: "M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z")
          end
        end
      end
    end
  end
end
```

### Key Patterns

**1. Constants for valid options:**
```ruby
VARIANTS = %w[primary secondary danger].freeze
SIZES = %w[small medium large].freeze
```

**2. Validate inputs:**
```ruby
raise ArgumentError, "Invalid variant" unless VARIANTS.include?(variant.to_s)
```

**3. Use keyword arguments:**
```ruby
def initialize(variant: :primary, size: :medium, **html_options)
```

**4. Accept `**html_options`:**
```ruby
def initialize(**html_options)
  @html_options = html_options
end

def component_attributes
  {
    class: component_classes,
    **@html_options
  }
end
```

**5. Build CSS classes methodically:**
```ruby
def component_classes
  [
    base_classes,
    variant_classes,
    size_classes,
    @html_options[:class]  # Merge custom classes
  ].compact.join(" ")
end
```

**6. Use semantic HTML:**
```ruby
def call
  tag.button(content, **button_attributes)  # Not tag.div!
end
```

**7. Add ARIA attributes:**
```ruby
{
  role: "alert",
  "aria-live": "polite",
  "aria-label": "Close"
}
```

---

## Testing Requirements

### Minimum Test Coverage

Every component must have tests for:

1. ✅ **Default rendering**
2. ✅ **All variants/options**
3. ✅ **Content rendering (blocks)**
4. ✅ **HTML options pass-through**
5. ✅ **Edge cases (nil, empty, invalid)**

### Test Template

```ruby
# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Ui::AlertComponent, type: :component do
  describe "rendering" do
    it "renders with default options" do
      render_inline(described_class.new) { "Alert message" }

      expect(rendered_content).to include("Alert message")
      expect(rendered_content).to include("role=\"alert\"")
    end

    it "renders info level alert" do
      render_inline(described_class.new(level: :info)) { "Info message" }

      expect(rendered_content).to include("Info message")
      expect(rendered_content).to include("bg-blue-50")
    end

    it "renders success level alert" do
      render_inline(described_class.new(level: :success)) { "Success!" }

      expect(rendered_content).to include("Success!")
      expect(rendered_content).to include("bg-green-50")
    end

    it "renders warning level alert" do
      render_inline(described_class.new(level: :warning)) { "Warning!" }

      expect(rendered_content).to include("Warning!")
      expect(rendered_content).to include("bg-yellow-50")
    end

    it "renders error level alert" do
      render_inline(described_class.new(level: :error)) { "Error!" }

      expect(rendered_content).to include("Error!")
      expect(rendered_content).to include("bg-red-50")
    end
  end

  describe "dismissible option" do
    it "renders dismiss button when dismissible is true" do
      render_inline(described_class.new(dismissible: true))

      expect(rendered_content).to include("Dismiss")
      expect(rendered_content).to include("button")
    end

    it "does not render dismiss button when dismissible is false" do
      render_inline(described_class.new(dismissible: false))

      expect(rendered_content).not_to include("Dismiss")
    end
  end

  describe "HTML options" do
    it "accepts id attribute" do
      render_inline(described_class.new(id: "my-alert"))

      expect(rendered_content).to include('id="my-alert"')
    end

    it "accepts data attributes" do
      render_inline(described_class.new(data: { controller: "alert" }))

      expect(rendered_content).to include('data-controller="alert"')
    end

    it "accepts custom classes" do
      render_inline(described_class.new(class: "custom-class"))

      expect(rendered_content).to include("custom-class")
    end
  end

  describe "accessibility" do
    it "includes role attribute" do
      render_inline(described_class.new)

      expect(rendered_content).to include('role="alert"')
    end

    it "includes aria-live for error alerts" do
      render_inline(described_class.new(level: :error))

      expect(rendered_content).to include('aria-live="assertive"')
    end

    it "includes aria-live for non-error alerts" do
      render_inline(described_class.new(level: :info))

      expect(rendered_content).to include('aria-live="polite"')
    end

    it "includes aria-label for dismiss button" do
      render_inline(described_class.new(dismissible: true))

      expect(rendered_content).to include('aria-label="Dismiss"')
    end
  end

  describe "validation" do
    it "raises error for invalid level" do
      expect {
        described_class.new(level: :invalid)
      }.to raise_error(ArgumentError, /Invalid level/)
    end
  end

  describe "edge cases" do
    it "handles empty content" do
      render_inline(described_class.new) { "" }

      expect(rendered_content).to include('role="alert"')
    end

    it "handles nil content gracefully" do
      render_inline(described_class.new)

      expect(rendered_content).to include('role="alert"')
    end
  end
end
```

### Running Tests

```bash
# Run all tests
bundle exec rspec

# Run specific component tests
bundle exec rspec spec/components/artisans_ui/ui/alert_component_spec.rb

# Run with coverage
bundle exec rspec --format documentation
```

### Test Best Practices

**DO:**
- ✅ Test behavior, not implementation
- ✅ Test public API
- ✅ Test accessibility attributes
- ✅ Test edge cases
- ✅ Use descriptive test names

**DON'T:**
- ❌ Test private methods directly
- ❌ Test exact CSS class strings (brittle)
- ❌ Couple tests to implementation details
- ❌ Skip edge cases

---

## Code Style Guidelines

### Ruby Style

Follow [RuboCop Rails Omakase](https://github.com/rails/rubocop-rails-omakase) rules.

**Key points:**

```ruby
# Use frozen_string_literal
# frozen_string_literal: true

# Module/class structure
module ArtisansUi
  module Ui
    class MyComponent < ApplicationViewComponent
    end
  end
end

# Use keyword arguments
def initialize(variant: :default, **html_options)
end

# Private methods at bottom
private

def helper_method
end

# Use descriptive names
def button_classes  # Good
def bc              # Bad

# Limit line length to 120 characters
def long_method_that_does_something_complex
  # ...
end

# Use safe navigation
@user&.name

# Prefer guard clauses
def process
  return unless valid?

  do_something
end
```

### ERB Templates (if used)

```erb
<%# Use ERB comments, not HTML comments %>

<%# Good spacing %>
<div class="<%= component_classes %>">
  <%= content %>
</div>

<%# Bad spacing %>
<div class="<%=component_classes%>">
<%=content%>
</div>

<%# Use content_tag or tag helpers in Ruby when possible %>
```

### Tailwind CSS

```ruby
# Group related utilities
"flex items-center gap-2"  # Flexbox
"px-4 py-2"                # Padding
"text-sm font-medium"      # Typography
"bg-blue-600 hover:bg-blue-700"  # Colors

# Use consistent ordering
# 1. Layout (flex, grid)
# 2. Spacing (p, m, gap)
# 3. Sizing (w, h)
# 4. Typography (text, font)
# 5. Colors (bg, text, border)
# 6. Effects (shadow, rounded, transition)
# 7. Interaction (hover, focus)

# Responsive classes
"p-4 md:p-6 lg:p-8"

# Dark mode (when needed)
"bg-white dark:bg-gray-800"
```

### Naming Conventions

**Files:**
- `snake_case_component.rb`
- Match class name

**Classes:**
- `PascalCaseComponent`
- End with `Component`

**Methods:**
- `snake_case`
- Descriptive names

**Constants:**
- `SCREAMING_SNAKE_CASE`
- At top of class

**Instance Variables:**
- `@snake_case`
- Minimal use

---

## Documentation Standards

### Component Documentation

**At minimum, include:**

```ruby
# frozen_string_literal: true

module ArtisansUi
  module Ui
    # Renders an alert/notification message with different severity levels
    #
    # @example Basic info alert
    #   <%= render AlertComponent.new(level: :info) do %>
    #     This is an informational message
    #   <% end %>
    #
    # @example Dismissible warning alert
    #   <%= render AlertComponent.new(level: :warning, dismissible: true) do %>
    #     This is a warning you can dismiss
    #   <% end %>
    #
    # @example With custom HTML attributes
    #   <%= render AlertComponent.new(
    #     level: :error,
    #     id: "error-alert",
    #     data: { controller: "alert" }
    #   ) do %>
    #     An error occurred
    #   <% end %>
    #
    # @param level [Symbol] Alert severity level (:info, :success, :warning, :error)
    # @param dismissible [Boolean] Whether alert can be dismissed (default: false)
    # @param html_options [Hash] Additional HTML attributes
    #
    # @note This component includes proper ARIA attributes for accessibility
    # @note Dismissible alerts require Stimulus controller for dismiss functionality
    class AlertComponent < ApplicationViewComponent
      # ...
    end
  end
end
```

### README Updates

When adding a new component, update README.md:

```markdown
## Available Components

- **Alert Component** (`ArtisansUi::Ui::AlertComponent`)
  - Levels: `info`, `success`, `warning`, `error`
  - Dismissible option
  - Full accessibility support
```

### CHANGELOG Updates

Document all changes in CHANGELOG.md:

```markdown
## [Unreleased]

### Added
- New AlertComponent with 4 severity levels
- Dismissible option for alerts
- Icon support for each alert level

### Changed
- N/A

### Fixed
- N/A
```

---

## Pull Request Process

### Before Submitting

**Checklist:**

- [ ] All tests pass (`bundle exec rspec`)
- [ ] No RuboCop violations (`bundle exec rubocop`)
- [ ] Component tested manually in a Rails app
- [ ] Documentation complete (code comments + examples)
- [ ] CHANGELOG.md updated
- [ ] README.md updated (if adding new component)

### Creating PR

1. **Create feature branch:**
   ```bash
   git checkout -b feat/add-alert-component
   ```

2. **Make atomic commits:**
   ```bash
   git add app/components/artisans_ui/ui/alert_component.rb
   git commit -m "feat: add AlertComponent with 4 severity levels"

   git add spec/components/artisans_ui/ui/alert_component_spec.rb
   git commit -m "test: add comprehensive tests for AlertComponent"
   ```

3. **Push and create PR:**
   ```bash
   git push origin feat/add-alert-component
   ```

4. **Fill out PR template:**

```markdown
## Description

Adds a new AlertComponent for displaying notifications with different severity levels.

## Type of Change

- [x] New component
- [ ] Bug fix
- [ ] Enhancement to existing component
- [ ] Documentation update

## Changes

- Created AlertComponent with 4 levels: info, success, warning, error
- Added dismissible option with close button
- Includes proper ARIA attributes
- Full test coverage

## Testing

- [x] Unit tests added and passing
- [x] Manually tested in vacanciesAT
- [x] Tested with screen reader
- [x] Tested keyboard navigation

## Screenshots

[Attach screenshots of component in different states]

## Checklist

- [x] Tests pass
- [x] RuboCop passes
- [x] Documentation complete
- [x] CHANGELOG updated
- [x] README updated
- [x] Manually tested

## Migration Notes

N/A - New component

## Breaking Changes

None
```

### Review Process

1. **PR created** → Team notified
2. **Code review** → At least 1 approval required
3. **Address feedback** → Make requested changes
4. **Approval** → PR approved
5. **Merge** → Squash and merge to main
6. **Tag release** → Create version tag if needed

### After Merge

```bash
# Update local main
git checkout main
git pull origin main

# Delete feature branch
git branch -d feat/add-alert-component
git push origin --delete feat/add-alert-component

# Tag release if needed (maintainers only)
git tag v0.2.0
git push --tags
```

---

## Review Checklist

Use this checklist when reviewing PRs:

### Code Quality

- [ ] Code follows Ruby style guide
- [ ] No RuboCop violations
- [ ] Proper use of ViewComponent patterns
- [ ] No unnecessary complexity
- [ ] Efficient implementation (no performance issues)

### Component Design

- [ ] Single responsibility principle followed
- [ ] Component is reusable
- [ ] Props have sensible defaults
- [ ] Accepts `**html_options`
- [ ] Uses constants for valid options
- [ ] Input validation present

### Styling

- [ ] Uses Tailwind CSS appropriately
- [ ] Responsive design considerations
- [ ] Consistent with existing components
- [ ] No inline styles
- [ ] No custom CSS (unless absolutely necessary)

### Accessibility

- [ ] Proper HTML semantics used
- [ ] ARIA attributes included where needed
- [ ] Keyboard navigation works
- [ ] Focus indicators present
- [ ] Screen reader compatible
- [ ] Color contrast meets WCAG AA

### Testing

- [ ] All tests pass
- [ ] Test coverage is comprehensive
- [ ] Tests are not brittle
- [ ] Edge cases tested
- [ ] Accessibility tested

### Documentation

- [ ] Code comments present and clear
- [ ] Usage examples provided
- [ ] Props documented with `@param`
- [ ] README.md updated
- [ ] CHANGELOG.md updated
- [ ] No TODOs or FIXMEs left in code

### Integration

- [ ] Works in consuming Rails app
- [ ] No breaking changes (or properly documented)
- [ ] Version bump appropriate (major/minor/patch)
- [ ] Migration guide provided (if breaking)

---

## Questions?

- **Slack**: #frontend channel
- **Email**: dev-team@artisans.com
- **Issues**: GitGar repository issues

---

**Thank you for contributing to ArtisansUi! 🎉**
