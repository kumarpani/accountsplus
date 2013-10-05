class ItemDetailsController < ApplicationController
  before_action :set_item_detail, only: [:show, :edit, :update, :destroy]
  before_filter :load_quotation, :authenticate_user!

  # GET /item_details
  # GET /item_details.json
  def index
    @item_details = @quotation.item_details
  end

  # GET /item_details/1
  # GET /item_details/1.json
  def show
    @item_detail = @quotation.item_details.find(params[:id])
  end

  # GET /item_details/new
  def new
    @item_detail = @quotation.item_details.build
  end

  # GET /item_details/1/edit
  def edit
  end

  # POST /item_details
  # POST /item_details.json
  def create
    @item_detail = @quotation.item_details.build(item_detail_params)

    respond_to do |format|
      if @item_detail.save
        format.html { redirect_to quotation_item_details_path(@quotation), notice: 'Item detail was successfully created.' }
        format.json { render action: 'show', status: :created, location: @item_detail }
      else
        format.html { render action: 'new' }
        format.json { render json: @item_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /item_details/1
  # PATCH/PUT /item_details/1.json
  def update
    respond_to do |format|
      if @item_detail.update(item_detail_params)
        format.html { redirect_to quotation_item_details_path(@quotation), notice: 'Item detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @item_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_details/1
  # DELETE /item_details/1.json
  def destroy
    @item_detail.destroy
    respond_to do |format|
      format.html { redirect_to quotation_item_details_path(@quotation) }
      format.json { head :no_content }
    end
  end

  private
  def load_quotation
    @quotation = Quotation.find(params[:quotation_id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_detail
      @item_detail = ItemDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_detail_params
      params.require(:item_detail).permit(:particulars, :price, :quantity, :days, :payment_attributes => [:id, :client_id, :amount])
    end
end
