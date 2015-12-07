class UsersController < ApplicationController
  #TODO: verify before_action and skip_before_filter code
  #before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
  #                                      :following, :followers]
  #before_action :correct_user,   only: [:edit, :update]
  #before_action :set_user, only: [:show, :edit, :update, :destroy]
  #before_action :admin_user,     only: :destroy
  skip_before_filter :verify_authenticity_token


  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    respond_to do |format|
      format.html {}
      format.json {render :json=>{:username => @user.username, :email => @user.email, :password => @user.password,
                                            :firstname => @user.firstname, :lastname  => @user.lastname,
                                            :bio => @user.bio, :major => @user.major, :hometown => @user.hometown,
                                            :age => @user.age, :gender => @user.gender}}
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/getAll
  def getAll
    respond_to do |format|
      format.json {render :json=>User.all}
    end
  end

  # GET /users/findId/:username.json
  def findId
    user = User.find_by(username: params[:username])
    respond_to do |format|
      format.json {render :json => {:id => user.id}}
    end
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
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      #@user.errors.full_messages
      log_in @user # delete this line so users do not login upon signup
      respond_to do |format|
        format.html {redirect_to @user}
        format.json {render :json =>{ :success => true}}
      end
    else
      #@user.errors.full_messages
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
    end
    respond_to do |format|cd
      format.html { flash[:success] = "User deleted"
                   redirect_to users_url}
      format.json { render :json =>{ :success => true} }
    end
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :username, :email, :password, :password_confirmation, :firstname, :lastname,
                                  :bio, :major, :hometown, :gender)
    end

    #Before filters

      # Confirms a logged-in user.
     #def logged_in_user
      #unless logged_in?
         # store_location
          #flash[:danger] = "Please log in."
          #redirect_to login_url
      #end
     #end
    # Confirms the correct user.
    def correct_user
     @user = User.find(params[:id])
     redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

  private

  # Converts email to all lower-case.
  def downcase_email
    User.email = email.downcase
  end

  # Creates and assigns the activation token and digest.
  def create_activation_digest
    User.activation_token  = User.new_token
    User.activation_digest = User.digest(activation_token)
  end
end
