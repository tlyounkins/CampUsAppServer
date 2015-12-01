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
      #format.json{render :json=> {:content => User.find(params[:id]).private_messages.last.content}}
    #end
  end

  # GET /private_messages/new
  def new
    @private_messages = PrivateMessage.new
  end

  # POST /private_messages
  # POST /private_messages/1.json
  def create
    @private_message = User.find(params[:id]).private_messages.build(private_message_params)

    #respond_to do |format|
    if @private_messages.save
      flash[:success] = "Private_Message created!"
      #redirect_to root_url
      respond_to do |format|
        format.html { redirect_to @private_messages, notice: 'Private Messages was successfully created.' }
        format.json { render :json=>{:success => true}}
      end
    else
      @feed_items = []
      #render 'static_pages/home'
      respond_to do |format|
        format.html { render :new }
        format.json { render :json=>{:success => false}}
      end
      #end
    end
  end

  # DELETE /private_messages/1
  # DELETE /private_messages/1.json
  def destroy
    @private_message.destroy
    flash[:success] = "Private Messages deleted"
    redirect_to request.referrer || root_url
    #respond_to do |format|
    #format.html { redirect_to microposts_url, notice: 'Private Messages were successfully destroyed.' }
    #format.json { head :no_content }
    #end
  end
end
