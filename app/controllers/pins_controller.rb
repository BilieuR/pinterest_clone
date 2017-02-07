class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]


  def index
    @pins = Pin.all
  end


  def show
    set_pin
  end


  def new
    @pin = current_user.pins.build
  end


  def edit
    set_pin
  end


  def create
    @pin = current_user.pins.build(pin_params)
      if @pin.save
        flash[:success] = "Pin created!"
        redirect_to pins_path
      else
        flash.now[:alert] = "Your new pin couldn't be created! Please check the form."
        render :new
      end
  end


  def update
    set_pin
    if @pin.update(pin_params)
      flash[:success] = "Pin updated."
      redirect_to pin_path(@pin)
    else
      flash.now[:alert] = "Update failed. Please check the form."
      render :edit
    end
  end


  def destroy
    set_pin
    @pin.destroy
    flash.now[:alert] = "Pin deleted."
    redirect_to pins_path
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
      unless current_user == @pin.user
        flash[:alert] = "Not authorised to edit this pin"
      end
    end
end
