class GroupsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json {render :json=>{:groupName => @group.groupname, :description => @group.description}}
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new(group_params)
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
        format.json {render :json =>{ :success => true}}
      end
    else
      @group.errors.full_messages
      respond_to do |format|
        format.html {render 'new'}
        format.json {render :json => {:success =>false}}
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { }#redirect_to users_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:groupname, :description)
    end

end
