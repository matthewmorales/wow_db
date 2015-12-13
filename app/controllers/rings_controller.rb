class RingsController < ApplicationController
  before_action :set_ring, only: [:show, :edit, :update, :destroy]

  # GET /rings
  # GET /rings.json
  def index
    @rings = Ring.all
  end

  # GET /rings/1
  # GET /rings/1.json
  def show
  end

  # GET /rings/new
  def new
    @ring = Ring.new
  end

  # GET /rings/1/edit
  def edit
  end

  # POST /rings
  # POST /rings.json
  def create
    @ring = Ring.new(ring_params)

    respond_to do |format|
      if @ring.save
        format.html { redirect_to @ring, notice: 'Ring was successfully created.' }
        format.json { render :show, status: :created, location: @ring }
      else
        format.html { render :new }
        format.json { render json: @ring.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rings/1
  # PATCH/PUT /rings/1.json
  def update
    respond_to do |format|
      if @ring.update(ring_params)
        format.html { redirect_to @ring, notice: 'Ring was successfully updated.' }
        format.json { render :show, status: :ok, location: @ring }
      else
        format.html { render :edit }
        format.json { render json: @ring.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rings/1
  # DELETE /rings/1.json
  def destroy
    @ring.destroy
    respond_to do |format|
      format.html { redirect_to rings_url, notice: 'Ring was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ring
      @ring = Ring.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ring_params
      params.require(:ring).permit(:name, :icon, :quality, :itemLevel, :armor, :context)
    end
end
