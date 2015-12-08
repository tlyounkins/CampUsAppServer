class GroupEventsController < ApplicationController
  skip_before_filter :verify_authenticity_token


  # GET /group_events
  def index
    @group_events = GroupEvent.all
  end

  # GET /group_events/1
  def show
    @group_event = GroupEvent.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json {render :json=>{ :eventName => @event.eventname, :StartDate => @event.startdate,
                                   :eventEndDate => @event.enddate, :location => @event.location,
                                   :description => @event.description }}
    end
  end

  # GET /group_events/getAll.json
  def getAll
    respond_to do |format|
      format.json {render :json=>GroupEvent.all}
    end
  end

  # POST /group_events
  # POST /group_events.json
  def create
    @group_event = GroupEvent.new(group_event_params)
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

  # PATCH/PUT /group_events/1
  def update
    respond_to do |format|
      if @group_event.update(event_params)
        format.html { redirect_to @group_event, notice: 'Group_Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @group_event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_events/1
  def destroy
    @group_event.destroy
    respond_to do |format|
      format.html { }#redirect_to users_url, notice: 'Group_Event was successfully destroyed.' }
      format.json { head :no_content }
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
