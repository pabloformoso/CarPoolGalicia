class CarpoolsController < ApplicationController
  # GET /carpools
  # GET /carpools.json
  def index
    @carpools = Carpool.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @carpools }
    end
  end

  # GET /carpools/1
  # GET /carpools/1.json
  def show
    @carpool = Carpool.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @carpool }
    end
  end

  # GET /carpools/new
  # GET /carpools/new.json
  def new
    @carpool = Carpool.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @carpool }
    end
  end

  # GET /carpools/1/edit
  def edit
    @carpool = Carpool.find(params[:id])
  end

  # POST /carpools
  # POST /carpools.json
  def create
    @carpool = Carpool.new(params[:carpool])

    respond_to do |format|
      if @carpool.save
        format.html { redirect_to @carpool, notice: 'Carpool was successfully created.' }
        format.json { render json: @carpool, status: :created, location: @carpool }
      else
        format.html { render action: "new" }
        format.json { render json: @carpool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /carpools/1
  # PUT /carpools/1.json
  def update
    @carpool = Carpool.find(params[:id])

    respond_to do |format|
      if @carpool.update_attributes(params[:carpool])
        format.html { redirect_to @carpool, notice: 'Carpool was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @carpool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carpools/1
  # DELETE /carpools/1.json
  def destroy
    @carpool = Carpool.find(params[:id])
    @carpool.destroy

    respond_to do |format|
      format.html { redirect_to carpools_url }
      format.json { head :no_content }
    end
  end
end
