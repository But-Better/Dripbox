# frozen_string_literal: true

class SiteInformationsController < ApplicationController
  def agb
    current_user
  end

  def datenschutz
    current_user
  end

  def about
    current_user
  end
end
