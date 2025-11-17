# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Sidebar::NavItemComponent, type: :component do
  describe "rendering" do
    it "renders with required props" do
      render_inline(described_class.new(label: "Dashboard", href: "/"))

      expect(rendered_content).to include("Dashboard")
      expect(rendered_content).to include('href="/"')
    end

    it "renders as a link element" do
      render_inline(described_class.new(label: "Settings", href: "/settings"))

      expect(rendered_content).to match(/<a[^>]*>.*Settings.*<\/a>/)
    end
  end

  describe "active state" do
    it "applies active classes when active is true" do
      render_inline(described_class.new(label: "Dashboard", href: "/", active: true))

      expect(rendered_content).to include("bg-yellow-100")
      expect(rendered_content).to include("text-yellow-700")
      expect(rendered_content).to include("dark:bg-yellow-900/30")
      expect(rendered_content).to include("dark:text-yellow-400")
    end

    it "applies inactive classes when active is false" do
      render_inline(described_class.new(label: "Dashboard", href: "/", active: false))

      expect(rendered_content).to include("text-neutral-700")
      expect(rendered_content).to include("hover:bg-neutral-100")
      expect(rendered_content).to include("dark:text-neutral-100")
    end

    it "defaults to inactive state" do
      render_inline(described_class.new(label: "Dashboard", href: "/"))

      expect(rendered_content).to include("hover:bg-neutral-100")
      expect(rendered_content).not_to include("bg-yellow-100")
    end
  end

  describe "icon support" do
    it "renders icon from block content" do
      render_inline(described_class.new(label: "Dashboard", href: "/")) do
        '<svg class="w-5 h-5"><path d="M3 12l2-2"></path></svg>'.html_safe
      end

      expect(rendered_content).to include("<svg")
      expect(rendered_content).to include("w-5 h-5")
      expect(rendered_content).to include("M3 12l2-2")
    end

    it "wraps icon in flex container" do
      render_inline(described_class.new(label: "Dashboard", href: "/")) do
        '<svg></svg>'.html_safe
      end

      expect(rendered_content).to include("flex items-center justify-center")
    end

    it "renders without icon when no block provided" do
      render_inline(described_class.new(label: "Dashboard", href: "/"))

      expect(rendered_content).not_to include("<svg")
      expect(rendered_content).to include("Dashboard")
    end
  end

  describe "badge support" do
    it "renders badge when badge_text is provided" do
      render_inline(described_class.new(
        label: "Notifications",
        href: "/notifications",
        badge_text: "3"
      ))

      expect(rendered_content).to include("3")
      expect(rendered_content).to include("rounded-full")
    end

    it "renders badge with yellow color by default" do
      render_inline(described_class.new(
        label: "Notifications",
        href: "/notifications",
        badge_text: "5"
      ))

      expect(rendered_content).to include("bg-yellow-500")
      expect(rendered_content).to include("text-white")
    end

    it "renders badge with custom color" do
      render_inline(described_class.new(
        label: "Errors",
        href: "/errors",
        badge_text: "2",
        badge_color: "red"
      ))

      expect(rendered_content).to include("bg-red-500")
      expect(rendered_content).to include("text-white")
    end

    it "supports all badge colors" do
      %w[yellow red green blue neutral].each do |color|
        render_inline(described_class.new(
          label: "Item",
          href: "/item",
          badge_text: "1",
          badge_color: color
        ))

        expect(rendered_content).to include("bg-#{color}-500")
      end
    end

    it "does not render badge when badge_text is nil" do
      render_inline(described_class.new(label: "Dashboard", href: "/"))

      expect(rendered_content).not_to include("rounded-full")
      expect(rendered_content).not_to include("ml-auto")
    end
  end

  describe "HTML options" do
    it "accepts custom id" do
      render_inline(described_class.new(label: "Dashboard", href: "/", id: "nav-dashboard"))

      expect(rendered_content).to include('id="nav-dashboard"')
    end

    it "accepts data attributes" do
      render_inline(described_class.new(
        label: "Dashboard",
        href: "/",
        data: { turbo: "false", test: "value" }
      ))

      expect(rendered_content).to include('data-turbo="false"')
      expect(rendered_content).to include('data-test="value"')
    end

    it "accepts custom classes" do
      render_inline(described_class.new(
        label: "Dashboard",
        href: "/",
        class: "custom-class"
      ))

      expect(rendered_content).to include("custom-class")
    end
  end

  describe "label truncation" do
    it "applies truncate class to label" do
      render_inline(described_class.new(label: "Very Long Navigation Item Label", href: "/"))

      expect(rendered_content).to include("truncate")
      expect(rendered_content).to include("Very Long Navigation Item Label")
    end
  end

  describe "accessibility" do
    it "includes focus outline classes" do
      render_inline(described_class.new(label: "Dashboard", href: "/"))

      expect(rendered_content).to include("focus:outline-hidden")
      expect(rendered_content).to include("focus-visible:bg-neutral-100")
    end

    it "has proper text size for readability" do
      render_inline(described_class.new(label: "Dashboard", href: "/"))

      expect(rendered_content).to include("text-sm")
    end
  end

  describe "dark mode" do
    it "includes dark mode classes" do
      render_inline(described_class.new(label: "Dashboard", href: "/"))

      expect(rendered_content).to include("dark:text-neutral-100")
      expect(rendered_content).to include("dark:hover:bg-neutral-700/50")
    end

    it "includes dark mode classes for active state" do
      render_inline(described_class.new(label: "Dashboard", href: "/", active: true))

      expect(rendered_content).to include("dark:bg-yellow-900/30")
      expect(rendered_content).to include("dark:text-yellow-400")
    end
  end
end
