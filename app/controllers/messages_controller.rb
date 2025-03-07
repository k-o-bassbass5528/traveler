class MessagesController < ApplicationController
    before_action :authenticate_user!

        def create
            @room = Room.find(params[:message][:room_id])
            @message = Message.new(message_params)
            @message.user = current_user
            @message.room_id = params[:message][:room_id]
            @message.room = @room
    
        if @message.save
            redirect_to rooms_path(@room)
        else
            flash[:error] = @message.errors.full_messages.join(", ")
            redirect_to rooms_path(@room)
        end
    end

    private

    def message_params
    params.require(:message).permit(:message, :room_id)
    end
end