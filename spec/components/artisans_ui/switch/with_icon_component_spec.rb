require "rails_helper"

RSpec.describe ArtisansUi::Switch::WithIconComponent, type: :component do
  it "renders switch with icons" do
    render_inline(described_class.new)

    expect(rendered_content).to include('type="checkbox"')
    expect(rendered_content).to include('sr-only peer')
    expect(rendered_content).to include('peer-checked:bg-[#404040]')
    expect(rendered_content).to include('peer-checked:translate-x-4')
  end

  it "accepts custom name and id" do
    render_inline(described_class.new(name: "custom_switch", id: "my_switch"))

    expect(rendered_content).to include('name="custom_switch"')
    expect(rendered_content).to include('id="my_switch"')
  end

  it "renders checked state" do
    render_inline(described_class.new(checked: true))

    expect(rendered_content).to include('checked')
  end

  it "includes X icon with correct structure" do
    render_inline(described_class.new)

    expect(rendered_content).to include('xmlns="http://www.w3.org/2000/svg"')
    expect(rendered_content).to include('size-4 text-neutral-400')
    expect(rendered_content).to include('group-has-[:checked]:opacity-0')
    expect(rendered_content).to include('stroke-width="2"')
    expect(rendered_content).to include('x1="7"')
    expect(rendered_content).to include('y1="7"')
    expect(rendered_content).to include('x2="13"')
    expect(rendered_content).to include('y2="13"')
  end

  it "includes X icon lines" do
    render_inline(described_class.new)

    # First line: 7,7 to 13,13
    expect(rendered_content).to include('x1="7" y1="7" x2="13" y2="13"')
    # Second line: 7,13 to 13,7
    expect(rendered_content).to include('x1="7" y1="13" x2="13" y2="7"')
  end

  it "includes checkmark icon with correct structure" do
    render_inline(described_class.new)

    expect(rendered_content).to include('size-4 text-neutral-700')
    expect(rendered_content).to include('absolute opacity-0')
    expect(rendered_content).to include('group-has-[:checked]:opacity-100')
    expect(rendered_content).to include('dark:text-neutral-200')
  end

  it "includes checkmark polyline" do
    render_inline(described_class.new)

    expect(rendered_content).to include('points="6.5 10.5 8.75 13 13.5 7"')
  end

  it "includes transition classes on icons" do
    render_inline(described_class.new)

    expect(rendered_content).to include('transition-opacity duration-150 ease-in-out')
  end

  it "includes group class on label" do
    render_inline(described_class.new)

    expect(rendered_content).to include('group flex items-center cursor-pointer')
  end

  it "includes all background classes" do
    render_inline(described_class.new)

    expect(rendered_content).to include('w-10 h-6 bg-neutral-200')
    expect(rendered_content).to include('rounded-full')
    expect(rendered_content).to include('transition-all duration-150 ease-in-out')
    expect(rendered_content).to include('group-hover:bg-[#dcdcdb]')
    expect(rendered_content).to include('peer-checked:group-hover:bg-neutral-600')
  end

  it "includes toggle element classes" do
    render_inline(described_class.new)

    expect(rendered_content).to include('absolute top-[3px] left-[3px]')
    expect(rendered_content).to include('w-[18px] h-[18px]')
    expect(rendered_content).to include('bg-white rounded-full shadow-sm')
    expect(rendered_content).to include('flex items-center justify-center')
  end

  it "includes dark mode classes" do
    render_inline(described_class.new)

    expect(rendered_content).to include('dark:bg-neutral-700')
    expect(rendered_content).to include('dark:peer-checked:bg-neutral-50')
    expect(rendered_content).to include('dark:bg-neutral-200')
    expect(rendered_content).to include('dark:peer-checked:bg-neutral-800')
  end

  it "includes focus-visible classes" do
    render_inline(described_class.new)

    expect(rendered_content).to include('peer-focus-visible:outline-2')
    expect(rendered_content).to include('peer-focus-visible:outline-offset-2')
    expect(rendered_content).to include('peer-focus-visible:outline-neutral-600')
  end

  it "defaults to switch name when id not provided" do
    render_inline(described_class.new)

    expect(rendered_content).to include('name="switch"')
    expect(rendered_content).to include('id="switch"')
  end

  it "passes through html_options to label" do
    render_inline(described_class.new(data: { controller: "test" }))

    expect(rendered_content).to include('data-controller="test"')
  end
end
