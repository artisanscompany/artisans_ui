# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Sidebar::BasicComponent, type: :component do
  describe "rendering" do
    it "renders with default options" do
      render_inline(described_class.new)

      expect(rendered_content).to include("data-controller=\"sidebar\"")
      expect(rendered_content).to include("flex h-full w-full relative")
      expect(rendered_content).to include("md:hidden")
      expect(rendered_content).to include("md:translate-x-0")
    end

    it "renders with custom breakpoint" do
      render_inline(described_class.new(breakpoint: "lg"))

      expect(rendered_content).to include("lg:hidden")
      expect(rendered_content).to include("lg:translate-x-0")
      expect(rendered_content).not_to include("md:hidden")
    end

    it "renders with custom storage key" do
      render_inline(described_class.new(storage_key: "customKey"))

      expect(rendered_content).to include('data-sidebar-storage-key-value="customKey"')
    end

    it "accepts custom HTML options" do
      render_inline(described_class.new(id: "my-sidebar", data: { test: "value" }))

      expect(rendered_content).to include('id="my-sidebar"')
      expect(rendered_content).to include('data-test="value"')
    end
  end

  describe "slots" do
    it "renders header slot" do
      render_inline(described_class.new) do |sidebar|
        sidebar.with_header { "My App Logo" }
      end

      expect(rendered_content).to include("My App Logo")
    end

    it "renders footer slot" do
      render_inline(described_class.new) do |sidebar|
        sidebar.with_footer { "User Info" }
      end

      expect(rendered_content).to include("User Info")
    end

    it "renders nav_items" do
      render_inline(described_class.new) do |sidebar|
        sidebar.with_nav_item(label: "Dashboard", href: "/")
        sidebar.with_nav_item(label: "Settings", href: "/settings")
      end

      expect(rendered_content).to include("Dashboard")
      expect(rendered_content).to include("Settings")
    end

    it "renders nav_section" do
      render_inline(described_class.new) do |sidebar|
        sidebar.with_nav_item(heading: "Main Menu")
      end

      expect(rendered_content).to include("Main Menu")
    end
  end

  describe "structure" do
    it "includes mobile sidebar backdrop" do
      render_inline(described_class.new)

      expect(rendered_content).to include("data-sidebar-target=\"backdrop\"")
      expect(rendered_content).to include("md:hidden")
    end

    it "includes sidebar panel" do
      render_inline(described_class.new)

      expect(rendered_content).to include("data-sidebar-target=\"panel\"")
      expect(rendered_content).to include("w-64")
      expect(rendered_content).to include("bg-neutral-50")
    end

    it "includes mobile header with toggle button" do
      render_inline(described_class.new)

      expect(rendered_content).to include("click->sidebar#toggle")
      expect(rendered_content).to include("md:hidden")
    end

    it "includes main content area" do
      render_inline(described_class.new) { "Main Content" }

      expect(rendered_content).to include("Main Content")
      expect(rendered_content).to include("flex-1")
      expect(rendered_content).to include("overflow-y-auto")
    end
  end

  describe "responsive behavior" do
    it "hides sidebar on mobile by default" do
      render_inline(described_class.new)

      expect(rendered_content).to include("-translate-x-full")
    end

    it "shows sidebar on desktop" do
      render_inline(described_class.new)

      expect(rendered_content).to include("md:translate-x-0")
    end
  end

  describe "accessibility" do
    it "includes close button with proper SVG for mobile" do
      render_inline(described_class.new) do |sidebar|
        sidebar.with_header { "Logo" }
      end

      expect(rendered_content).to include("click->sidebar#close")
      expect(rendered_content).to include("M6 18L18 6M6 6l12 12")
    end

    it "includes hamburger menu icon for mobile" do
      render_inline(described_class.new)

      expect(rendered_content).to include("M4 6h16M4 12h16M4 18h16")
    end
  end

  describe "dark mode support" do
    it "includes dark mode classes" do
      render_inline(described_class.new)

      expect(rendered_content).to include("dark:bg-neutral-900")
      expect(rendered_content).to include("dark:border-neutral-800")
    end
  end
end
