# frozen_string_literal: true

module ArtisansUi
  module Sidebar
    # Renders a user profile button with dropdown menu
    #
    # @example Basic usage
    #   <%= render ArtisansUi::Sidebar::UserProfileButtonComponent.new(
    #     user: current_user,
    #     logout_path: destroy_user_session_path
    #   ) %>
    #
    # @param user [User] Current user object (must respond to :name and :email)
    # @param account [Account] Current account/team object
    # @param logout_path [String] Path to logout route
    # @param profile_path [String] Optional path to profile edit page
    # @param account_avatar_url [String] Optional custom avatar URL for account
    # @param html_options [Hash] Additional HTML attributes
    class UserProfileButtonComponent < ApplicationViewComponent
      def initialize(user:, account:, logout_path:, profile_path: nil, password_path: nil, accounts_path: nil, account_avatar_url: nil, **html_options)
        @user = user
        @account = account
        @logout_path = logout_path
        @profile_path = profile_path
        @password_path = password_path
        @accounts_path = accounts_path
        @account_avatar_url = account_avatar_url
        @html_options = html_options
      end

      private

      def display_name
        @account&.name || @user.name
      end

      def avatar_url
        @account_avatar_url
      end

      def user_initials
        name = @account&.name || @user.name
        name.split.map(&:first).take(2).join.upcase
      end
    end
  end
end
