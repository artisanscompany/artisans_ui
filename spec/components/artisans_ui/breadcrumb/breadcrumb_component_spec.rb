# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ArtisansUi::Breadcrumb Components", type: :component do
  describe ArtisansUi::Breadcrumb::BasicComponent do
    let(:items) do
      [
        { label: "Home", href: "/" },
        { label: "Products", href: "/products" },
        { label: "Electronics", href: "/products/electronics" },
        { label: "Headphones" }
      ]
    end

    it "renders breadcrumb navigation" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include('aria-label="Breadcrumb"')
      expect(rendered_content).to include("Home")
      expect(rendered_content).to include("Products")
      expect(rendered_content).to include("Electronics")
      expect(rendered_content).to include("Headphones")
    end

    it "renders links for non-current items" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include('href="/"')
      expect(rendered_content).to include('href="/products"')
      expect(rendered_content).to include('href="/products/electronics"')
    end

    it "renders current page without link" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include('aria-current="page"')
      expect(rendered_content).to include("font-medium")
    end

    it "renders slash separators" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include("text-neutral-400 dark:text-neutral-600")
      expect(rendered_content).to include("/")
    end

    it "applies hover styles to links" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include("hover:text-neutral-700")
      expect(rendered_content).to include("dark:hover:text-neutral-200")
    end

    it "includes overflow handling" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include("overflow-x-auto")
      expect(rendered_content).to include("whitespace-nowrap")
    end

    it "renders with custom HTML options" do
      render_inline(described_class.new(items: items, id: "custom-breadcrumb"))

      expect(rendered_content).to include('id="custom-breadcrumb"')
    end
  end

  describe ArtisansUi::Breadcrumb::WithIconsComponent do
    let(:items) do
      [
        { label: "Home", href: "/", home_icon: true },
        { label: "Dashboard", href: "/dashboard" },
        { label: "Projects", href: "/projects" },
        { label: "Project Alpha" }
      ]
    end

    it "renders breadcrumb navigation" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include('aria-label="Breadcrumb"')
      expect(rendered_content).to include("Dashboard")
      expect(rendered_content).to include("Projects")
      expect(rendered_content).to include("Project Alpha")
    end

    it "renders home icon for first item" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include('<svg')
      expect(rendered_content).to include('class="size-4 shrink-0"')
      expect(rendered_content).to include('viewBox="0 0 18 18"')
    end

    it "renders screen reader text for home icon" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include('class="sr-only"')
      expect(rendered_content).to include("Home")
    end

    it "renders chevron separators" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include('viewBox="0 0 20 20"')
      expect(rendered_content).to include('fill="currentColor"')
    end

    it "applies hover background to links" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include("hover:bg-neutral-100")
      expect(rendered_content).to include("dark:hover:bg-neutral-800")
    end

    it "renders current page with correct styling" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include('aria-current="page"')
      expect(rendered_content).to include("font-medium")
    end

    it "includes padding and rounded corners on interactive elements" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include("p-1.5")
      expect(rendered_content).to include("rounded")
    end
  end

  describe ArtisansUi::Breadcrumb::WithBackgroundComponent do
    let(:items) do
      [
        { label: "Home", href: "/" },
        { label: "Documentation", href: "/docs" },
        { label: "Components", href: "/docs/components" },
        { label: "Breadcrumb" }
      ]
    end

    it "renders breadcrumb navigation" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include('aria-label="Breadcrumb"')
      expect(rendered_content).to include("Home")
      expect(rendered_content).to include("Documentation")
      expect(rendered_content).to include("Components")
      expect(rendered_content).to include("Breadcrumb")
    end

    it "applies background styling" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include("bg-neutral-50")
      expect(rendered_content).to include("dark:bg-neutral-900")
    end

    it "applies padding and rounded corners to container" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include("px-4")
      expect(rendered_content).to include("py-2")
      expect(rendered_content).to include("rounded-lg")
    end

    it "renders chevron separators" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include('viewBox="0 0 20 20"')
      expect(rendered_content).to include('fill="currentColor"')
    end

    it "applies medium font weight to links" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include("font-medium")
    end

    it "applies semibold font weight to current page" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include("font-semibold")
      expect(rendered_content).to include('aria-current="page"')
    end

    it "includes overflow handling" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include("overflow-x-auto")
      expect(rendered_content).to include("whitespace-nowrap")
    end
  end

  describe ArtisansUi::Breadcrumb::WithTruncationComponent do
    let(:items) do
      [
        { label: "Home", href: "/" },
        { label: "...", collapsed: true },
        { label: "Category", href: "/category" },
        { label: "Subcategory", href: "/category/subcategory" },
        { label: "Very Long Product Name That Might Need Truncation" }
      ]
    end

    it "renders breadcrumb navigation" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include('aria-label="Breadcrumb"')
      expect(rendered_content).to include("Home")
      expect(rendered_content).to include("Category")
      expect(rendered_content).to include("Subcategory")
    end

    it "renders collapsed items as buttons" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include('<button')
      expect(rendered_content).to include('type="button"')
      expect(rendered_content).to include("...")
    end

    it "renders slash separators" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include("text-neutral-400 dark:text-neutral-600")
      expect(rendered_content).to include("/")
    end

    it "applies truncation to current page" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include("truncate")
      expect(rendered_content).to include('aria-current="page"')
    end

    it "includes title attribute for truncated items" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include('title="Very Long Product Name That Might Need Truncation"')
    end

    it "renders links for non-current, non-collapsed items" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include('href="/"')
      expect(rendered_content).to include('href="/category"')
      expect(rendered_content).to include('href="/category/subcategory"')
    end

    it "applies hover styles" do
      render_inline(described_class.new(items: items))

      expect(rendered_content).to include("hover:text-neutral-700")
      expect(rendered_content).to include("dark:hover:text-neutral-200")
    end

    it "supports custom max width" do
      custom_items = [
        { label: "Home", href: "/" },
        { label: "Long Name", max_width: "150px" }
      ]

      render_inline(described_class.new(items: custom_items))

      expect(rendered_content).to include("truncate")
      expect(rendered_content).to include('title="Long Name"')
    end
  end
end
