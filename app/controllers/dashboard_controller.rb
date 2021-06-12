class DashboardController < ApplicationController
  def index
    @files = Resource.all
    @categories = Category.all
    return unless params.key?('id')

    @called_file = Resource.find params[:id]
    @user_name = @called_file.user_id
    @called_file_cats = Category.where({ id: FileResourceCategoryRelation.where({ file_resource_id: params[:id] }) })
  end
end
