# frozen_string_literal: true

# create resource controller
class CreateResourceController < ApplicationController
  def index
    @resources = Resource.all
    render 'resources/index'
  end
end
