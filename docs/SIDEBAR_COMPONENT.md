# Sidebar Component

A responsive sidebar component for Rails applications built with ViewComponent and Tailwind CSS 4.

## Overview

The Sidebar component provides a mobile-responsive navigation layout with:
- Slide-in sidebar on mobile devices
- Fixed sidebar on desktop
- Configurable responsive breakpoint (`md` or `lg`)
- Header, navigation, and footer sections
- Backdrop overlay for mobile
- Stimulus controller for interactivity

## Components

### BasicComponent

The main sidebar component that creates a responsive layout with sidebar navigation and main content area.

**File:** `app/components/artisans_ui/sidebar/basic_component.rb`

#### Parameters

- `breakpoint` (String, default: `"md"`): Responsive breakpoint for sidebar visibility
  - `"md"`: Desktop sidebar visible at ≥768px
  - `"lg"`: Desktop sidebar visible at ≥1024px
- `storage_key` (String, default: `"sidebarOpen"`): LocalStorage key for persisting sidebar state
- `**html_options`: Additional HTML attributes for the wrapper div

#### Slots

- `header`: Optional header content (logo, title, etc.)
- `nav_items`: Navigation menu items (required, multiple)
- `footer`: Optional footer content (user profile, logout, etc.)
- `content`: Main page content (required)

#### Usage

```erb
<%= render ArtisansUi::Sidebar::BasicComponent.new(breakpoint: "md") do |sidebar| %>
  <%# Header %>
  <% sidebar.with_header do %>
    <%= link_to root_path, class: "flex items-center space-x-2" do %>
      <%= image_tag "logo.png", class: "h-8 w-8" %>
      <span class="text-lg font-bold">My App</span>
    <% end %>
  <% end %>

  <%# Navigation Items %>
  <% sidebar.with_nav_item(
    label: "Dashboard",
    href: dashboard_path,
    active: current_page?(dashboard_path)
  ) do %>
    <svg class="w-5 h-5"><!-- icon --></svg>
  <% end %>

  <%# Footer %>
  <% sidebar.with_footer do %>
    <div class="flex items-center space-x-3">
      <!-- User profile -->
    </div>
  <% end %>

  <%# Main Content %>
  <%= yield %>
<% end %>
```

### NavItemComponent

Navigation item for the sidebar menu.

**File:** `app/components/artisans_ui/sidebar/nav_item_component.rb`

#### Parameters

- `label` (String, optional): Link text
- `href` (String, optional): Link URL
- `heading` (String, optional): Section heading text
- `active` (Boolean, default: `false`): Whether item is currently active
- `**html_options`: Additional HTML attributes

#### Usage

**As a link:**
```erb
<% sidebar.with_nav_item(
  label: "Dashboard",
  href: dashboard_path,
  active: current_page?(dashboard_path)
) do %>
  <svg class="w-5 h-5"><!-- icon --></svg>
<% end %>
```

**As a section heading:**
```erb
<% sidebar.with_nav_item(heading: "Settings") %>
```

### NavSectionComponent

Container for grouping related navigation items with an optional heading.

**File:** `app/components/artisans_ui/sidebar/nav_section_component.rb`

#### Parameters

- `heading` (String, optional): Section heading text
- `**html_options`: Additional HTML attributes

#### Usage

```erb
<% sidebar.with_nav_section(heading: "Settings") do |section| %>
  <% section.with_nav_item(label: "Profile", href: profile_path) %>
  <% section.with_nav_item(label: "Account", href: account_path) %>
<% end %>
```

## Stimulus Controller

The sidebar uses a Stimulus controller for mobile interactions.

**File:** `app/javascript/artisans_ui/controllers/sidebar_controller.js`

### Targets

- `backdrop`: Overlay that appears behind mobile sidebar
- `panel`: The sidebar panel itself

### Actions

- `toggle()`: Toggle sidebar open/close on mobile
- `open()`: Open sidebar on mobile
- `close()`: Close sidebar on mobile

### Usage in HTML

The component automatically sets up the necessary data attributes. Manual usage:

```erb
<div data-controller="sidebar">
  <div data-sidebar-target="backdrop" data-action="click->sidebar#close"></div>
  <div data-sidebar-target="panel"></div>
  <button data-action="click->sidebar#toggle">Toggle</button>
</div>
```

## Tailwind CSS 4 Integration

**IMPORTANT:** This component requires special setup for Tailwind CSS 4 to prevent class purging.

### The Problem

The component uses ERB ternary operators to conditionally apply responsive classes:

```erb
<%= breakpoint == 'lg' ? 'lg:translate-x-0' : 'md:translate-x-0' %>
```

This dynamic class generation prevents Tailwind's static analysis from detecting these classes, causing them to be purged from the final CSS build.

### The Solution

Use the `bundler-bare_symlink` plugin to create stable symlinks to gems, allowing Tailwind to scan them.

#### Step 1: Add bundler-bare_symlink

Add to your `Gemfile` (at the top, before `source`):

```ruby
plugin "bundler-bare_symlink"

source "https://rubygems.org"
# ... rest of Gemfile
```

#### Step 2: Install the plugin

```bash
bundle install
```

This creates `.bundle/gems/artisans_ui` symlink pointing to the gem location.

#### Step 3: Configure Tailwind CSS 4

Add a `@source` directive to your `app/assets/tailwind/application.css`:

```css
@import "tailwindcss";

/* Scan ArtisansUI ViewComponent gem for Tailwind classes */
@source "../../../.bundle/gems/artisans_ui/app/components/**/*.{rb,erb}";

/* Your custom styles */
```

#### Step 4: Verify

The symlink should be version-agnostic:
- **Before:** `.bundle/ruby/3.4.0/gems/artisans_ui-0.1.0/`
- **After:** `.bundle/gems/artisans_ui/` (symlink pointing to current version)

## Complete Integration Example

### 1. Gemfile

```ruby
plugin "bundler-bare_symlink"

source "https://rubygems.org"

gem "artisans_ui", path: "/path/to/artisans_ui"
# OR
gem "artisans_ui", github: "yourusername/artisans_ui"
```

### 2. Tailwind Configuration

```css
/* app/assets/tailwind/application.css */
@import "tailwindcss";

@source "../../../.bundle/gems/artisans_ui/app/components/**/*.{rb,erb}";
```

### 3. Layout File

```erb
<!-- app/views/layouts/application.html.erb -->
<!DOCTYPE html>
<html>
  <head>
    <title>My App</title>
    <%= stylesheet_link_tag :app, "data-turbo-track": "reload" %>
    <%= javascript_importmap_tags %>
  </head>

  <body class="h-screen overflow-hidden bg-gray-50">
    <%= render ArtisansUi::Sidebar::BasicComponent.new(breakpoint: "md") do |sidebar| %>
      <% sidebar.with_header do %>
        <!-- Header content -->
      <% end %>

      <% sidebar.with_nav_item(label: "Home", href: root_path, active: true) do %>
        <!-- Icon -->
      <% end %>

      <% sidebar.with_footer do %>
        <!-- Footer content -->
      <% end %>

      <!-- Main content -->
      <%= yield %>
    <% end %>
  </body>
</html>
```

## Styling Customization

The component uses Tailwind CSS utility classes. Customize by:

1. **Override default styles:** Pass custom classes via `html_options`
2. **Modify component templates:** Edit `.html.erb` files in the gem
3. **Extend with custom CSS:** Add styles to your application CSS

### Common Customizations

**Change sidebar width:**
```erb
<%= render ArtisansUi::Sidebar::BasicComponent.new(
  breakpoint: "md",
  class: "w-72" # Default is w-64
) do |sidebar| %>
```

**Dark mode colors:**
The component includes dark mode support via `dark:` variants. Customize by editing the component templates.

**Custom animations:**
Modify transition durations in the component template:
```erb
<!-- Change from motion-safe:duration-300 to motion-safe:duration-500 -->
```

## Browser Support

- Modern browsers with CSS Grid and Flexbox support
- Dark mode support (prefers-color-scheme)
- Reduced motion support (prefers-reduced-motion)

## Accessibility

- Semantic HTML structure
- Keyboard navigation support
- ARIA attributes for mobile toggle
- Focus management
- High contrast mode support

## Testing

RSpec tests are available in `spec/components/artisans_ui/sidebar/`.

Run tests:
```bash
bundle exec rspec spec/components/artisans_ui/sidebar/
```

## Troubleshooting

### Sidebar not visible on desktop

**Problem:** Responsive classes being purged by Tailwind CSS 4.

**Solution:** Ensure `bundler-bare_symlink` plugin is installed and `@source` directive is configured correctly.

**Verification:**
```bash
# Check symlink exists
ls -la .bundle/gems/artisans_ui

# Check Tailwind scans the gem
# Output CSS should be >100KB
ls -lh public/assets/application*.css
```

### Sidebar doesn't open on mobile

**Problem:** Stimulus controller not connected.

**Solution:**
1. Verify JavaScript importmap includes Stimulus
2. Check browser console for errors
3. Ensure `data-controller="sidebar"` attribute is present

### Dark mode not working

**Problem:** Dark mode class not applied to `<html>` or `<body>` tag.

**Solution:** Add dark mode toggle to your application:
```javascript
// Toggle dark mode
document.documentElement.classList.toggle('dark')
```

## Related Components

- **Button Component:** For action buttons in sidebar
- **Avatar Component:** For user profile in footer
- **Badge Component:** For notification counts on nav items

## Changelog

### v0.1.0 (2025-11-17)
- Initial release
- BasicComponent with responsive layout
- NavItemComponent for menu items
- NavSectionComponent for grouping
- Stimulus controller for mobile interactions
- Tailwind CSS 4 support with bundler-bare_symlink

## License

MIT License
