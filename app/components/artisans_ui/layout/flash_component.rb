# frozen_string_literal: true

module ArtisansUi
  module Layout
    class FlashComponent < ArtisansUi::ApplicationViewComponent
      def initialize(notice: nil, alert: nil, **html_options)
        @notice = notice
        @alert = alert
        @html_options = html_options
      end

      def render?
        @notice.present? || @alert.present?
      end

      private

      attr_reader :notice, :alert, :html_options
    end
  end
end
