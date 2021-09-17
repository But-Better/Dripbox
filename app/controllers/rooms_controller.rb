class RoomsController < ApplicationController
end

#load all existing Chatrooms for display
def index
  @existingRooms = Room.all
end

#load data of selected Chatroom
def show
  @selectedRoom = Room.find(params[:id])
end
