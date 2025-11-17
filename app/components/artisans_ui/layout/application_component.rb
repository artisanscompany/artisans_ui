# frozen_string_literal: true

module ArtisansUi
  module Layout
    class ApplicationComponent < ArtisansUi::ApplicationViewComponent
      renders_one :head
      renders_one :sidebar, ->(**sidebar_options, &block) do
        Sidebar::BasicComponent.new(**sidebar_options, &block)
      end

      def initialize(
        page_title: "Application",
        google_analytics_id: nil,
        body_class: "h-screen overflow-hidden bg-gray-50",
        **html_options
      )
        @page_title = page_title
        @google_analytics_id = google_analytics_id
        @body_class = body_class
        @html_options = html_options
      end

      def before_render
        # Ensure sidebar is rendered if not explicitly provided
        sidebar(**default_sidebar_options) unless sidebar?
      end

      private

      attr_reader :page_title, :google_analytics_id, :body_class, :html_options

      def default_sidebar_options
        { breakpoint: "md" }
      end

      def render_google_analytics?
        google_analytics_id.present?
      end
    end
  end
end
