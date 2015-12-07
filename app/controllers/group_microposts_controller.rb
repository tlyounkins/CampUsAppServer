class GroupMicropostsController < ApplicationController
  #before_action :set_micropost, only: [:show, :edit, :update, :destroy]
  #before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  skip_before_filter :verify_authenticity_token

  # GET /group_microposts
  # GET /group_microposts.json
  def index
    @group_microposts = Group_Micropost.all
  end

  # GET /group_microposts/1
  # GET /group_microposts/1.json
  # Returns latest post
  def show
    respond_to do |format|
      format.json{render :json=> {:content => Group.find(params[:id]).group_micropost.last.content}}
    end
  end

  # GET /group_microposts/new
  def new
    @group_micropost = Group_Micropost.new
  end

  # GET /group_microposts/1/edit
  def edit
  end

  # GET /group_microposts/1/posts
  # Returns all posts
  def posts
    respond_to do |format|
      format.json{render :json=>Group.find(params[:id]).group_micropost.select('content')}
    end
  end

  # POST /group_microposts
  # POST /group_microposts/1.json
  def create
    @group_micropost = Group.find(params[:id]).group_micropost.build(group_micropost_params)

    #respond_to do |format|
    if @group_micropost.save
      flash[:success] = "Micropost created!"
      #redirect_to root_url
      respond_to do |format|
        format.html { redirect_to @group_micropost, notice: 'Micropost was successfully created.' }
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

  # PATCH/PUT /group_microposts/1
  # PATCH/PUT /group_microposts/1.json
  def update
    respond_to do |format|
      if @group_micropost.update(micropost_params)
        format.html { redirect_to @group_micropost, notice: 'Micropost was successfully updated.' }
        format.json { render :show, status: :ok, location: @group_micropost }
      else
        format.html { render :edit }
        format.json { render json: @group_micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_microposts/1
  # DELETE /group_microposts/1.json
  def destroy
    @group_micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
    #respond_to do |format|
    #format.html { redirect_to microposts_url, notice: 'Micropost was successfully destroyed.' }
    #format.json { head :no_content }
    #end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  #def set_micropost
  #@micropost = Micropost.find(params[:id])
  #end

  # Never trust parameters from the scary internet, only allow the white list through.
  def group_micropost_params
    params.require(:group_micropost).permit(:content)
  end

end
