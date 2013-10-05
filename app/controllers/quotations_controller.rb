class QuotationsController < ApplicationController
  before_action :set_quotation, only: [:show, :edit, :update, :destroy]
  before_filter :load_client, :authenticate_user!

  # GET /quotations
  # GET /quotations.json
  def index
    @quotations = params[:client_id].nil? ? Quotation.all : Quotation.where(client_id: params[:client_id])
  end

  # GET /quotations/1
  # GET /quotations/1.json
  def show
  end

  # GET /quotations/new
  def new
    @quotation = Quotation.new(params.select { |key, _| %w(client_id name status event_date).member? key })
  end

  # GET /quotations/1/edit
  def edit
  end

  # POST /quotations
  # POST /quotations.json
  def create
    @quotation = Quotation.new(quotation_params)
    respond_to do |format|
      if @quotation.save
        format.html { redirect_to quotation_item_details_path(@quotation), notice: 'Quotation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @quotation }
      else
        format.html { render action: 'new' }
        format.json { render json: @quotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotations/1
  # PATCH/PUT /quotations/1.json
  def update
    respond_to do |format|
      if @quotation.update(quotation_params)
        format.html { redirect_to quotation_item_details_path(@quotation), notice: 'Quotation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @quotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotations/1
  # DELETE /quotations/1.json
  def destroy
    @quotation.destroy
    respond_to do |format|
      format.html { redirect_to quotations_url }
      format.json { head :no_content }
    end
  end

  private
  def load_client
    @client = params[:client_id].nil? ? nil : Client.find(params[:client_id]);
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_quotation
    @quotation = Quotation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def quotation_params
    params.require(:quotation).permit(:client_id, :name, :status, :event_date, :venue, :days, :invoice_type)
  end
end
