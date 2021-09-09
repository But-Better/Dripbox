# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :check_if_logged_in

  def index
    current_user

    @last_uploaded_file = @current_user.last_uploaded_file
    @upload_file_history = @current_user.upload_file_history
    @number_of_files_per_type = @current_user.number_of_files_per_type
    @times_of_login = @current_user.times_of_login
    @total_number_of_uploads = @current_user.total_number_of_uploads
    @total_upload_size = @current_user.total_upload_size

    @files = UserResource.all
    @categories = Tag.all

    return unless params.key?('id')

    @called_file = UserResource.find params[:id]
    @user_name = User.find(@called_file.user_id).username

    return if @called_file.file.filename.nil?

    @file_of_current_resource = @called_file.file

  end

  private

  def check_if_logged_in
    redirect_to login_path unless logged_in?
  end
end
