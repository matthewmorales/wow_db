class TabardsController < ApplicationController
  before_action :set_tabard, only: [:show, :edit, :update, :destroy]

  # GET /tabards
  # GET /tabards.json
  def index
    @tabards = Tabard.all
  end

  # GET /tabards/1
  # GET /tabards/1.json
  def show
  end

  # GET /tabards/new
  def new
    @tabard = Tabard.new
  end

  # GET /tabards/1/edit
  def edit
  end

  # POST /tabards
  # POST /tabards.json
  def create
    @tabard = Tabard.new(tabard_params)

    respond_to do |format|
      if @tabard.save
        format.html { redirect_to @tabard, notice: 'Tabard was successfully created.' }
        format.json { render :show, status: :created, location: @tabard }
      else
        format.html { render :new }
        format.json { render json: @tabard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tabards/1
  # PATCH/PUT /tabards/1.json
  def update
    respond_to do |format|
      if @tabard.update(tabard_params)
        format.html { redirect_to @tabard, notice: 'Tabard was successfully updated.' }
        format.json { render :show, status: :ok, location: @tabard }
      else
        format.html { render :edit }
        format.json { render json: @tabard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tabards/1
  # DELETE /tabards/1.json
  def destroy
    @tabard.destroy
    respond_to do |format|
      format.html { redirect_to tabards_url, notice: 'Tabard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tabard
      @tabard = Tabard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tabard_params
      params.require(:tabard).permit(:name, :quality, :itemLevel, :context, :armor)
    end
end
