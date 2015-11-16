class MicropostsController < ApplicationController
  #before_action :set_micropost, only: [:show, :edit, :update, :destroy]
  #before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  skip_before_filter :verify_authenticity_token

  # GET /microposts
  # GET /microposts.json
  def index
    @microposts = Micropost.all
  end

  # GET /microposts/1
  # GET /microposts/1.json
  def show
    respond_to do |format|
      format.json{render :json=> {:content => User.find(params[:id]).microposts.last.content}}
    end
  end

  # GET /microposts/new
  def new
    @micropost = Micropost.new
  end

  # GET /microposts/1/edit
  def edit
  end

  # GET /microposts/1/posts
  def posts
    respond_to do |format|
      format.json{render :json=>User.find(params[:id]).microposts.select('content')}
    end
  end

  # POST /microposts
  # POST /microposts/1.json
  def create
    @micropost = User.find(params[:id]).microposts.build(micropost_params)

    #respond_to do |format|
      if @micropost.save
        flash[:success] = "Micropost created!"
        #redirect_to root_url
        respond_to do |format|
          format.html { redirect_to @micropost, notice: 'Micropost was successfully created.' }
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

  # PATCH/PUT /microposts/1
  # PATCH/PUT /microposts/1.json
  def update
    respond_to do |format|
      if @micropost.update(micropost_params)
        format.html { redirect_to @micropost, notice: 'Micropost was successfully updated.' }
        format.json { render :show, status: :ok, location: @micropost }
      else
        format.html { render :edit }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /microposts/1
  # DELETE /microposts/1.json
  def destroy
    @micropost.destroy
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
    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
