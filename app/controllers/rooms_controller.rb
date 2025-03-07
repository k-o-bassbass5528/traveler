class RoomsController < ApplicationController
    before_action :authenticate_user!

    def create
        @room = Room.create(user_id: current_user.id)
        @current_entry = @room.entries.create(user_id: current_user.id)
        @another_entry = @room.entries.create(user_id: params[:entry][:user_id])
        redirect_to room_path(@room)
    end

    def show
        @room = Room.find(params[:id])
        if @room.entries.where(user_id: current_user.id).present?
            @messeges = @room.messages.all
            @message = Message.new
            @entries = @room.entries
            @another_entry = @entries.where.not(user_id: current_user.id).first
        else
            redirect_back(fallback_location: root_path)
        end
    end
end
