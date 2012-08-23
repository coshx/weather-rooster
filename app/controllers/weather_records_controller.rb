class WeatherRecordsController < ApplicationController
  # GET /weather_records
  # GET /weather_records.json
  def index
    @weather_records = WeatherRecord.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @weather_records }
    end
  end

  # GET /weather_records/1
  # GET /weather_records/1.json
  def show
    @weather_record = WeatherRecord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @weather_record }
    end
  end

  # GET /weather_records/new
  # GET /weather_records/new.json
  def new
    @weather_record = WeatherRecord.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @weather_record }
    end
  end

  # GET /weather_records/1/edit
  def edit
    @weather_record = WeatherRecord.find(params[:id])
  end

  # POST /weather_records
  # POST /weather_records.json
  def create
    @weather_record = WeatherRecord.new(params[:weather_record])

    respond_to do |format|
      if @weather_record.save
        format.html { redirect_to @weather_record, notice: 'Weather record was successfully created.' }
        format.json { render json: @weather_record, status: :created, location: @weather_record }
      else
        format.html { render action: "new" }
        format.json { render json: @weather_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /weather_records/1
  # PUT /weather_records/1.json
  def update
    @weather_record = WeatherRecord.find(params[:id])

    respond_to do |format|
      if @weather_record.update_attributes(params[:weather_record])
        format.html { redirect_to @weather_record, notice: 'Weather record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @weather_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weather_records/1
  # DELETE /weather_records/1.json
  def destroy
    @weather_record = WeatherRecord.find(params[:id])
    @weather_record.destroy

    respond_to do |format|
      format.html { redirect_to weather_records_url }
      format.json { head :no_content }
    end
  end
end
