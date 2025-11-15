# ArtisansUi

A shared ViewComponent library for Artisans applications. This gem provides reusable, tested UI components that can be used across multiple Rails applications.

## 📚 Documentation

- **[Usage Guide](USAGE_GUIDE.md)** - Complete guide for installation, development, and workflows
- **[Contributing Guide](CONTRIBUTING.md)** - Guidelines for creating and contributing components
- **[Changelog](CHANGELOG.md)** - Version history and release notes

## Features

- Built with [ViewComponent](https://viewcomponent.org/) for performance and testability
- [RailsBlocks](https://railsblocks.com/)-inspired Tailwind CSS styling for modern, responsive design
- Comprehensive test coverage with RSpec
- Easy to extend and customize
- Dark mode support across all components

## Quick Start

### Installation

```ruby
# Gemfile
gem 'artisans_ui', git: 'git@gitgar.com:templates/view-components.git', branch: 'main'
```

### Usage

```erb
<%= render ArtisansUi::Ui::ButtonComponent.new(variant: :primary) do %>
  Click me
<% end %>
```

### Local Development

```bash
bundle config local.artisans_ui /Users/Indie/code/artisans_ui
```

**📖 For detailed instructions, see [USAGE_GUIDE.md](USAGE_GUIDE.md)**

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'artisans_ui', git: 'git@gitgar.com:templates/view-components.git'
```

For production, lock to a specific version tag:

```ruby
gem 'artisans_ui', git: 'git@gitgar.com:templates/view-components.git', tag: 'v0.1.0'
```

Then execute:

```bash
bundle install
```

## Usage

### Button Component

```erb
<%# Basic usage %>
<%= render ArtisansUi::Ui::ButtonComponent.new do %>
  Click me
<% end %>

<%# With variant %>
<%= render ArtisansUi::Ui::ButtonComponent.new(variant: :primary) do %>
  Primary Button
<% end %>

<%= render ArtisansUi::Ui::ButtonComponent.new(variant: :secondary) do %>
  Secondary Button
<% end %>

<%= render ArtisansUi::Ui::ButtonComponent.new(variant: :danger) do %>
  Delete
<% end %>

<%= render ArtisansUi::Ui::ButtonComponent.new(variant: :outline) do %>
  Cancel
<% end %>

<%# With additional HTML options %>
<%= render ArtisansUi::Ui::ButtonComponent.new(
  variant: :primary,
  type: "submit",
  data: { turbo_confirm: "Are you sure?" }
) do %>
  Submit Form
<% end %>
```

### AnimatedNumber Component

```erb
<%# Basic counter %>
<%= render ArtisansUi::AnimatedNumber::BasicComponent.new(
  start_value: 0,
  end_value: 1250,
  duration: 2000,
  label: "Users registered"
) %>

<%# Currency formatter %>
<%= render ArtisansUi::AnimatedNumber::CurrencyComponent.new(
  start_value: 50,
  end_value: 850.99,
  duration: 2500,
  suffix: " / month",
  label: "Monthly revenue"
) %>

<%# Compact notation %>
<%= render ArtisansUi::AnimatedNumber::CompactComponent.new(
  start_value: 0,
  end_value: 125600,
  duration: 2000,
  label: "Total downloads"
) %>

<%# Percentage with prefix/suffix %>
<%= render ArtisansUi::AnimatedNumber::PercentageComponent.new(
  start_value: 0,
  end_value: 147.5,
  duration: 2800,
  prefix: "+",
  suffix: "%",
  label: "Year-over-year growth"
) %>

<%# Continuous animation %>
<%= render ArtisansUi::AnimatedNumber::ContinuousComponent.new(
  start_value: 0,
  end_value: 100,
  duration: 1500,
  continuous: true,
  label: "Continuous Animation"
) %>

<%# Custom easing %>
<%= render ArtisansUi::AnimatedNumber::CustomEasingComponent.new(
  start_value: 0,
  end_value: 1000,
  duration: 2000,
  spin_easing: "cubic-bezier(0.68, -0.55, 0.265, 1.55)",
  transform_easing: "cubic-bezier(0.68, -0.55, 0.265, 1.55)",
  label: "Bounce",
  description: "Overshoots & settles"
) %>

<%# Trigger on load %>
<%= render ArtisansUi::AnimatedNumber::TriggerOnScrollComponent.new(
  start_value: 0,
  end_value: 100000,
  duration: 3500,
  trigger: "load",
  suffix: "+",
  label: "Lines of code"
) %>

<%# Countdown timer %>
<%= render ArtisansUi::AnimatedNumber::CountdownComponent.new(
  start_value: 10,
  end_value: 0,
  duration: 500,
  trend: -1,
  suffix: "s",
  update_interval: 1000,
  label: "Countdown timer"
) %>
```

### Breadcrumb Component

```erb
<%# Basic breadcrumb %>
<%= render ArtisansUi::Breadcrumb::BasicComponent.new(items: [
  { label: "Home", href: "/" },
  { label: "Products", href: "/products" },
  { label: "Electronics", href: "/products/electronics" },
  { label: "Headphones" }
]) %>

<%# Breadcrumb with icons %>
<%= render ArtisansUi::Breadcrumb::WithIconsComponent.new(items: [
  { label: "Home", href: "/", home_icon: true },
  { label: "Dashboard", href: "/dashboard" },
  { label: "Projects", href: "/projects" },
  { label: "Project Alpha" }
]) %>

<%# Breadcrumb with background %>
<%= render ArtisansUi::Breadcrumb::WithBackgroundComponent.new(items: [
  { label: "Home", href: "/" },
  { label: "Documentation", href: "/docs" },
  { label: "Components", href: "/docs/components" },
  { label: "Breadcrumb" }
]) %>

<%# Breadcrumb with truncation %>
<%= render ArtisansUi::Breadcrumb::WithTruncationComponent.new(items: [
  { label: "Home", href: "/" },
  { label: "...", collapsed: true },
  { label: "Category", href: "/category" },
  { label: "Subcategory", href: "/category/subcategory" },
  { label: "Very Long Product Name That Might Need Truncation" }
]) %>
```

### Card Component

```erb
<%# Basic card with just body %>
<%= render ArtisansUi::Ui::CardComponent.new do |card| %>
  <% card.with_body do %>
    <p class="text-neutral-700 dark:text-neutral-300">
      Card content goes here
    </p>
  <% end %>
<% end %>

<%# Card with header and body %>
<%= render ArtisansUi::Ui::CardComponent.new do |card| %>
  <% card.with_header do %>
    <h3 class="text-lg leading-6 font-medium text-neutral-900 dark:text-white">Card Title</h3>
    <p class="mt-1 text-sm text-neutral-600 dark:text-neutral-400">Description</p>
  <% end %>
  <% card.with_body do %>
    <p class="text-neutral-700 dark:text-neutral-300">Body content</p>
  <% end %>
<% end %>

<%# Card with all sections %>
<%= render ArtisansUi::Ui::CardComponent.new do |card| %>
  <% card.with_header do %>
    <h3 class="text-lg font-medium text-neutral-900 dark:text-white">Complete Card</h3>
  <% end %>
  <% card.with_body do %>
    <p class="text-neutral-700 dark:text-neutral-300">Main content</p>
  <% end %>
  <% card.with_footer do %>
    <%= render ArtisansUi::Ui::ButtonComponent.new(variant: :primary) do %>
      Action
    <% end %>
  <% end %>
<% end %>
```

## Local Development Workflow

### Setting Up Local Development

To work on the component library while using it in your Rails app:

1. Clone the repository:
   ```bash
   cd ~/code  # or your preferred location
   git clone git@gitgar.com:templates/view-components.git artisans_ui
   cd artisans_ui
   bundle install
   ```

2. In your Rails application, configure Bundler to use your local copy:
   ```bash
   cd /path/to/your/rails/app
   bundle config local.artisans_ui /Users/Indie/code/artisans_ui
   ```

3. Make changes to components in `/Users/Indie/code/artisans_ui`
4. Changes will be reflected immediately in your Rails app (restart server if needed)

### Making Changes

1. **Edit components** in `/Users/Indie/code/artisans_ui/app/components/`
2. **Write/update tests** in `/Users/Indie/code/artisans_ui/spec/components/`
3. **Run tests**:
   ```bash
   cd /Users/Indie/code/artisans_ui
   bundle exec rspec
   ```
4. **Commit and push**:
   ```bash
   git add .
   git commit -m "feat: add new component"
   git push origin main
   ```

### Creating a Release

1. Update version in `lib/artisans_ui/version.rb`
2. Update `CHANGELOG.md` with changes
3. Commit the version bump:
   ```bash
   git add .
   git commit -m "chore: bump version to 0.2.0"
   ```
4. Create and push a tag:
   ```bash
   git tag v0.2.0
   git push origin main --tags
   ```

### Using the Latest Changes in Other Apps

```bash
cd /path/to/your/rails/app
bundle update artisans_ui
```

### Removing Local Development Configuration

When you're done with local development:

```bash
bundle config unset local.artisans_ui
```

## Available Components

### Accordion Components

- **11 Accordion Variants** (`ArtisansUi::Accordion::*`)
  - Chevron icon, Plus/minus icon, Multiple items open, Left arrow icon
  - Styled variants, Nesting support, Disabled items, Open by default
  - Zero dependency options

### Alert Components

- **5 Alert Variants** (`ArtisansUi::Alert::*`)
  - Success, Error, Info/Neutral alerts
  - Minimal alert variants with custom icons
  - Dark mode support

### AnimatedNumber Components

- **8 AnimatedNumber Variants** (`ArtisansUi::AnimatedNumber::*`)
  - Basic counter, Currency formatter, Compact notation (1K, 1M)
  - Percentage with prefix/suffix, Continuous vs Discrete animation
  - Custom easing functions, Trigger on scroll/load, Countdown timer
  - Powered by number-flow library

### Breadcrumb Components

- **4 Breadcrumb Variants** (`ArtisansUi::Breadcrumb::*`)
  - Basic breadcrumb with slash separators
  - With icons (home icon + chevron separators)
  - With background styling
  - With truncation for long paths

### Button Component

- **Button Component** (`ArtisansUi::Ui::ButtonComponent`)
  - Variants: `primary`, `secondary`, `danger`, `outline`
  - Supports all standard HTML button attributes

### Card Component

- **Card Component** (`ArtisansUi::Ui::CardComponent`)
  - Flexible layout with header, body, and footer slots
  - RailsBlocks-inspired styling with dark mode support
  - Customizable with HTML attributes

More components coming soon!

## Contributing

We welcome contributions! Please read our [Contributing Guide](CONTRIBUTING.md) for:

- Component design principles
- Code style guidelines
- Testing requirements
- Pull request process

**Quick checklist:**
- [ ] Tests pass (`bundle exec rspec`)
- [ ] Documentation added
- [ ] CHANGELOG.md updated
- [ ] Follows component guidelines

## Testing

Run the test suite:

```bash
bundle exec rspec
```

Run tests for a specific component:

```bash
bundle exec rspec spec/components/artisans_ui/ui/button_component_spec.rb
```

## Architecture

- **Engine**: Rails engine with minimal dependencies (activemodel, railties, view_component)
- **Components**: Inherit from `ArtisansUi::ApplicationViewComponent`
- **Styling**: Tailwind CSS utility classes
- **Namespace**: All components are under the `ArtisansUi` module

## Resources

### Documentation
- [Usage Guide](USAGE_GUIDE.md) - Installation, workflows, troubleshooting
- [Contributing Guide](CONTRIBUTING.md) - Component creation guidelines
- [Changelog](CHANGELOG.md) - Version history

### External Links
- [ViewComponent Documentation](https://viewcomponent.org/)
- [RailsBlocks](https://railsblocks.com/) - Component design inspiration and patterns
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [Rails Guides](https://guides.rubyonrails.org/)

## Support

- **Issues**: [GitGar Repository](git@gitgar.com:templates/view-components.git)
- **Team Chat**: #frontend channel
- **Questions**: Post in #dev channel

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
