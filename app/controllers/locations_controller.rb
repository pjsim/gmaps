class LocationsController < ApplicationController
  def index
    if params[:search].present?
      # @json = Location.new(:address => params[:search]).to_gmaps4rails
      @search_location = Location.create(:address => params[:search])
      @locations = Location.near(params[:search], params[:radius], :order => :distance)
      @json = Location.near(params[:search], params[:radius], :order => :distance).to_gmaps4rails
    else
      @locations = Location.all
      @json = Location.all.to_gmaps4rails
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations }
      @search_location.destroy
    end
  end

  def show
    @location = Location.find(params[:id])
    @json = Location.find(params[:id]).to_gmaps4rails

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations }
    end
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(params[:location])

    # respond_to do |format|
    #   if @location.save
    #     format.html { redirect_to @location, notice: 'location was successfully created.' }
    #     format.json { render json: @location, status: :created, location: @location }
    #   else
    #     format.html { render action: "new" }
    #     format.json { render json: @location.errors, status: :unprocessable_entity }
    #   end
    # end
    if @location.save
      redirect_to @location, :notice => "Successfully created location."
    else
      render :action => 'new'
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    if @location.update_attributes(params[:location])
      redirect_to @location, :notice  => "Successfully updated location."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    redirect_to locations_url, :notice => "Successfully destroyed location."
  end
end
