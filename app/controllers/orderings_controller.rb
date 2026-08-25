# frozen_string_literal: true

class OrderingsController < ApplicationController
  def new
    @ordering = Ordering.new(order: current_order)
  end

  def create
    @ordering = Ordering.new(ordering_params)
    respond_to do |format|
      if @ordering.save
        format.html { redirect_to root_path, notice: 'Заказ оформлен' }
      else
        format.html { render :new }
        format.json { render json: @ordering.errors, status: :unprocessable_content }
      end
    end
  end

  private

  def ordering_params
    params.require(:ordering).permit(:name, :address, :phone, :order_id, :city_id, :order_status_id)
  end
end
