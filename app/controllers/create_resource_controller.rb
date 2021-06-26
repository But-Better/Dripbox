class CreateResourceController < ApplicationController
  def index
    @resources = Resource.all
    render 'resources/index'
  end
end
