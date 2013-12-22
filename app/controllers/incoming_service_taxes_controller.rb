class IncomingServiceTaxesController < ApplicationController
  before_action :set_incoming_service_tax, only: [:show, :edit, :update, :destroy]

  # GET /incoming_service_taxes
  # GET /incoming_service_taxes.json
  def index
    if !params[:start_date].to_s.empty? && !params[:end_date].to_s.empty?
      @s_date = Date.parse(params[:start_date], '%d/%m/%Y')
      @e_date = Date.parse(params[:end_date], '%d/%m/%Y')

      @incoming_service_taxes = IncomingServiceTax.where('invoice_date >= ? AND invoice_date <= ?', @s_date, @e_date).order(:invoice_date)
    end

  end

  # GET /incoming_service_taxes/1
  # GET /incoming_service_taxes/1.json
  def show
  end

  # GET /incoming_service_taxes/new
  def new
    @incoming_service_tax = IncomingServiceTax.new
  end

  # GET /incoming_service_taxes/1/edit
  def edit
  end

  # POST /incoming_service_taxes
  # POST /incoming_service_taxes.json
  def create
    @incoming_service_tax = IncomingServiceTax.new(incoming_service_tax_params)

    respond_to do |format|
      if @incoming_service_tax.save
        format.html { redirect_to @incoming_service_tax, notice: 'Incoming service tax was successfully created.' }
        format.json { render action: 'show', status: :created, location: @incoming_service_tax }
      else
        format.html { render action: 'new' }
        format.json { render json: @incoming_service_tax.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incoming_service_taxes/1
  # PATCH/PUT /incoming_service_taxes/1.json
  def update
    respond_to do |format|
      if @incoming_service_tax.update(incoming_service_tax_params)
        format.html { redirect_to @incoming_service_tax, notice: 'Incoming service tax was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @incoming_service_tax.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incoming_service_taxes/1
  # DELETE /incoming_service_taxes/1.json
  def destroy
    @incoming_service_tax.destroy
    respond_to do |format|
      format.html { redirect_to incoming_service_taxes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incoming_service_tax
      @incoming_service_tax = IncomingServiceTax.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def incoming_service_tax_params
      params.require(:incoming_service_tax).permit(:invoice_number, :invoice_date, :description, :event_total, :service_tax)
    end
end
