class RoomsController < ApplicationController

  before_action :load_params, :not_logged_in

  #load all existing Chatrooms for display
  def index
    @existingRooms = Room.all
  end

  #load data of selected Chatroom
  def show

    @selectedRoom = Room.find(params[:id])

    @roomMessages = @selectedRoom.room_messages.all
    @roomMessage = RoomMessage.new

    @room_id = params[:id]
  end

  def new
    @room = Room.new
    @nameConflict = false
  end

  def create
    @room = Room.new(room_params)

    #check if room name is unique
    alreadyExistingRooms = Room.all
    alreadyExistingRooms.each do |alreadyExistingRoom|
      if @room.name == alreadyExistingRoom.name
        @nameConflict = true
        render :new
      end
    end

    if !@nameConflict
      if @room.save
        ActionCable.server.broadcast "rooms_channel", @room
        redirect_to @room
      else
        render :new
      end
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
    if @current_user.nil?
      redirect_to login_path
    end
  end

end

