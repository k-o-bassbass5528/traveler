class MessagesController < ApplicationController
    before_action :authenticate_user!, :only=>[:create]

    def create
        if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
        @message = Message.create(user_id: current_user.id, body: params[:messages][:message], room_id: params[:message][:room_id])
            redirect_to "/rooms/#{@message.room_id}"
        else
            redirect_back(fallback_location: root_path)
        end
    end :snowflake:
end

    private
    def message_params
        params.require(:message).permit(:message, :room_id)
    end