class GroupsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json {render :json=>{:groupName => @group.groupname, :description => @group.description, :school => @group.school}}
    end
  end

  # GET /groups/getAll.json
  def getAll
    respond_to do |format|
      format.json {render :json=>Group.all}
    end
  end

  # GET /groups/findId/:groupname.json
  def findId
    groupname = params[:groupname].gsub(/_/, ' ') # allow whitespaces in name
    group = Group.find_by(groupname: groupname)
    respond_to do |format|
      format.json {render :json => {:id => group.id}}
    end
  end

  # GET /groups/1/members.json
  def members
    respond_to do |format|
      format.json {render :json=>Group.find(params[:id]).user.select('username')}
    end
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    if @group.save
      @group.errors.full_messages
      flash[:success] = "Group Created!"
      respond_to do |format|
        format.html {redirect_to @group}
        format.json {render :json =>{ :success => true, :group_id => @group.id}}
      end
    else
      @group.errors.full_messages
      respond_to do |format|
        format.html {render 'new'}
        format.json {render :json => {:success => false}}
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html {}
      format.json { head :no_content }
    end
  end

  # GET /groups/1/join/13.json
  def join
    @group = Group.find(params[:id])
    @user = User.find(params[:user_id])
    @user.group << @group
    respond_to do |format|
      format.json{render :json => {:success => true}}
    end
  end

  private
    def group_params
      params.require(:group).permit(:groupname, :description, :school)
    end

end
