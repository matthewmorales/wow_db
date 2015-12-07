class MainhandsController < ApplicationController
  before_action :set_mainhand, only: [:show, :edit, :update, :destroy]

  # GET /mainhands
  # GET /mainhands.json
  def index
    @mainhands = Mainhand.all
  end

  # GET /mainhands/1
  # GET /mainhands/1.json
  def show
  end

  # GET /mainhands/new
  def new
    @mainhand = Mainhand.new
  end

  # GET /mainhands/1/edit
  def edit
  end

  # POST /mainhands
  # POST /mainhands.json
  def create
    @mainhand = Mainhand.new(mainhand_params)

    respond_to do |format|
      if @mainhand.save
        format.html { redirect_to @mainhand, notice: 'Mainhand was successfully created.' }
        format.json { render :show, status: :created, location: @mainhand }
      else
        format.html { render :new }
        format.json { render json: @mainhand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mainhands/1
  # PATCH/PUT /mainhands/1.json
  def update
    respond_to do |format|
      if @mainhand.update(mainhand_params)
        format.html { redirect_to @mainhand, notice: 'Mainhand was successfully updated.' }
        format.json { render :show, status: :ok, location: @mainhand }
      else
        format.html { render :edit }
        format.json { render json: @mainhand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mainhands/1
  # DELETE /mainhands/1.json
  def destroy
    @mainhand.destroy
    respond_to do |format|
      format.html { redirect_to mainhands_url, notice: 'Mainhand was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mainhand
      @mainhand = Mainhand.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mainhand_params
      params.require(:mainhand).permit(:name, :quality, :itemLevel, :context, :dps)
    end
end
