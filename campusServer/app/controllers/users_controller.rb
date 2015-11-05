class UsersController < ApplicationController
  #TODO:
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_user,     only: :destroy
  skip_before_filter :verify_authenticity_token


  # GET /users
  # GET /users.json
  # TODO: Previous method of index has @users = User.all
  # Listing 9.4.2 in the rails tutorial uses paginate
  def index
    #@users = User.all
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json {render :json=>{:email => @user.email, :password => @user.password,
                                            :firstname => @user.firstname, :lastname  => @user.lastname,
                                            :bio => @user.bio, :major => @user.major, :hometown => @user.hometown,
                                            :age => @user.age, :gender => @user.gender}}
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      @user.errors.full_messages
      log_in @user # delete this line so users do not login upon signup
      flash[:success] = "Welcome to the CampUs App!"
      respond_to do |format|
        format.html {redirect_to @user}
        format.json {render :json =>{ :success => true}}
      end
    else
      @user.errors.full_messages
      respond_to do |format|
        format.html {render 'new'}
        format.json {render :json => {:success =>false}}
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
        respond_to do |format|
          format.html {flash[:success] = "Profile updated"
                      redirect_to @user}
          format.json {render :json =>{ :success => true}}
        end
    else
        respond_to do |format|
          format.html {render 'edit'}
          format.json {render :json =>{ :success => false}}
        end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    User.find(params[:id]).destroy
    unless current_user?(user)
      user.destroy
      flash[:success] = "User deleted."
    end
    redirect_to users_url
    #respond_to do |format|
      #format.html { flash[:success] = "User deleted"
                   #redirect_to users_url}
      #format.json { render :json =>{ :success => true} }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :firstname, :lastname,
                                   :bio, :major, :hometown, :age, :gender)
    end

    #Before filters

      # Confirms a logged-in user.
     def logged_in_user
      unless logged_in?
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_url
      end
     end
    # Confirms the correct user.
    def correct_user
     @user = User.find(params[:id])
     redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
