class UniversesController < ApplicationController
  before_action :set_universe, only: [:show, :edit, :update, :destroy]

  # GET /universes
  # GET /universes.json
  def index
    @universes = Universe.all
  end

  # GET /universes/1
  # GET /universes/1.json
  def show
  end

  # GET /universes/new
  def new
    @universe = Universe.new
  end

  # GET /universes/1/edit
  def edit
  end

  # POST /universes
  # POST /universes.json
  def create
    @universe = Universe.new(universe_params)

    respond_to do |format|
      if @universe.save
        format.html { redirect_to @universe, notice: 'Universe was successfully created.' }
        format.json { render :show, status: :created, location: @universe }
      else
        format.html { render :new }
        format.json { render json: @universe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /universes/1
  # PATCH/PUT /universes/1.json
  def update
    respond_to do |format|
      if @universe.update(universe_params)
        format.html { redirect_to @universe, notice: 'Universe was successfully updated.' }
        format.json { render :show, status: :ok, location: @universe }
      else
        format.html { render :edit }
        format.json { render json: @universe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /universes/1
  # DELETE /universes/1.json
  def destroy
    @universe.destroy
    respond_to do |format|
      format.html { redirect_to universes_url, notice: 'Universe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_universe
      @universe = Universe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def universe_params
      params.require(:universe).permit(:region_id, :region_name, :constellation_id, :constellation_name, :system_id, :system_name)
    end
end
