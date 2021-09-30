# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :load_params, :not_logged_in

  # load all existing Chatrooms for display
  def index
    @existingRooms = Room.all
  end

  # load data of selected Chatroom
  def show
    @selectedRoom = Room.find(params[:id])

    @roomMessages = @selectedRoom.room_messages.all
    @roomMessage = RoomMessage.new

    @room_id = params[:id]
  end

  # load this site if the name of the room already exists
  def new
    @room = Room.new
    @nameConflict = false
  end

  # create a new room
  def create
    @room = Room.new(room_params)

    # check if room name is unique
    if @room.save
      redirect_to @room
    else
      @nameConflict = true
      render :new
    end
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end

  def load_params
    current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def not_logged_in
    redirect_to login_path if @current_user.nil?
  end
end
