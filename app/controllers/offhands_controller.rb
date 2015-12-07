class OffhandsController < ApplicationController
  before_action :set_offhand, only: [:show, :edit, :update, :destroy]

  # GET /offhands
  # GET /offhands.json
  def index
    @offhands = Offhand.all
  end

  # GET /offhands/1
  # GET /offhands/1.json
  def show
  end

  # GET /offhands/new
  def new
    @offhand = Offhand.new
  end

  # GET /offhands/1/edit
  def edit
  end

  # POST /offhands
  # POST /offhands.json
  def create
    @offhand = Offhand.new(offhand_params)

    respond_to do |format|
      if @offhand.save
        format.html { redirect_to @offhand, notice: 'Offhand was successfully created.' }
        format.json { render :show, status: :created, location: @offhand }
      else
        format.html { render :new }
        format.json { render json: @offhand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offhands/1
  # PATCH/PUT /offhands/1.json
  def update
    respond_to do |format|
      if @offhand.update(offhand_params)
        format.html { redirect_to @offhand, notice: 'Offhand was successfully updated.' }
        format.json { render :show, status: :ok, location: @offhand }
      else
        format.html { render :edit }
        format.json { render json: @offhand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offhands/1
  # DELETE /offhands/1.json
  def destroy
    @offhand.destroy
    respond_to do |format|
      format.html { redirect_to offhands_url, notice: 'Offhand was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offhand
      @offhand = Offhand.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offhand_params
      params.require(:offhand).permit(:name, :quality, :itemLevel, :armor, :context)
    end
end
