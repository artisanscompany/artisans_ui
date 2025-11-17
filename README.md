# ArtisansUi

A shared ViewComponent library for Artisans applications. This gem provides reusable, tested UI components that can be used across multiple Rails applications.

## 📚 Documentation

- **[Usage Guide](USAGE_GUIDE.md)** - Complete guide for installation, development, and workflows
- **[Sidebar Component Guide](docs/SIDEBAR_COMPONENT.md)** - Comprehensive sidebar component documentation with Tailwind CSS 4 integration
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

### Sidebar Component

```erb
<%# Basic sidebar with header, navigation, and footer %>
<%= render ArtisansUi::Sidebar::BasicComponent.new do |sidebar| %>
  <% sidebar.with_header do %>
    <%= link_to root_path, class: "flex items-center space-x-2 min-w-0" do %>
      <%= image_tag "/logo-48.png", alt: "My App", class: "h-8 w-8 flex-shrink-0" %>
      <span class="text-lg font-bold text-neutral-900 dark:text-neutral-100 whitespace-nowrap">My App</span>
    <% end %>
  <% end %>

  <% sidebar.with_nav_item(label: "Dashboard", href: "/", active: current_page?("/")) do %>
    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path>
    </svg>
  <% end %>

  <% sidebar.with_nav_item(label: "Settings", href: "/settings") do %>
    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"></path>
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
    </svg>
  <% end %>

  <% sidebar.with_footer do %>
    <div class="flex items-center space-x-3 px-3 py-2 mb-2">
      <div class="w-8 h-8 rounded-full bg-neutral-200 dark:bg-neutral-700 flex items-center justify-center flex-shrink-0">
        <svg class="w-5 h-5 text-neutral-600 dark:text-neutral-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
        </svg>
      </div>
      <div class="flex-1 min-w-0">
        <p class="text-sm font-medium text-neutral-900 dark:text-neutral-100 truncate">John Doe</p>
        <p class="text-xs text-neutral-500 dark:text-neutral-400 truncate">john@example.com</p>
      </div>
    </div>

    <%= link_to destroy_session_path, data: { "turbo-method": :delete }, class: "flex items-center space-x-3 px-3 py-2 rounded-lg text-neutral-700 dark:text-neutral-300 hover:bg-neutral-100 dark:hover:bg-neutral-800 transition-colors" do %>
      <svg class="w-5 h-5 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
      </svg>
      <span class="font-medium">Log out</span>
    <% end %>
  <% end %>
<% end %>

<%# Nav item with badge %>
<% sidebar.with_nav_item(label: "Notifications", href: "/notifications", badge_text: "3", badge_color: "red") do %>
  <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"></path>
  </svg>
<% end %>

<%# Nav section divider with heading %>
<% sidebar.with_nav_item(heading: "Settings") %>

<%# Nav section divider without heading %>
<% sidebar.with_nav_item %>
```

### Card Component

```erb
<%# Basic card %>
<%= render ArtisansUi::Card::BasicComponent.new do %>
  <h3 class="text-lg font-medium leading-6 text-neutral-900 dark:text-white">Basic Card</h3>
  <p class="mt-2 text-sm text-neutral-600 dark:text-neutral-400">Simple card with shadow and rounded corners</p>
<% end %>

<%# Card with header %>
<%= render ArtisansUi::Card::WithHeaderComponent.new do |card| %>
  <% card.with_header do %>
    <h3 class="text-lg leading-6 font-medium text-neutral-900 dark:text-white">Card with Header</h3>
    <p class="mt-1 text-sm text-neutral-600 dark:text-neutral-400">Separated by divider</p>
  <% end %>
  <% card.with_body do %>
    <p class="text-neutral-700 dark:text-neutral-300">Main content goes here</p>
  <% end %>
<% end %>

<%# Card with footer %>
<%= render ArtisansUi::Card::WithFooterComponent.new do |card| %>
  <% card.with_body do %>
    <h3 class="text-lg font-medium text-neutral-900 dark:text-white">Card with Footer</h3>
    <p class="mt-2 text-neutral-700 dark:text-neutral-300">Footer section for actions</p>
  <% end %>
  <% card.with_footer do %>
    <a href="#" class="text-sm font-medium text-blue-600 dark:text-blue-400">View details</a>
  <% end %>
<% end %>

<%# Complete card (header + body + footer) %>
<%= render ArtisansUi::Card::CompleteComponent.new do |card| %>
  <% card.with_header do %>
    <h3 class="text-lg leading-6 font-medium text-neutral-900 dark:text-white">Complete Card</h3>
    <p class="mt-1 text-sm text-neutral-600 dark:text-neutral-400">All three sections</p>
  <% end %>
  <% card.with_body do %>
    <p class="text-neutral-700 dark:text-neutral-300">Main content area</p>
  <% end %>
  <% card.with_footer do %>
    <div class="flex justify-between">
      <button class="...">Cancel</button>
      <button class="...">Save</button>
    </div>
  <% end %>
<% end %>

<%# Edge-to-edge on mobile %>
<%= render ArtisansUi::Card::EdgeToEdgeComponent.new do |card| %>
  <% card.with_body do %>
    <h3 class="text-lg font-medium text-neutral-900 dark:text-white">Edge-to-Edge</h3>
    <p class="mt-2 text-neutral-700 dark:text-neutral-300">Full width on mobile, standard on desktop</p>
  <% end %>
<% end %>

<%# Well card %>
<%= render ArtisansUi::Card::WellComponent.new do %>
  <h3 class="text-lg font-medium text-neutral-900 dark:text-white">Well Card</h3>
  <p class="mt-2 text-neutral-700 dark:text-neutral-300">Subtle container with no shadow</p>
<% end %>

<%# Card with image %>
<%= render ArtisansUi::Card::WithImageComponent.new(
  image_url: "https://images.unsplash.com/...",
  image_alt: "Article image",
  badge_text: "Article",
  badge_color: "blue",
  meta_text: "5 min read",
  title: "Card with Featured Image",
  description: "Perfect for blog posts and articles",
  author_name: "John Doe",
  author_image: "https://images.unsplash.com/...",
  author_date: "September 16, 2025"
) %>

<%# Stats card %>
<%= render ArtisansUi::Card::StatsComponent.new(
  label: "Total Revenue",
  value: "$71,897",
  trend: "up",
  trend_value: "12.5%",
  trend_label: "from last month",
  progress_label: "Progress to goal",
  progress_value: 72
) %>
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

### Card Components

- **8 Card Variants** (`ArtisansUi::Card::*`)
  - Basic card with shadow and rounded corners
  - Card with header (separated by divider)
  - Card with footer (actions and links)
  - Complete card (header + body + footer)
  - Edge-to-edge responsive (full width on mobile)
  - Well card (subtle container, no shadow)
  - Card with image (featured image + metadata + author)
  - Stats card (metrics, trends, progress indicators)

### Sidebar Components

- **3 Sidebar Components** (`ArtisansUi::Sidebar::*`)
  - BasicComponent: Full sidebar layout with header, nav, footer slots
  - NavItemComponent: Navigation links with icons, active states, and badges
  - NavSectionComponent: Section dividers with optional headings
  - Responsive mobile slide-out and desktop persistent layouts
  - Configurable breakpoints (`md` or `lg`)
  - Dark mode support throughout
  - **📖 [View Complete Sidebar Documentation](docs/SIDEBAR_COMPONENT.md)**
  - **⚠️ Requires [bundler-bare_symlink setup](docs/SIDEBAR_COMPONENT.md#tailwind-css-4-integration) for Tailwind CSS 4**

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
- [Sidebar Component Guide](docs/SIDEBAR_COMPONENT.md) - Sidebar setup and Tailwind CSS 4 integration
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
