# ArtisansUi Usage Guide

Complete guide for using the ArtisansUi component library across all Artisans applications.

**Design Philosophy:** Components are built using [RailsBlocks](https://railsblocks.com/) design patterns with Tailwind CSS and ViewComponent architecture.

---

## Table of Contents

1. [Quick Start](#quick-start)
2. [Installation in New Projects](#installation-in-new-projects)
3. [Local Development Setup](#local-development-setup)
4. [Creating New Components](#creating-new-components)
5. [Testing Components](#testing-components)
6. [Versioning & Releases](#versioning--releases)
7. [Updating Components](#updating-components)
8. [Publishing Updates](#publishing-updates)
9. [Consuming Updates in Apps](#consuming-updates-in-apps)
10. [Troubleshooting](#troubleshooting)
11. [Component Guidelines](#component-guidelines)
12. [Best Practices](#best-practices)

---

## Quick Start

**Using an existing component:**

```erb
<%= render ArtisansUi::Ui::ButtonComponent.new(variant: :primary) do %>
  Click me
<% end %>
```

**For local development:**

```bash
bundle config local.artisans_ui /Users/Indie/artisans/gems/artisans_ui
```

That's it! Changes to components will now reflect immediately.

---

## Installation in New Projects

### Step 1: Add to Gemfile

```ruby
# Gemfile
gem 'artisans_ui', git: 'https://github.com/artisanscompany/artisans_ui.git', branch: 'main'
```

**Or lock to a specific version:**

```ruby
gem 'artisans_ui', git: 'https://github.com/artisanscompany/artisans_ui.git', tag: 'v0.1.0'
```

### Step 2: Install

```bash
bundle install
```

### Step 3: Verify Installation

```bash
bin/rails console
```

```ruby
ArtisansUi::Ui::ButtonComponent
# => ArtisansUi::Ui::ButtonComponent
```

### Step 4: Use in Views

```erb
<!-- app/views/your_view.html.erb -->
<%= render ArtisansUi::Ui::ButtonComponent.new(variant: :primary) do %>
  My Button
<% end %>
```

---

## Local Development Setup

When you need to work on components while using them in your Rails app:

### Initial Setup

```bash
# 1. Clone the component library (if not already cloned)
cd /Users/Indie/artisans/gems
git clone https://github.com/artisanscompany/artisans_ui.git
cd artisans_ui
bundle install

# 2. In your Rails application
cd /path/to/your/rails/app
bundle config local.artisans_ui /Users/Indie/artisans/gems/artisans_ui

# 3. Verify configuration
bundle config get local.artisans_ui
# => /Users/Indie/artisans/gems/artisans_ui
```

### How It Works

- **Immediate Feedback**: Changes to components in `/Users/Indie/artisans/gems/artisans_ui` reflect immediately
- **No Bundle Install**: Changes don't require `bundle install`
- **Server Restart**: May need to restart Rails server for some changes
- **Spring Cache**: If using Spring, run `spring stop` if changes don't appear

### When You're Done

```bash
# Remove local override
bundle config unset local.artisans_ui

# Revert to using the remote gem
bundle install
```

---

## Creating New Components

### Step 1: Generate Component

```bash
cd /Users/Indie/artisans/gems/artisans_ui
bin/rails generate view_component:component ArtisansUi::Ui::Card title
```

This creates:
- `app/components/artisans_ui/ui/card_component.rb`
- `app/components/artisans_ui/ui/card_component.html.erb`

### Step 2: Move to Correct Location

The generator may create nested directories. Move files if needed:

```bash
# If generated in wrong location
mkdir -p app/components/artisans_ui/ui
mv app/components/artisans_ui/artisans_ui/ui/* app/components/artisans_ui/ui/
rm -rf app/components/artisans_ui/artisans_ui
```

### Step 3: Implement Component

**Ruby Class:**

```ruby
# frozen_string_literal: true

module ArtisansUi
  module Ui
    class CardComponent < ApplicationViewComponent
      def initialize(title:, **html_options)
        @title = title
        @html_options = html_options
      end

      private

      def card_classes
        "bg-white rounded-lg shadow p-6"
      end
    end
  end
end
```

**Template (or inline):**

Option A: Use separate template file
```erb
<!-- app/components/artisans_ui/ui/card_component.html.erb -->
<div class="<%= card_classes %>">
  <h3 class="text-lg font-semibold mb-4"><%= @title %></h3>
  <%= content %>
</div>
```

Option B: Use inline rendering (recommended for simple components)
```ruby
def call
  tag.div(class: card_classes) do
    tag.h3(@title, class: "text-lg font-semibold mb-4") + content
  end
end
```

### Step 4: Create Spec

```bash
mkdir -p spec/components/artisans_ui/ui
```

```ruby
# spec/components/artisans_ui/ui/card_component_spec.rb
# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Ui::CardComponent, type: :component do
  it "renders a card with title" do
    render_inline(described_class.new(title: "My Card")) { "Card content" }

    expect(rendered_content).to include("My Card")
    expect(rendered_content).to include("Card content")
    expect(rendered_content).to include("bg-white")
  end
end
```

### Step 5: Run Tests

```bash
bundle exec rspec spec/components/artisans_ui/ui/card_component_spec.rb
```

---

## Testing Components

### Running All Tests

```bash
cd /Users/Indie/artisans/gems/artisans_ui
bundle exec rspec
```

### Running Specific Component Tests

```bash
bundle exec rspec spec/components/artisans_ui/ui/button_component_spec.rb
```

### Writing Tests

**Basic Structure:**

```ruby
require "rails_helper"

RSpec.describe ArtisansUi::Ui::YourComponent, type: :component do
  it "renders with default options" do
    render_inline(described_class.new)

    expect(rendered_content).to include("expected text")
  end

  it "accepts custom attributes" do
    render_inline(described_class.new(variant: :primary, id: "my-id"))

    expect(rendered_content).to include('id="my-id"')
  end

  it "renders content block" do
    render_inline(described_class.new) { "Block content" }

    expect(rendered_content).to include("Block content")
  end
end
```

**Available Matchers:**

- `rendered_content` - Access the rendered HTML
- `include()` - Check for string inclusion
- String methods - `rendered_content.include?("text")`

### Test Coverage Goals

- ✅ All variants render correctly
- ✅ Default values work
- ✅ Custom HTML attributes pass through
- ✅ Content blocks render
- ✅ Edge cases handled (nil values, empty strings, etc.)

---

## Versioning & Releases

We follow **Semantic Versioning** (SemVer): `MAJOR.MINOR.PATCH`

### Version Numbers

- **MAJOR** (1.0.0): Breaking changes - requires code updates
- **MINOR** (0.1.0): New features - backwards compatible
- **PATCH** (0.0.1): Bug fixes - backwards compatible

### When to Bump Versions

**MAJOR (Breaking Changes):**
- Removing components
- Removing component props/options
- Changing default behavior
- Renaming components or props
- Changing Tailwind classes in breaking ways

**MINOR (New Features):**
- Adding new components
- Adding new props/options (with defaults)
- Adding new variants
- Enhancing existing features (non-breaking)

**PATCH (Bug Fixes):**
- Fixing bugs
- Updating documentation
- Refactoring without changing API
- Styling tweaks that don't break layouts

### Version File

```ruby
# lib/artisans_ui/version.rb
module ArtisansUi
  VERSION = "0.1.0"
end
```

---

## Updating Components

### Workflow

```bash
# 1. Make sure you have local development configured
cd /Users/Indie/artisans/gems/artisans_ui
git checkout main
git pull origin main

# 2. Create a feature branch (recommended for large changes)
git checkout -b feat/improve-button-component

# 3. Make your changes
# Edit app/components/artisans_ui/ui/button_component.rb

# 4. Update or add tests
# Edit spec/components/artisans_ui/ui/button_component_spec.rb

# 5. Run tests
bundle exec rspec

# 6. Test in your Rails app (via bundle config local)
cd /path/to/your/rails/app
# Test manually in browser

# 7. Commit changes
cd /Users/Indie/artisans/gems/artisans_ui
git add .
git commit -m "feat: add new button size variants"

# 8. Push and create PR (for team review)
git push origin feat/improve-button-component
```

### Quick Updates (Small Changes)

For small changes you can commit directly to main:

```bash
cd /Users/Indie/artisans/gems/artisans_ui

# Make changes
# Run tests
bundle exec rspec

# Commit
git add .
git commit -m "fix: button padding on mobile"
git push origin main
```

---

## Publishing Updates

### For Patch/Minor Updates

```bash
cd /Users/Indie/artisans/gems/artisans_ui

# 1. Update version in lib/artisans_ui/version.rb
# Change VERSION = "0.1.0" to VERSION = "0.1.1"

# 2. Update CHANGELOG.md
# Add entry under new version heading

# 3. Commit version bump
git add lib/artisans_ui/version.rb CHANGELOG.md
git commit -m "chore: bump version to 0.1.1"

# 4. Create and push tag
git tag v0.1.1
git push origin main
git push --tags

# Done! Version v0.1.1 is now available
```

### For Major Updates (Breaking Changes)

```bash
cd /Users/Indie/artisans/gems/artisans_ui

# 1. Update version
# Change VERSION = "0.1.0" to VERSION = "1.0.0"

# 2. Update CHANGELOG.md with BREAKING CHANGES section
# Document what breaks and how to migrate

# 3. Update README.md if needed
# Add migration guide

# 4. Commit and tag
git add .
git commit -m "feat!: breaking changes for v1.0.0

BREAKING CHANGES:
- ButtonComponent no longer accepts `size` prop
- Use `variant` prop instead"

git tag v1.0.0
git push origin main
git push --tags

# 5. Notify team about breaking changes
```

### CHANGELOG.md Format

```markdown
# Changelog

## [0.2.0] - 2025-01-15

### Added
- New CardComponent for displaying content boxes
- ButtonComponent now accepts `disabled` prop
- Added outline-dashed variant to ButtonComponent

### Changed
- Improved button hover states for better accessibility
- Updated Tailwind classes for consistent spacing

### Fixed
- Fixed button text overflow on mobile devices
- Fixed outline variant border color in dark mode

### Deprecated
- None

### Removed
- None

### Security
- None

## [0.1.0] - 2025-01-14

Initial release
```

---

## Consuming Updates in Apps

### Check Current Version

```bash
cd /path/to/your/rails/app
bundle list | grep artisans_ui
# => artisans_ui (0.1.0 cc03f79)
```

### Update to Latest

```bash
# Update to latest from branch
bundle update artisans_ui

# Verify new version
bundle list | grep artisans_ui
```

### Update to Specific Version

**Option 1: Update Gemfile**

```ruby
# Change this:
gem 'artisans_ui', git: 'https://github.com/artisanscompany/artisans_ui.git', branch: 'main'

# To this:
gem 'artisans_ui', git: 'https://github.com/artisanscompany/artisans_ui.git', tag: 'v0.2.0'
```

```bash
bundle install
```

**Option 2: Use ref (commit SHA)**

```ruby
gem 'artisans_ui', git: 'https://github.com/artisanscompany/artisans_ui.git', ref: 'abc123'
```

### Verify Components Work

```bash
bin/rails console
```

```ruby
# Check component exists
ArtisansUi::Ui::ButtonComponent
# => ArtisansUi::Ui::ButtonComponent

# Test rendering
component = ArtisansUi::Ui::ButtonComponent.new(variant: :primary)
component.render_in(ApplicationController.renderer) { "Test" }
# => "<button class='...' ...>Test</button>"
```

### Rollback if Needed

```ruby
# Gemfile - specify previous version
gem 'artisans_ui', git: 'https://github.com/artisanscompany/artisans_ui.git', tag: 'v0.1.0'
```

```bash
bundle install
bin/rails restart  # or restart server manually
```

---

## Troubleshooting

### "Cannot use local override" Error

**Error:**
```
Cannot use local override for view-components because :branch is not specified in Gemfile
```

**Solution:**
Ensure your Gemfile specifies a branch:

```ruby
gem 'artisans_ui', git: 'https://github.com/artisanscompany/artisans_ui.git', branch: 'main'
```

Then run:
```bash
bundle install
bundle config local.artisans_ui /Users/Indie/code/artisans_ui
```

---

### Local Changes Not Reflecting

**Issue:** Changes to components don't appear in your Rails app

**Solutions:**

1. **Restart Rails server**
   ```bash
   # Stop server (Ctrl+C), then restart
   bin/rails server
   ```

2. **Stop Spring (if using)**
   ```bash
   spring stop
   bin/rails server
   ```

3. **Verify local config**
   ```bash
   bundle config get local.artisans_ui
   # Should show: /Users/Indie/code/artisans_ui
   ```

4. **Check for syntax errors**
   ```bash
   cd /Users/Indie/artisans/gems/artisans_ui
   bundle exec rspec  # Run tests
   ```

---

### Component Not Found

**Error:**
```
uninitialized constant ArtisansUi::Ui::MyComponent
```

**Solutions:**

1. **Check component file location**
   ```bash
   ls /Users/Indie/code/artisans_ui/app/components/artisans_ui/ui/
   ```

2. **Check component class name**
   ```ruby
   # Must match file name
   # File: button_component.rb
   class ButtonComponent < ApplicationViewComponent
   ```

3. **Restart Rails**
   ```bash
   spring stop  # if using Spring
   bin/rails restart
   ```

4. **Update bundle**
   ```bash
   bundle update artisans_ui
   ```

---

### Tests Failing

**Issue:** Component tests fail after changes

**Debug Steps:**

1. **Run tests with backtrace**
   ```bash
   bundle exec rspec --backtrace
   ```

2. **Check test file path**
   ```bash
   # Must be in spec/components/
   ls spec/components/artisans_ui/ui/
   ```

3. **Verify rails_helper loads**
   ```ruby
   # spec/components/your_component_spec.rb
   require "rails_helper"  # Must be first line
   ```

4. **Check ViewComponent test helpers**
   ```ruby
   # spec/rails_helper.rb should have:
   require 'view_component/test_helpers'
   config.include ViewComponent::TestHelpers, type: :component
   ```

---

### Git Push Rejected

**Error:**
```
! [rejected] main -> main (fetch first)
```

**Solution:**

```bash
# Pull latest changes first
git pull origin main --rebase

# Resolve any conflicts if they occur
# Then push
git push origin main
```

---

### Bundle Install Hangs

**Issue:** `bundle install` hangs when fetching from github.com

**Solutions:**

1. **Check HTTPS access**
   ```bash
   curl -I https://github.com/artisanscompany/artisans_ui.git
   ```

2. **Clear bundler cache**
   ```bash
   bundle clean --force
   rm -rf ~/.bundle/cache
   bundle install
   ```

3. **Use verbose mode**
   ```bash
   bundle install --verbose
   ```

---

## Component Guidelines

### Naming Conventions

**Component Files:**
- Use `snake_case` for file names
- End with `_component.rb`
- Match class name

```
button_component.rb → ButtonComponent
card_header_component.rb → CardHeaderComponent
```

**Component Classes:**
- Use `PascalCase`
- End with `Component`
- Namespace under appropriate module

```ruby
module ArtisansUi
  module Ui
    class ButtonComponent < ApplicationViewComponent
    end
  end

  module Forms
    class InputComponent < ApplicationViewComponent
    end
  end
end
```

**Usage in Views:**
```erb
<%= render ArtisansUi::Ui::ButtonComponent.new %>
<%= render ArtisansUi::Forms::InputComponent.new %>
```

### Directory Structure

```
app/components/artisans_ui/
├── application_view_component.rb  # Base class
├── ui/                            # Pure UI components
│   ├── button_component.rb
│   ├── card_component.rb
│   └── modal_component.rb
├── forms/                         # Form-related components
│   ├── input_component.rb
│   ├── select_component.rb
│   └── checkbox_component.rb
└── layouts/                       # Layout components
    ├── navbar_component.rb
    ├── sidebar_component.rb
    └── footer_component.rb
```

### Component Props

**Use keyword arguments:**

```ruby
# Good
def initialize(variant: :primary, size: :medium, disabled: false, **html_options)
  @variant = variant
  @size = size
  @disabled = disabled
  @html_options = html_options
end

# Bad - avoid positional arguments
def initialize(variant, size, disabled)
end
```

**Provide sensible defaults:**

```ruby
def initialize(variant: :primary, size: :medium, **html_options)
  # variant defaults to :primary
  # size defaults to :medium
end
```

**Accept HTML options:**

```ruby
def initialize(variant: :primary, **html_options)
  @variant = variant
  @html_options = html_options
end

private

def button_attributes
  {
    class: button_classes,
    **@html_options  # Spreads additional HTML attributes
  }
end
```

**Usage:**
```erb
<%= render ButtonComponent.new(
  variant: :primary,
  type: "submit",
  id: "my-button",
  data: { action: "click->controller#method" }
) %>
```

### Styling

**Use Tailwind CSS:**

```ruby
def button_classes
  base = "px-4 py-2 rounded-md font-medium transition-colors"

  variant = case @variant
  when :primary then "bg-blue-600 text-white hover:bg-blue-700"
  when :secondary then "bg-gray-200 text-gray-900 hover:bg-gray-300"
  end

  "#{base} #{variant}"
end
```

**Support variants:**

```ruby
VARIANTS = %w[primary secondary danger success warning].freeze

def initialize(variant: :primary, **html_options)
  raise ArgumentError, "Invalid variant" unless VARIANTS.include?(variant.to_s)
  @variant = variant.to_s
end
```

**Make components responsive:**

```ruby
def card_classes
  "p-4 md:p-6 lg:p-8"  # Responsive padding
end
```

### Accessibility

**Always include:**

- Proper HTML semantics
- ARIA labels when needed
- Keyboard navigation support
- Focus states
- Screen reader text

```ruby
def button_attributes
  {
    class: button_classes,
    type: @type || "button",
    disabled: @disabled,
    "aria-disabled": @disabled,
    **@html_options
  }
end
```

### Documentation

**Add comments to complex components:**

```ruby
# frozen_string_literal: true

module ArtisansUi
  module Ui
    # Renders a customizable button component
    #
    # @example Basic usage
    #   <%= render ButtonComponent.new(variant: :primary) do %>
    #     Click me
    #   <% end %>
    #
    # @example With HTML options
    #   <%= render ButtonComponent.new(
    #     variant: :secondary,
    #     type: "submit",
    #     data: { turbo_confirm: "Are you sure?" }
    #   ) do %>
    #     Submit Form
    #   <% end %>
    #
    # @param variant [Symbol] Button style (:primary, :secondary, :danger, :outline)
    # @param html_options [Hash] Additional HTML attributes
    class ButtonComponent < ApplicationViewComponent
      # ...
    end
  end
end
```

---

## Best Practices

### 1. Keep Components Small

**Good:**
```ruby
# Focused, single responsibility
class ButtonComponent < ApplicationViewComponent
  def initialize(variant: :primary, **html_options)
    @variant = variant
    @html_options = html_options
  end
end
```

**Bad:**
```ruby
# Too many responsibilities
class MegaComponent < ApplicationViewComponent
  def initialize(button_text:, card_title:, modal_content:, form_fields:)
    # This component does too much!
  end
end
```

**Better:** Break into smaller components:
- `ButtonComponent`
- `CardComponent`
- `ModalComponent`
- `FormFieldComponent`

### 2. Composition Over Configuration

**Good:**
```erb
<%= render CardComponent.new do %>
  <%= render CardHeaderComponent.new(title: "My Card") %>
  <%= render CardBodyComponent.new do %>
    <p>Content here</p>
  <% end %>
<% end %>
```

**Bad:**
```erb
<%= render CardComponent.new(
  title: "My Card",
  body: "<p>Content here</p>",
  has_header: true,
  header_style: :bold,
  body_padding: :large
) %>
```

### 3. Use Slots for Complex Layouts

```ruby
class CardComponent < ApplicationViewComponent
  renders_one :header
  renders_one :body
  renders_one :footer
end
```

```erb
<%= render CardComponent.new do |card| %>
  <%= card.with_header do %>
    <h3>Title</h3>
  <% end %>

  <%= card.with_body do %>
    <p>Content</p>
  <% end %>

  <%= card.with_footer do %>
    <button>Action</button>
  <% end %>
<% end %>
```

### 4. Test Component API, Not Implementation

**Good:**
```ruby
it "renders primary button variant" do
  render_inline(described_class.new(variant: :primary)) { "Click" }

  expect(rendered_content).to include("Click")
  # Test behavior, not specific classes
  expect(rendered_content).to include("button")
end
```

**Bad:**
```ruby
it "has exact Tailwind classes" do
  render_inline(described_class.new(variant: :primary))

  # Brittle - breaks if we change Tailwind classes
  expect(rendered_content).to include("bg-blue-600 text-white px-4 py-2")
end
```

### 5. Version Components Carefully

**Before releasing a breaking change:**

1. Add deprecation warning in current version
2. Document migration path
3. Release major version with changes
4. Update all consuming apps

**Example deprecation:**

```ruby
def initialize(size: nil, variant: :primary, **html_options)
  if size
    warn "[DEPRECATION] `size` prop is deprecated. Use `variant` instead."
  end
  @variant = variant
end
```

### 6. Document Component APIs

Create a component showcase page:

```erb
<!-- app/views/styleguide/index.html.erb -->
<h1>Component Library</h1>

<section>
  <h2>Buttons</h2>

  <%= render ArtisansUi::Ui::ButtonComponent.new(variant: :primary) do %>
    Primary
  <% end %>

  <%= render ArtisansUi::Ui::ButtonComponent.new(variant: :secondary) do %>
    Secondary
  <% end %>
</section>
```

### 7. Performance

**Avoid expensive operations in `call`:**

```ruby
# Good - compute once in initialize
def initialize(items:)
  @items = items
  @item_count = items.size  # Compute once
end

def call
  tag.div do
    "#{@item_count} items"  # Use cached value
  end
end

# Bad - compute on every render
def call
  count = @items.size  # Computed every time
  tag.div { "#{count} items" }
end
```

### 8. Consistency

**Establish conventions:**

- Always use `frozen_string_literal: true`
- Inherit from `ApplicationViewComponent`
- Use `**html_options` for extensibility
- Follow naming patterns (verb_noun or noun_adjective)
- Group related components in same module

### 9. Progressive Enhancement

**Make components work without JavaScript:**

```ruby
def turbo_attributes
  if @turbo_enabled
    { data: { turbo_frame: @frame_id } }
  else
    {}
  end
end
```

### 10. Avoid Component Sprawl

**Before creating a new component, ask:**

1. Will this be reused in 3+ places?
2. Does it have a clear, focused purpose?
3. Can it be composed from existing components?
4. Does it encapsulate complex logic worth abstracting?

If not, consider using a partial or inline markup instead.

---

## Additional Resources

### Internal Resources

- [README.md](README.md) - Quick start and overview
- [CHANGELOG.md](CHANGELOG.md) - Version history
- [CONTRIBUTING.md](CONTRIBUTING.md) - Contribution guidelines

### External Resources

- [ViewComponent Documentation](https://viewcomponent.org/)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [Rails Guides - Layouts and Rendering](https://guides.rubyonrails.org/layouts_and_rendering.html)

### Getting Help

- **Team Communication**: Slack #frontend channel
- **Issues**: Create issue on GitGar repository
- **Questions**: Ask in team standup or post in #dev channel

---

## Quick Reference

### Common Commands

```bash
# Setup local development
bundle config local.artisans_ui /Users/Indie/code/artisans_ui

# Remove local development
bundle config unset local.artisans_ui

# Run all tests
bundle exec rspec

# Update in consuming app
bundle update artisans_ui

# Create new component
bin/rails generate view_component:component ArtisansUi::Ui::MyComponent

# Tag new version
git tag v0.2.0 && git push --tags
```

### Component Template

```ruby
# frozen_string_literal: true

module ArtisansUi
  module Ui
    class MyComponent < ApplicationViewComponent
      def initialize(variant: :default, **html_options)
        @variant = variant
        @html_options = html_options
      end

      def call
        tag.div(content, **component_attributes)
      end

      private

      def component_attributes
        {
          class: component_classes,
          **@html_options
        }
      end

      def component_classes
        "base-classes variant-#{@variant}"
      end
    end
  end
end
```

### Test Template

```ruby
# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Ui::MyComponent, type: :component do
  it "renders with default options" do
    render_inline(described_class.new) { "Content" }

    expect(rendered_content).to include("Content")
  end

  it "accepts custom variant" do
    render_inline(described_class.new(variant: :custom))

    expect(rendered_content).to include("variant-custom")
  end

  it "passes through HTML options" do
    render_inline(described_class.new(id: "test-id"))

    expect(rendered_content).to include('id="test-id"')
  end
end
```

---

**Last Updated:** January 2025
**Version:** 1.0
**Maintainer:** Artisans Development Team
