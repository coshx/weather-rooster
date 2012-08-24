class CurrentForecastsController < ApplicationController
  # GET /current_forecasts
  # GET /current_forecasts.json
  def index
    @current_forecasts = CurrentForecast.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @current_forecasts }
    end
  end

  # GET /current_forecasts/1
  # GET /current_forecasts/1.json
  def show
    @current_forecast = CurrentForecast.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @current_forecast }
    end
  end

  # GET /current_forecasts/new
  # GET /current_forecasts/new.json
  def new
    @current_forecast = CurrentForecast.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @current_forecast }
    end
  end

  # GET /current_forecasts/1/edit
  def edit
    @current_forecast = CurrentForecast.find(params[:id])
  end

  # POST /current_forecasts
  # POST /current_forecasts.json
  def create
    @current_forecast = CurrentForecast.new(params[:current_forecast])

    respond_to do |format|
      if @current_forecast.save
        format.html { redirect_to @current_forecast, notice: 'Current forecast was successfully created.' }
        format.json { render json: @current_forecast, status: :created, location: @current_forecast }
      else
        format.html { render action: "new" }
        format.json { render json: @current_forecast.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /current_forecasts/1
  # PUT /current_forecasts/1.json
  def update
    @current_forecast = CurrentForecast.find(params[:id])

    respond_to do |format|
      if @current_forecast.update_attributes(params[:current_forecast])
        format.html { redirect_to @current_forecast, notice: 'Current forecast was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @current_forecast.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /current_forecasts/1
  # DELETE /current_forecasts/1.json
  def destroy
    @current_forecast = CurrentForecast.find(params[:id])
    @current_forecast.destroy

    respond_to do |format|
      format.html { redirect_to current_forecasts_url }
      format.json { head :no_content }
    end
  end
end
