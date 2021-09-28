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
  def uploaded_before? = !user_resources.size.zero?

  # noinspection RubyNilAnalysis
  def last_uploaded_file
    return 'none' unless uploaded_before?

    user_resources.last.name
  end

  # @return Array[Hash]
  def upload_file_history
    upload_file_history = []
    user_resources.group(:created_at).count.each_key do |item|
      upload_file_history.append({ 'date': item.to_date, 'number': user_resources.group(:created_at).count[item] })
    end
    upload_file_history
  end

  # return Array[Hash]
  def number_of_files_per_type
    hash_array = []
    file_type_counting.each do |item|
      hash_array.append({ 'type': item[0], 'number': item[1] })
    end
    hash_array
  end

  # @return Array[Hash]
  def top_five_files_by_size
    hash_array = []
    user_resources.sort_by(&:byte_filesize).last(5).reverse.each do |item|
      hash_array.append({ 'file': item.name, 'size': item.byte_filesize })
    end
    hash_array
  end

  # return [Integer]
  def times_of_login
    login_counter
  end

  # return [Integer]
  def total_number_of_uploads
    user_resources.count
  end

  # return [Integer]
  def total_upload_size
    total_upload_size = 0
    user_resources.each do |item|
      total_upload_size += item.byte_filesize
    end
    total_upload_size
  end

  private

  # return Array[Hash]
  def file_type_counting
    types = {}
    user_resources.each do |item|
      if types.include? item.type.to_s
        types[item.type.to_s] += 1
      else
        types[item.type.to_s] = 1
      end
    end
    types
  end

end
