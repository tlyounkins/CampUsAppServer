class PrivateMessagesController < ApplicationController

  # GET /private_messages
  # GET /private_messages.json
  def index
    @private_messages = PrivateMessage.all
  end

  # GET /private_messages/1
  # GET /private_messages/1.json
  def show
    #respond_to do |format|
     # format.json{render :json=> User.find(params[:id]).private_messages}
   # end
  end

  # GET /private_messages/new
  def new
    @private_messages = PrivateMessage.new
  end

  # POST /private_messages
  # POST /private_messages/1.json
  def create
    @receiver_id = User.find(params[:recipient]).id
    @private_message = User.find(params[:id]).private_messages.build(private_message_params)

    if @private_messages.save
      flash[:success] = "Private_Message created!"
      respond_to do |format|
        format.html { redirect_to @private_messages, notice: 'Private Messages was successfully created.' }
        format.json { render :json=>{:success => true}}
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render :json=>{:success => false}}
      end
    end
  end

  # DELETE /private_messages/1
  # DELETE /private_messages/1.json
  def destroy
    @private_message.destroy
    #flash[:success] = "Private Messages deleted"
    redirect_to request.referrer || root_url
    #respond_to do |format|
    #format.html { redirect_to microposts_url, notice: 'Private Messages were successfully destroyed.' }
    #format.json { head :no_content }
    #end
  end

  private
  def private_message_params
    params.require(:private_message).permit(:id, :sender_id, :reciever_id, :body, :unread)
  end
end
