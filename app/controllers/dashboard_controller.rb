# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    @files = UserResource.all
    @categories = Tag.all
    return unless params.key?('id')

    @called_file = UserResource.find params[:id]
    @user_name = @called_file.user_id
    # @called_file_cats = Category.where({ id: FileResourceCategoryRelation.where({ file_resource_id: params[:id] }) })
  end
end
