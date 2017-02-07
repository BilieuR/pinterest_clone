class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]


  # GET /pins
  # GET /pins.json
  def index
    @pins = Pin.all
  end

  # GET /pins/1
  # GET /pins/1.json
  def show
    set_pin
  end

  # GET /pins/new
  def new
    @pin = current_user.pins.build
  end

  # GET /pins/1/edit
  def edit
    set_pin
  end

  # POST /pins
  # POST /pins.json
  def create
    @pin = current_user.pins.build(pin_params)

    respond_to do |format|
      if @pin.save
        flash[:success] = "Pin created!"
        format.html { redirect_to @pin }
        format.json { render :show, status: :created, location: @pin }
      else
        flash.now[:danger] = "Your new pin couldn't be created! Please check the form."
        format.html { render :new }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pins/1
  # PATCH/PUT /pins/1.json
  def update
    set_pin
    respond_to do |format|
      if @pin.update(pin_params)
        flash[:success] = "Pin updated."
        format.html { redirect_to @pin }
        format.json { render :show, status: :ok, location: @pin }
      else
        flash.now[:danger] = "Update failed. Please check the form."
        format.html { render :edit }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pins/1
  # DELETE /pins/1.json
  def destroy
    set_pin
    @pin.destroy
    respond_to do |format|
      flash.now[:danger] = "Pin deleted."
      format.html { redirect_to pins_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params.require(:pin).permit(:description)
    end

    def correct_user
      @pin = correct_user.pins.find_by(id: params[:id])
      if @pin.nil?
        flash[:danger] = "Not authorised to edit this pin"
      end
      redirect_to pins_path
    end
end
