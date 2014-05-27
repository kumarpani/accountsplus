class QuotationsController < ApplicationController
  before_action :set_quotation, only: [:show, :edit, :update, :destroy]
  before_filter :load_client

  # GET /quotations
  # GET /quotations.json
  def index
    @quotations = params[:client_id].nil? ? Quotation.all : Quotation.where(client_id: params[:client_id])
    @quotations = params[:status].nil? ? @quotations : @quotations.keep_if {|q| params[:status].include? q.status}

    @quotations = @quotations.sort_by {|e| e[:event_date]}.reverse

  end

  # GET /quotations/1
  # GET /quotations/1.json
  def show
  end

  # GET /quotations/new
  def new
    @quotation = Quotation.new(params.select { |key, _| %w(client_id event_name status event_date).member? key })
  end

  def duplicate
    @new_dup_q = Quotation.find(params[:quotation_id]).clone_with_associations
    redirect_to quotation_item_details_path(@new_dup_q)
  end

  # GET /quotations/1/edit
  def edit
    # Do not allow to edit the quotations unless it is open for editing
    if !@quotation.is_open_for_edits?
      redirect_to quotation_item_details_path(@quotation)
    end
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
      User.current_user = current_user
      if @quotation.update(quotation_params)
        format.html { redirect_to quotation_item_details_path(@quotation), notice: 'Quotation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @quotation.errors, status: :unprocessable_entity }
      end
    end
  end

  def markAsPaymentsFullyReceived
    @quotation = Quotation.find(params[:quotation_id])

    if @quotation.update_attribute(:payment_received_in_full, true)
      redirect_to quotation_item_details_path(@quotation)
    else
      format.html { render action: 'edit' }
      format.json { render json: @quotation.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /quotations/1
  # DELETE /quotations/1.json
  def destroy
    authorize @quotation

    @quotation.destroy
    respond_to do |format|
      format.html { redirect_to quotations_path(:client_id => @quotation.client_id) }
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
    params.require(:quotation).permit(:client_id, :event_name, :status, :event_date, :venue, :days, :invoice_type, :notes, :order_placed_by, :tac => [])
  end
end
