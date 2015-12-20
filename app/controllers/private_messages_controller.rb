class PrivateMessagesController < ApplicationController
  before_action :correct_user,   only: :destroy
  skip_before_filter :verify_authenticity_token

  # GET /private_messages
  # GET /private_messages.json
  def index
    @private_messages = PrivateMessage.all
  end

  # GET /private_messages/1
  # GET /private_messages/1.json
  def show
    respond_to do |format|
      format.json{render :json=> PrivateMessage.where(receiver_id: params[:id])}
    end
  end

  # GET /private_messages/new
  def new
    @private_messages = PrivateMessage.new
  end

  # GET /private_messages/1/senders
  def get_senders
    @senders_id = PrivateMessage.where(receiver_id: params[:id]).pluck(:user_id).where(user_id: params[:id]).pluck(:receiver_id)
    senders = Array.new

    @senders_id.length.times do |i|
      username = User.find(@senders_id[i]).username
      if !senders.include? username
        senders[i] = username
      end
    end

    respond_to do |format|
      format.json { render :json=> senders}
    end
  end

  # GET /private_messages/1/:username
  def get_messages
    sender = User.find_by(username: params[:username])
    messages = PrivateMessage.where(user_id: [params[:id], sender.id]).where(receiver_id: [params[:id], sender.id]).sort_by &:created_at
    respond_to do |format|
      format.json {render :json => messages}
    end
  end

  # POST /private_messages
  # POST /private_messages/1.json
  def create
    receiver = User.find_by(username: params[:recipient])

    @private_message = User.find(params[:user_id]).private_messages.build(:receiver_id => receiver.id, :user_id => params[:user_id],
                                                                          :body => params[:body], :unread => 1)

    if @private_message.save
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
    params.permit(:id, :user_id, :receiver_id, :body, :unread)
  end
end
