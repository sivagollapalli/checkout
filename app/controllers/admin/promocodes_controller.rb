class Admin::PromocodesController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "admin"
  before_action :set_promocode, only: [:show, :edit, :update, :destroy]

  def index
    @promocodes = Promocode.all
  end

  def show
  end

  def new
    @promocode = Promocode.new
  end

  def edit
  end

  def create
    @promocode = Promocode.new(promocode_params)

    respond_to do |format|
      if @promocode.save
        format.html { redirect_to admin_promocodes_path, notice: 'Promocode was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @promocode.update(promocode_params)
        format.html { redirect_to admin_promocodes_path, notice: 'Promocode was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @promocode.destroy
    respond_to do |format|
      format.html { redirect_to admin_promocodes_url, notice: 'Promocode was successfully destroyed.' }
    end
  end

  private
    def set_promocode
      @promocode = Promocode.find(params[:id])
    end

    def promocode_params
      params.require(:promocode).permit(:name, :promo_type, :value, :used_in_conjuncation)
    end
end
