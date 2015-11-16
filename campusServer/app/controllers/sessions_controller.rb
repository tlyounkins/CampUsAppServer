class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #if user.activated?
      #  log_in user
      #  params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      #  respond_to do |format|
      #    format.html {redirect_back_or user}
      #format.json {render :json => {:success => true, :id =>user.id, :username => user.username}}
      #  end
      #else
      log_in user
        respond_to do |format|
          format.html {flash.now[:danger] = 'Account not activated'
          render 'new'}
          format.json {render :json => {:success => true, :id =>user.id, :username => user.username}}
        end
      #end
    else
      respond_to do |format|
        format.html {flash.now[:danger] = 'Invalid email/password combination'
                    render 'new'}
        format.json {render :json => {:success => false}}
      end
    end
  end

  def destroy
    log_out if logged_in?
    respond_to do |format|
      format.html {redirect_to root_url}
      format.json {render :json => {:success => true}}
    end
  end
end
