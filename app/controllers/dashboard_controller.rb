# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    unless logged_in?
      redirect_to login_path
      return
    end

    current_user

    load_last_uploaded_file
    load_upload_file_history
    load_number_of_files_per_type
    load_times_of_login
    load_total_numbers_of_uploads
    load_total_upload_size

    @files = UserResource.all
    @categories = Tag.all

    return unless params.key?('id')

    @called_file = UserResource.find params[:id]
    @user_name = User.find(@called_file.user_id).username

    return if @called_file.file.filename.nil?

    @file_of_current_resource = @called_file.file

  end

  private

  # noinspection RubyNilAnalysis
  def load_last_uploaded_file
    unless @current_user.uploaded_before?
      @last_uploaded_file = 'none'
      return
    end
    @last_uploaded_file = @current_user.user_resources.last.name
  end

  # noinspection RubyNilAnalysis
  def load_upload_file_history
    @upload_file_history = @current_user.user_resources.all

  end

  # noinspection RubyNilAnalysis
  def load_number_of_files_per_type
    @number_of_files_per_type = @current_user.user_resources.all
    # TODO: code here
  end

  # noinspection RubyNilAnalysis
  def load_times_of_login
    @number_of_logins = 0
    # TODO: code here
  end

  # noinspection RubyNilAnalysis
  def load_total_numbers_of_uploads
    @total_number_of_uploads = 0
    # TODO: code here
  end

  # noinspection RubyNilAnalysis
  def load_total_upload_size
    @total_upload_size = 0
    # TODO: code here
  end
end
