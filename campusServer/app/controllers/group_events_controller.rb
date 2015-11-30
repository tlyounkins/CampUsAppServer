class GroupEventsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  # POST /events
  # POST /events.json
  def create
    @event = GroupEvent.new(group_event_params)
    if @event.save
      @event.errors.full_messages
      flash[:success] = "Event Created!"
      respond_to do |format|
        format.html {redirect_to @event}
        format.json {render :json =>{ :success => true}}
      end
    else
      @event.errors.full_messages
      respond_to do |format|
        format.html {render 'new'}
        format.json {render :json => {:success =>false}}
      end
    end
  end

  def getGroup
    respond_to do |format|
      format.json{render :json=>GroupEvent.where('group_id' == params[:group_id])};
    end
  end

  private
  def group_event_params
    params.require(:group_event).permit(:id, :group_id, :name, :date, :start, :end, :description)
  end
end
