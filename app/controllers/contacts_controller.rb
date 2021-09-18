# frozen_string_literal: true

class ContactsController < ApplicationController

  def index
    current_user
    unless @current_user.contact_status
      flash[:contactable_notice] = "You have no permission to read contacts"
      redirect_to dashboard_path
    end

    @contact = Contact.all
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_information(@contact).deliver

      # Send to all contactable user a contact email
      contactable = User.where(contact_status: true)

      contactable&.each do |user|
        ContactMailer.send_to_management(@contact, user).deliver
      end

      redirect_to root_path
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
