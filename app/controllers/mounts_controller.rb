class MountsController < ApplicationController
  before_action :set_mount, only: [:show, :edit, :update, :destroy]

  # GET /mounts
  # GET /mounts.json
  def index
    @mounts = Mount.all
  end

  # GET /mounts/1
  # GET /mounts/1.json
  def show
  end

  # GET /mounts/new
  def new
    @mount = Mount.new
  end

  # GET /mounts/1/edit
  def edit
  end

  # POST /mounts
  # POST /mounts.json
  def create
    @mount = Mount.new(mount_params)

    respond_to do |format|
      if @mount.save
        format.html { redirect_to @mount, notice: 'Mount was successfully created.' }
        format.json { render :show, status: :created, location: @mount }
      else
        format.html { render :new }
        format.json { render json: @mount.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mounts/1
  # PATCH/PUT /mounts/1.json
  def update
    respond_to do |format|
      if @mount.update(mount_params)
        format.html { redirect_to @mount, notice: 'Mount was successfully updated.' }
        format.json { render :show, status: :ok, location: @mount }
      else
        format.html { render :edit }
        format.json { render json: @mount.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mounts/1
  # DELETE /mounts/1.json
  def destroy
    @mount.destroy
    respond_to do |format|
      format.html { redirect_to mounts_url, notice: 'Mount was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mount
      @mount = Mount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mount_params
      params.require(:mount).permit(:name, :flying, :ground, :aquatic, :jumping)
    end
end
