# frozen_string_literal: true

class RoomMessagesController < ApplicationController
  before_action :load_params, :not_logged_in

  def create
    @roomMessage = RoomMessage.create user: @current_user,
                                      room: @room,
                                      message: params.dig(:room_message, :message_content)

    if @roomMessage.save
      ActionCable.server.broadcast "room_channel_#{@roomMessage.room_id}",
                                   { message_content: @roomMessage.message, senderName: @current_user.username }
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def load_params
    current_user
    @current_user = User.find_by(id: session[:user_id])

    @room = Room.find params.dig(:room_message, :room)
  end

  def not_logged_in
    redirect_to login_path if @current_user.nil?
  end
end
