# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :check_if_logged_in

  def index
    current_user
    init_statistics
    push_gon
    load_in_files_and_categories
    return unless params.key?('id')

    load_in_more_info_of_selected_file
    return if @called_file.file.filename.nil?

    @file_of_current_resource = @called_file.file
  end

  private

  def check_if_logged_in
    redirect_to login_path unless logged_in?
  end

  # noinspection RubyNilAnalysis
  def init_statistics
    @last_uploaded_file = @current_user.last_uploaded_file
    @upload_file_history = @current_user.upload_file_history
    @number_of_files_per_type = @current_user.number_of_files_per_type
    @file_size_classification = @current_user.top_five_files_by_size # TODO: this (use other layout, it looks terrible)
    @times_of_login = @current_user.times_of_login
    @total_number_of_uploads = @current_user.total_number_of_uploads
    @total_upload_size = @current_user.total_upload_size
  end

  def push_gon
    gon.push({
               upload_file_history: @upload_file_history,
               number_of_files_per_type: @number_of_files_per_type,
               file_size_classification: @file_size_classification
             })
  end

  #noinspection RubyNilAnalysis
  def load_in_files_and_categories
    @files = @current_user.user_resources.all
    @categories = Tag.all
  end

  # noinspection RubyInstanceMethodNamingConvention
  def load_in_more_info_of_selected_file
    @called_file = UserResource.find params[:id]
    @user_name = User.find(@called_file.user_id).username
  end
end
