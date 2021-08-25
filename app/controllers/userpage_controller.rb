# frozen_string_literal: true

class UserpageController < ApplicationController

  def index
    redirect_to registrations_index_path unless logged_in?
    current_user
    load_last_uploaded_file
    load_upload_file_history
  end

  private

  # noinspection RubyNilAnalysis
  def load_last_uploaded_file
    @last_uploaded_file = @current_user.user_resources.last
    @last_uploaded_file = 'none' if @last_uploaded_file.nil?
  end

  #noinspection RubyNilAnalysis
  def load_upload_file_history
    uploaded_files = @current_user.user_resources.all
    # TODO: code here
  end
end
