class RoomsController < ApplicationController


#load all existing Chatrooms for display
def index
  @existingRooms = Room.all
end

#load data of selected Chatroom
def show
  @selectedRoom = Room.find(params[:id])
end

def new
  @room = Room.new
end

def create
  @room = Room.new(name: "Test RaumName")

  if @room.save
    redirect_to @room
  else
    render :new
  end
end
end

