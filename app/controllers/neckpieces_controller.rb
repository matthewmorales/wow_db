class NeckpiecesController < ApplicationController
  before_action :set_neckpiece, only: [:show, :edit, :update, :destroy]

  # GET /neckpieces
  # GET /neckpieces.json
  def index
    @neckpieces = Neckpiece.all
  end

  # GET /neckpieces/1
  # GET /neckpieces/1.json
  def show
  end

  # GET /neckpieces/new
  def new
    @neckpiece = Neckpiece.new
  end

  # GET /neckpieces/1/edit
  def edit
  end

  # POST /neckpieces
  # POST /neckpieces.json
  def create
    @neckpiece = Neckpiece.new(neckpiece_params)

    respond_to do |format|
      if @neckpiece.save
        format.html { redirect_to @neckpiece, notice: 'Neckpiece was successfully created.' }
        format.json { render :show, status: :created, location: @neckpiece }
      else
        format.html { render :new }
        format.json { render json: @neckpiece.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /neckpieces/1
  # PATCH/PUT /neckpieces/1.json
  def update
    respond_to do |format|
      if @neckpiece.update(neckpiece_params)
        format.html { redirect_to @neckpiece, notice: 'Neckpiece was successfully updated.' }
        format.json { render :show, status: :ok, location: @neckpiece }
      else
        format.html { render :edit }
        format.json { render json: @neckpiece.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /neckpieces/1
  # DELETE /neckpieces/1.json
  def destroy
    @neckpiece.destroy
    respond_to do |format|
      format.html { redirect_to neckpieces_url, notice: 'Neckpiece was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_neckpiece
      @neckpiece = Neckpiece.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def neckpiece_params
      params.require(:neckpiece).permit(:name, :icon, :quality, :itemLevel, :armor, :context)
    end
end
