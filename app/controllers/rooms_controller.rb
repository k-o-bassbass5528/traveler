class RoomsController < ApplicationController
    before_action :authenticate_user!

    def create
        @room = Room.create(user_id: current_user.id)
        @current_entry = Entry.create(user_id: current_user.id, room_id: @room.id)
        @another_entry = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(:room_id =>@room.id))
        redirect_to room_path(@room)
    end

    def show
        @room = Room.find(params[:id])
        if Entry.where(user_id: current_user.id, room_id: @room.id).present?
            @messeges = @room.messages
            @message = Message.new
            @entries = @room.entries
            @myuserid = current_user.id
        else
            redirect_back(fallback_location: root_path)
        end
    end
end
