class MessagesController < ApplicationController
    before_filter :authenticate_user!

    def create
        @conversation = Conversation.find(params[:conversation_id])
        @message = @conversation.messages.build(message_params)
        @message.user_id = current_user.id
        if @message.save!
            redirect_to 'landing_page#index'
        else
        @path = conversation_path(@conversation)
        end
    end


    def show
        @conversation = Conversation.find(params[:id])
        @reciever = interlocutor(@conversation)
        @messages = @conversation.messages
        @message = Message.new
    end

    private

    def message_params
        params.require(:message).permit(:body)
    end
end