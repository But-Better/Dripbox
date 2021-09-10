# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_resources
  has_secure_password

  before_create :confirmation_token

  require 'uri'
  validates_uniqueness_of :email

  before_save do
    self.email = email.downcase
  end

  validates :username,
            uniqueness: true,
            presence: true,
            length: { minimum: 2, maximum: 20 }

  validates :email,
            uniqueness: { case_sensitive: false },
            presence: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  # https://stackoverflow.com/questions/5123972/ruby-on-rails-password-validation/33632569
  PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower cas e character
  (?=.*[A-Z])        # Must contain an upper case character
/x

  validates :password,
            presence: true,
            allow_nil: false,
            format: { with: PASSWORD_FORMAT },
            confirmation: true

  def confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s if confirm_token.blank?
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(validate: false)
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    UserMailer.forgot_password(self).deliver # This sends an e-mail with a link for the user to reset the password
    save!(validate: false)
  end

  # This generates a random password reset token for the user
  def generate_token(column)
    loop do
      self[column] = SecureRandom.urlsafe_base64
      break unless User.exists?(column => self[column])
    end
  end

  # @return [TrueClass, FalseClass]
  def uploaded_before? = !user_resources.all.empty?

  # noinspection RubyNilAnalysis
  def last_uploaded_file
    return 'none' unless uploaded_before?

    user_resources.last.name
  end

  def upload_file_history
    upload_file_history = []
    all_upload_dates.each do |item|
      upload_file_history.append({ 'date': item, 'number': get_number_of_files_at_date(item) }) unless item.nil?
    end
    upload_file_history
  end

  def number_of_files_per_type
    user_resources.each do |item|
      puts "\t - " + item.file.to_s
    end
  end

  def times_of_login
    @number_of_logins = 0
  end

  def total_number_of_uploads
    @total_number_of_uploads = 0
    # TODO: code here
  end

  def total_upload_size
    @total_number_of_uploads = 0
    # TODO: code here
  end

  private

  # Convenience method
  def RailsDateRange(range)
    RailsDateRange.new(range.begin, range.end, range.exclude_end?)
  end

  # noinspection RubyNilAnalysis
  # @return [Array]
  def all_upload_dates
    all_upload_dates = []
    user_resources.each do |item|
      all_upload_dates.append(item.created_at.to_date)
    end
    RailsDateRange(all_upload_dates.min..all_upload_dates.max).every(days: +1)
  end

  # noinspection RubyNilAnalysis
  def get_number_of_files_at_date(date)
    nof = 0 # number of files
    # TODO: doesn't find any it, need to find out why
    user_resources.each do |item|
      nof += 1 if item.created_at.to_date == date
    end
    nof
  end
end
