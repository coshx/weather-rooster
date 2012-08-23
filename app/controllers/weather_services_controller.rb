class WeatherServicesController < ApplicationController
  # GET /weather_services
  # GET /weather_services.json
  def index
    @weather_services = WeatherService.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @weather_services }
    end
  end

  # GET /weather_services/1
  # GET /weather_services/1.json
  def show
    @weather_service = WeatherService.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @weather_service }
    end
  end

  # GET /weather_services/new
  # GET /weather_services/new.json
  def new
    @weather_service = WeatherService.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @weather_service }
    end
  end

  # GET /weather_services/1/edit
  def edit
    @weather_service = WeatherService.find(params[:id])
  end

  # POST /weather_services
  # POST /weather_services.json
  def create
    @weather_service = WeatherService.new(params[:weather_service])

    respond_to do |format|
      if @weather_service.save
        format.html { redirect_to @weather_service, notice: 'Weather service was successfully created.' }
        format.json { render json: @weather_service, status: :created, location: @weather_service }
      else
        format.html { render action: "new" }
        format.json { render json: @weather_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /weather_services/1
  # PUT /weather_services/1.json
  def update
    @weather_service = WeatherService.find(params[:id])

    respond_to do |format|
      if @weather_service.update_attributes(params[:weather_service])
        format.html { redirect_to @weather_service, notice: 'Weather service was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @weather_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weather_services/1
  # DELETE /weather_services/1.json
  def destroy
    @weather_service = WeatherService.find(params[:id])
    @weather_service.destroy

    respond_to do |format|
      format.html { redirect_to weather_services_url }
      format.json { head :no_content }
    end
  end
end
