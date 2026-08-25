# frozen_string_literal: true

class OrderingsController < ApplicationController
  def new
    @ordering = Ordering.new(order: current_order)
  end

  def create
    @ordering = Ordering.new(ordering_params)
    respond_to do |format|
      if @ordering.save
        # rubocop:disable Rails/I18nLocaleTexts -- the whole app hardcodes
        # Russian strings (every view too); extracting just this one
        # notice would be inconsistent without a real i18n pass across
        # the app, which is out of scope here.
        format.html { redirect_to root_path, notice: 'Заказ оформлен' }
        # rubocop:enable Rails/I18nLocaleTexts
      else
        # Turbo Drive requires a non-2xx status on a form-submission
        # response it's supposed to just re-render in place (a bare 200
        # here throws "Form responses must redirect to another
        # location" client-side) - found by actually submitting the
        # checkout form in a real browser, not from reading the code.
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @ordering.errors, status: :unprocessable_content }
      end
    end
  end

  private

  def ordering_params
    params.require(:ordering).permit(:name, :address, :phone, :order_id, :city_id, :order_status_id)
  end
end
