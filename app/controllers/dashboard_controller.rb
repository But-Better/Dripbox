# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    unless logged_in?
      redirect_to login_path
      return
    end

    current_user
    load_all_current_user_res

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
  def load_all_current_user_res
    @res_of_user = @current_user.user_resources.all
  end

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
    @upload_file_history = []
    # TODO: gets multiple dates
    all_upload_dates.each do |item|
      @upload_file_history.append({ 'date': item, 'number': get_number_of_files_at_date(item) }) unless item.nil?
    end
  end

  # noinspection RubyNilAnalysis
  def load_number_of_files_per_type
    @res_of_user.each do |item|
      puts "\t - " + item.file.to_s
    end
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

  # noinspection RubyNilAnalysis
  # @return [Array]
  def all_upload_dates
    all_upload_dates = []
    @res_of_user.each do |item|
      all_upload_dates.append(item.created_at.to_date)
    end
    RailsDateRange(all_upload_dates.min..all_upload_dates.max).every(days: +1)
    # RailsDateRange((4.years.ago)..Time.now).every(years: 1)
  end

  # Convenience method
  def RailsDateRange(range)
    RailsDateRange.new(range.begin, range.end, range.exclude_end?)
  end

  # noinspection RubyNilAnalysis
  def get_number_of_files_at_date(date)
    nof = 0 # number of files
    # TODO: doesn't find any it, need to find out why
    @res_of_user.each do |item|
      nof += 1 if item.created_at.to_date == date
    end
    nof
  end
end
