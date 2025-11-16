# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArtisansUi::Button::LinkComponent, type: :component do
  describe "rendering" do
    it "renders an anchor tag" do
      rendered = render_inline(described_class.new(href: "/dashboard")) do
        "Go to Dashboard"
      end

      expect(rendered.css("a").first.name).to eq("a")
      expect(rendered.css("a").first[:href]).to eq("/dashboard")
      expect(rendered.text).to include("Go to Dashboard")
    end

    it "renders with default neutral variant" do
      rendered = render_inline(described_class.new(href: "/test")) do
        "Test"
      end

      expect(rendered.css("a").first[:class]).to include("bg-neutral-800")
      expect(rendered.css("a").first[:class]).to include("text-white")
    end
  end

  describe "variants" do
    it "applies neutral variant classes" do
      component = described_class.new(href: "/test", variant: :neutral) do
        "Test"
      end
      rendered = render_inline(component)

      expect(rendered.css("a").first[:class]).to include("bg-neutral-800")
      expect(rendered.css("a").first[:class]).to include("text-white")
      expect(rendered.css("a").first[:class]).to include("hover:bg-neutral-700")
    end

    it "applies colored variant classes" do
      component = described_class.new(href: "/test", variant: :colored) do
        "Test"
      end
      rendered = render_inline(component)

      expect(rendered.css("a").first[:class]).to include("bg-blue-600")
      expect(rendered.css("a").first[:class]).to include("text-white")
      expect(rendered.css("a").first[:class]).to include("hover:bg-blue-500")
    end

    it "applies secondary variant classes" do
      component = described_class.new(href: "/test", variant: :secondary) do
        "Test"
      end
      rendered = render_inline(component)

      expect(rendered.css("a").first[:class]).to include("bg-white")
      expect(rendered.css("a").first[:class]).to include("text-neutral-800")
      expect(rendered.css("a").first[:class]).to include("hover:bg-neutral-50")
    end

    it "applies danger variant classes" do
      component = described_class.new(href: "/test", variant: :danger) do
        "Test"
      end
      rendered = render_inline(component)

      expect(rendered.css("a").first[:class]).to include("bg-red-600")
      expect(rendered.css("a").first[:class]).to include("text-white")
      expect(rendered.css("a").first[:class]).to include("hover:bg-red-500")
    end

    it "applies warning variant classes" do
      component = described_class.new(href: "/test", variant: :warning) do
        "Test"
      end
      rendered = render_inline(component)

      expect(rendered.css("a").first[:class]).to include("bg-yellow-500")
      expect(rendered.css("a").first[:class]).to include("text-white")
      expect(rendered.css("a").first[:class]).to include("hover:bg-yellow-600")
    end

    it "allows nil variant for custom styling" do
      component = described_class.new(
        href: "/test",
        variant: nil,
        class: "bg-custom-500"
      ) do
        "Test"
      end
      rendered = render_inline(component)

      expect(rendered.css("a").first[:class]).to include("bg-custom-500")
      expect(rendered.css("a").first[:class]).not_to include("bg-neutral-800")
    end
  end

  describe "sizes" do
    it "applies regular size classes" do
      component = described_class.new(href: "/test", size: :regular) do
        "Test"
      end
      rendered = render_inline(component)

      expect(rendered.css("a").first[:class]).to include("px-3")
      expect(rendered.css("a").first[:class]).to include("py-2")
      expect(rendered.css("a").first[:class]).to include("text-sm")
    end

    it "applies small size classes" do
      component = described_class.new(href: "/test", size: :small) do
        "Test"
      end
      rendered = render_inline(component)

      expect(rendered.css("a").first[:class]).to include("px-3")
      expect(rendered.css("a").first[:class]).to include("py-2")
      expect(rendered.css("a").first[:class]).to include("text-xs")
    end
  end

  describe "icons" do
    let(:test_icon) { '<svg class="w-4 h-4"><path d="test"/></svg>' }

    it "renders with icon on left by default" do
      rendered = render_inline(described_class.new(href: "/test", icon: test_icon)) do
        "Test"
      end

      expect(rendered.css("svg").first).to be_present
      expect(rendered.text.strip).to include("Test")
    end

    it "renders with icon on right" do
      rendered = render_inline(described_class.new(
        href: "/test",
        icon: test_icon,
        icon_position: :right
      )) do
        "Test"
      end

      expect(rendered.css("svg").first).to be_present
      expect(rendered.text.strip).to include("Test")
    end

    it "renders without icon when not provided" do
      rendered = render_inline(described_class.new(href: "/test")) do
        "Test"
      end

      expect(rendered.css("svg")).to be_empty
      expect(rendered.text).to include("Test")
    end
  end

  describe "base classes" do
    it "includes base button classes" do
      component = described_class.new(href: "/test") do
        "Test"
      end
      rendered = render_inline(component)

      expect(rendered.css("a").first[:class]).to include("flex")
      expect(rendered.css("a").first[:class]).to include("items-center")
      expect(rendered.css("a").first[:class]).to include("justify-center")
      expect(rendered.css("a").first[:class]).to include("rounded-lg")
      expect(rendered.css("a").first[:class]).to include("border")
      expect(rendered.css("a").first[:class]).to include("shadow-sm")
    end
  end

  describe "custom classes" do
    it "accepts custom class parameter" do
      component = described_class.new(href: "/test", class: "custom-class") do
        "Test"
      end
      rendered = render_inline(component)

      expect(rendered.css("a").first[:class]).to include("custom-class")
    end

    it "combines variant and custom classes" do
      component = described_class.new(
        href: "/test",
        variant: :warning,
        class: "w-full"
      ) do
        "Test"
      end
      rendered = render_inline(component)

      expect(rendered.css("a").first[:class]).to include("bg-yellow-500")
      expect(rendered.css("a").first[:class]).to include("w-full")
    end
  end

  describe "HTML attributes" do
    it "accepts additional HTML attributes" do
      component = described_class.new(
        href: "/test",
        id: "custom-id",
        data: { controller: "tooltip" },
        target: "_blank"
      ) do
        "Test"
      end
      rendered = render_inline(component)

      expect(rendered.css("a#custom-id")).to be_present
      expect(rendered.css("a").first["data-controller"]).to eq("tooltip")
      expect(rendered.css("a").first[:target]).to eq("_blank")
    end
  end

  describe "parameter validation" do
    it "raises error for invalid variant" do
      expect {
        described_class.new(href: "/test", variant: :invalid) do
          "Test"
        end
      }.to raise_error(ArgumentError, /Invalid variant/)
    end

    it "raises error for invalid size" do
      expect {
        described_class.new(href: "/test", size: :invalid) do
          "Test"
        end
      }.to raise_error(ArgumentError, /Invalid size/)
    end

    it "raises error for invalid icon_position" do
      expect {
        described_class.new(
          href: "/test",
          icon: "<svg></svg>",
          icon_position: :invalid
        ) do
          "Test"
        end
      }.to raise_error(ArgumentError, /Invalid icon_position/)
    end

    it "does not raise error for valid variant" do
      expect {
        described_class.new(href: "/test", variant: :warning) do
          "Test"
        end
      }.not_to raise_error
    end
  end

  describe "dark mode support" do
    it "includes dark mode classes" do
      component = described_class.new(href: "/test", variant: :neutral) do
        "Test"
      end
      rendered = render_inline(component)

      expect(rendered.css("a").first[:class]).to include("dark:bg-white")
      expect(rendered.css("a").first[:class]).to include("dark:text-neutral-800")
    end
  end
end
