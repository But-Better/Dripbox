class RoomMessagesController < ApplicationController

  before_action :load_params

  def create
    @roomMessage = RoomMessage.create user: @current_user,
                                    room: @room,
                                    message: params.dig(:room_message, :message_content)

    if @roomMessage.save
      redirect_to dashboard_path
    end
  end

  private
  def load_params
    current_user
    @current_user = User.find_by(id: session[:user_id])

    @room = Room.find params.dig(:room_message, :room)
  end

end
