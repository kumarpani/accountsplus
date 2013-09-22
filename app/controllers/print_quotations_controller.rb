class PrintQuotationsController < ApplicationController
  layout 'print'
  before_action :set_print_quotation, only: [:show, :edit, :update, :destroy]
  before_filter :load_quotation;
  # GET /print_quotations
  # GET /print_quotations.json
  def index
  end

  private
  def load_quotation
    @quotation = Quotation.find(params[:quotation_id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_print_quotation
      @print_quotation = PrintQuotation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def print_quotation_params
      params[:print_quotation]
    end
end
