# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ArtisansUi::AnimatedNumber Components", type: :component do
  describe ArtisansUi::AnimatedNumber::BasicComponent do
    it "renders with required data attributes" do
      render_inline(described_class.new(start_value: 0, end_value: 1250, duration: 2000))

      expect(rendered_content).to include('data-controller="animated-number"')
      expect(rendered_content).to include('data-animated-number-start-value="0"')
      expect(rendered_content).to include('data-animated-number-end-value="1250"')
      expect(rendered_content).to include('data-animated-number-duration-value="2000"')
    end

    it "renders with label" do
      render_inline(described_class.new(start_value: 0, end_value: 100, label: "Users registered"))

      expect(rendered_content).to include("Users registered")
      expect(rendered_content).to include("text-sm text-neutral-600 dark:text-neutral-400")
    end

    it "renders without label" do
      render_inline(described_class.new(start_value: 0, end_value: 100))

      expect(rendered_content).not_to include("text-sm text-neutral-600")
    end

    it "applies correct styling classes" do
      render_inline(described_class.new(start_value: 0, end_value: 100))

      expect(rendered_content).to include("text-4xl font-bold text-neutral-800 dark:text-neutral-200")
      expect(rendered_content).to include("text-center")
    end

    it "accepts custom HTML options" do
      render_inline(described_class.new(start_value: 0, end_value: 100, id: "custom-counter"))

      expect(rendered_content).to include('id="custom-counter"')
    end
  end

  describe ArtisansUi::AnimatedNumber::CurrencyComponent do
    it "renders with currency format options" do
      render_inline(described_class.new(start_value: 50, end_value: 850.99, duration: 2500))

      expect(rendered_content).to include('data-controller="animated-number"')
      expect(rendered_content).to include('data-animated-number-format-options-value=')
      expect(rendered_content).to include('"style":"currency"')
      expect(rendered_content).to include('"currency":"USD"')
      expect(rendered_content).to include('"minimumFractionDigits":2')
    end

    it "renders with suffix" do
      render_inline(described_class.new(
        start_value: 50,
        end_value: 850.99,
        suffix: " / month",
        label: "Monthly revenue"
      ))

      expect(rendered_content).to include('data-animated-number-suffix-value=" / month"')
      expect(rendered_content).to include("Monthly revenue")
    end

    it "renders without suffix" do
      render_inline(described_class.new(start_value: 0, end_value: 100))

      expect(rendered_content).not_to include("data-animated-number-suffix-value")
    end
  end

  describe ArtisansUi::AnimatedNumber::CompactComponent do
    it "renders with compact notation format" do
      render_inline(described_class.new(start_value: 0, end_value: 125600, duration: 2000))

      expect(rendered_content).to include('data-controller="animated-number"')
      expect(rendered_content).to include('data-animated-number-format-options-value=')
      expect(rendered_content).to include('"notation":"compact"')
      expect(rendered_content).to include('"compactDisplay":"short"')
    end

    it "renders with label" do
      render_inline(described_class.new(start_value: 0, end_value: 125600, label: "Total downloads"))

      expect(rendered_content).to include("Total downloads")
    end
  end

  describe ArtisansUi::AnimatedNumber::PercentageComponent do
    it "renders with decimal format options" do
      render_inline(described_class.new(start_value: 0, end_value: 147.5, duration: 2800))

      expect(rendered_content).to include('data-controller="animated-number"')
      expect(rendered_content).to include('data-animated-number-format-options-value=')
      expect(rendered_content).to include('"minimumFractionDigits":1')
      expect(rendered_content).to include('"maximumFractionDigits":1')
    end

    it "renders with prefix and suffix" do
      render_inline(described_class.new(
        start_value: 0,
        end_value: 147.5,
        prefix: "+",
        suffix: "%",
        label: "Year-over-year growth"
      ))

      expect(rendered_content).to include('data-animated-number-prefix-value="+"')
      expect(rendered_content).to include('data-animated-number-suffix-value="%"')
      expect(rendered_content).to include("Year-over-year growth")
    end

    it "renders without prefix" do
      render_inline(described_class.new(start_value: 0, end_value: 95.8, suffix: "%"))

      expect(rendered_content).not_to include("data-animated-number-prefix-value")
      expect(rendered_content).to include('data-animated-number-suffix-value="%"')
    end
  end

  describe ArtisansUi::AnimatedNumber::ContinuousComponent do
    it "renders with continuous animation enabled" do
      render_inline(described_class.new(
        start_value: 0,
        end_value: 100,
        duration: 1500,
        continuous: true,
        label: "Continuous Animation"
      ))

      expect(rendered_content).to include('data-animated-number-continuous-value="true"')
      expect(rendered_content).to include("Continuous Animation")
    end

    it "renders with continuous animation disabled" do
      render_inline(described_class.new(
        start_value: 0,
        end_value: 100,
        continuous: false,
        label: "Discrete Animation"
      ))

      expect(rendered_content).to include('data-animated-number-continuous-value="false"')
      expect(rendered_content).to include("Discrete Animation")
    end

    it "applies card styling" do
      render_inline(described_class.new(start_value: 0, end_value: 100))

      expect(rendered_content).to include("bg-neutral-50 dark:bg-neutral-800/50")
      expect(rendered_content).to include("rounded-lg")
      expect(rendered_content).to include("border border-black/5 dark:border-white/10")
    end
  end

  describe ArtisansUi::AnimatedNumber::CustomEasingComponent do
    it "renders with custom easing values" do
      render_inline(described_class.new(
        start_value: 0,
        end_value: 1000,
        duration: 2000,
        spin_easing: "linear",
        transform_easing: "linear"
      ))

      expect(rendered_content).to include('data-animated-number-spin-easing-value="linear"')
      expect(rendered_content).to include('data-animated-number-transform-easing-value="linear"')
    end

    it "renders with cubic-bezier easing" do
      render_inline(described_class.new(
        start_value: 0,
        end_value: 1000,
        spin_easing: "cubic-bezier(0.68, -0.55, 0.265, 1.55)",
        transform_easing: "cubic-bezier(0.68, -0.55, 0.265, 1.55)",
        label: "Bounce"
      ))

      expect(rendered_content).to include('cubic-bezier(0.68, -0.55, 0.265, 1.55)')
      expect(rendered_content).to include("Bounce")
    end

    it "renders with viewport trigger" do
      render_inline(described_class.new(
        start_value: 0,
        end_value: 1000,
        trigger: "viewport"
      ))

      expect(rendered_content).to include('data-animated-number-trigger-value="viewport"')
    end

    it "includes click action for trigger animation" do
      render_inline(described_class.new(start_value: 0, end_value: 1000))

      expect(rendered_content).to include('data-action="click-&gt;animated-number#triggerAnimation"')
    end

    it "renders with label and description" do
      render_inline(described_class.new(
        start_value: 0,
        end_value: 1000,
        label: "Linear",
        description: "Constant speed"
      ))

      expect(rendered_content).to include("Linear")
      expect(rendered_content).to include("Constant speed")
    end
  end

  describe ArtisansUi::AnimatedNumber::TriggerOnScrollComponent do
    it "renders with load trigger" do
      render_inline(described_class.new(
        start_value: 0,
        end_value: 100000,
        duration: 3500,
        trigger: "load",
        suffix: "+"
      ))

      expect(rendered_content).to include('data-animated-number-trigger-value="load"')
      expect(rendered_content).to include('data-animated-number-suffix-value="+"')
    end

    it "renders with label and hint" do
      render_inline(described_class.new(
        start_value: 0,
        end_value: 100000,
        label: "Lines of code",
        hint: "Press \"Refresh\" button to trigger animation"
      ))

      expect(rendered_content).to include("Lines of code")
      expect(rendered_content).to include('Press "Refresh" button to trigger animation')
    end

    it "applies larger text styling" do
      render_inline(described_class.new(start_value: 0, end_value: 100))

      expect(rendered_content).to include("text-5xl font-bold")
    end
  end

  describe ArtisansUi::AnimatedNumber::CountdownComponent do
    it "renders with countdown configuration" do
      render_inline(described_class.new(
        start_value: 10,
        end_value: 0,
        duration: 500,
        trend: -1,
        suffix: "s"
      ))

      expect(rendered_content).to include('data-animated-number-start-value="10"')
      expect(rendered_content).to include('data-animated-number-end-value="0"')
      expect(rendered_content).to include('data-animated-number-trend-value="-1"')
      expect(rendered_content).to include('data-animated-number-suffix-value="s"')
    end

    it "renders with realtime updates" do
      render_inline(described_class.new(
        start_value: 10,
        end_value: 0,
        update_interval: 1000
      ))

      expect(rendered_content).to include('data-animated-number-realtime-value="true"')
      expect(rendered_content).to include('data-animated-number-update-interval-value="1000"')
    end

    it "renders with minimum integer digits format" do
      render_inline(described_class.new(start_value: 10, end_value: 0))

      expect(rendered_content).to include('data-animated-number-format-options-value=')
      expect(rendered_content).to include('"minimumIntegerDigits":2')
    end

    it "renders with label" do
      render_inline(described_class.new(
        start_value: 10,
        end_value: 0,
        label: "Countdown timer"
      ))

      expect(rendered_content).to include("Countdown timer")
    end
  end
end
