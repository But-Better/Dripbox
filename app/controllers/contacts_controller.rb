class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_information(@contact).deliver

      User.all.each



      ContactMailer.send_to_management("").deliver
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
