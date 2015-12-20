class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      #respond_to do |format|
        flash[:success] = "Account activated!"
        redirect_to @user
        #format.html {redirect_to @user}
     # end
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
