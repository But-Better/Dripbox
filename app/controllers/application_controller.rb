# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # https://github.com/pelargir/auto-session-timeout
  auto_session_timeout 1.hour
end
