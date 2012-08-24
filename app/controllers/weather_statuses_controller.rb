class WeatherStatusesController < ApplicationController
  # GET /weather_statuses
  # GET /weather_statuses.json
  def index
    @weather_statuses = WeatherStatus.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @weather_statuses }
    end
  end

  # GET /weather_statuses/1
  # GET /weather_statuses/1.json
  def show
    @weather_status = WeatherStatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @weather_status }
    end
  end

  # GET /weather_statuses/new
  # GET /weather_statuses/new.json
  def new
    @weather_status = WeatherStatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @weather_status }
    end
  end

  # GET /weather_statuses/1/edit
  def edit
    @weather_status = WeatherStatus.find(params[:id])
  end

  # POST /weather_statuses
  # POST /weather_statuses.json
  def create
    @weather_status = WeatherStatus.new(params[:weather_status])

    respond_to do |format|
      if @weather_status.save
        format.html { redirect_to @weather_status, notice: 'Weather status was successfully created.' }
        format.json { render json: @weather_status, status: :created, location: @weather_status }
      else
        format.html { render action: "new" }
        format.json { render json: @weather_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /weather_statuses/1
  # PUT /weather_statuses/1.json
  def update
    @weather_status = WeatherStatus.find(params[:id])

    respond_to do |format|
      if @weather_status.update_attributes(params[:weather_status])
        format.html { redirect_to @weather_status, notice: 'Weather status was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @weather_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weather_statuses/1
  # DELETE /weather_statuses/1.json
  def destroy
    @weather_status = WeatherStatus.find(params[:id])
    @weather_status.destroy

    respond_to do |format|
      format.html { redirect_to weather_statuses_url }
      format.json { head :no_content }
    end
  end
end
