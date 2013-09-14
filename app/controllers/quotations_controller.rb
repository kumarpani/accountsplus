class QuotationsController < ApplicationController
  before_action :set_quotation, only: [:show, :edit, :update, :destroy]
  before_filter :load_client

  # GET /quotations
  # GET /quotations.json
  def index
    @quotations = @client.quotations
  end

  # GET /quotations/1
  # GET /quotations/1.json
  def show
    @quotation = @client.quotations.find(params[:id])
  end

  # GET /quotations/new
  def new
    @quotation = @client.quotations.build
  end

  # GET /quotations/1/edit
  def edit
    @quotation = @client.quotations.find(params[:id])
  end

  # POST /quotations
  # POST /quotations.json
  def create
    @quotation = @client.quotations.build(params[:quotation])
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
        format.html { redirect_to client_quotations_path(@client), notice: 'Quotation was successfully updated.' }
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
    @client = Client.find(params[:client_id])
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_quotation
    @quotation = Quotation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def quotation_params
    params.require(:quotation).permit(:client_id)
  end
end
