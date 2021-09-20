class RoomsController < ApplicationController


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
end

def create
  @room = Room.new(room_params)

  if @room.save
    redirect_to @room
  else
    render :new
  end
end

private

def room_params
  params.require(:room).permit(:name)
end

end

