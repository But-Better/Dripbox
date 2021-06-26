# frozen_string_literal: true

module ResourcesHelper
  def any_error
    if @user.errors.any?
      @user.errors.each do |error|
        content_tag(:p, error.full_messages)
      end
    end
  end
end
