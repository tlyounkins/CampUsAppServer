class EventsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json {render :json=>{:eventName => @event.eventname, :StartDate => @event.startdate,
                                  :eventEndDate => @event.enddate, :location => @event.location,
                                  :description => @event.description}}
    end
  end

  # GET /events/new
  def new
  end

  # GET /events/getAll.json
  def getAll
    respond_to do |format|
      format.json {render :json=>Event.all}
    end
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(:eventname, :startdate, :enddate, :location, :description)
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

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { }#redirect_to users_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def event_params
    params.require(:event).permit(:eventname, :startdate, :enddate, :location, :description)
  end
end