class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  # GET /payments
  # GET /payments.json
  def index
    if !params[:client_id].nil?
      @payments = Payment.where(:client_id => params[:client_id]).order(:updated_at).reverse_order
    else
      @payments = Payment.all.order(:updated_at).reverse_order
    end
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
    @payment.client = params[:client_id].nil? ? @payment.client : Client.find(params[:client_id]);
  end

  # GET /payments/1/edit
  def edit
    authorize @payment

  end

  def print
    respond_to do |format|
      format.pdf do
        pdf = PrintPayment.new
        send_data pdf.render, filename: "print_payment.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)
    User.current_user = current_user
    @payment.payment_added_by = User.current_user.email

    respond_to do |format|
      if @payment.save
        format.html { redirect_to payments_path(:client_id => @payment.client.id), notice: 'Payment was successfully created.' }
        format.json { render action: 'index', status: :created, location: @payment }
      else
        format.html { render action: 'new' }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    authorize @payment

    respond_to do |format|
      User.current_user = current_user
      @payment.payment_last_modified_by = User.current_user.email

      if @payment.update(payment_params)
        format.html { redirect_to payments_path(:client_id => @payment.client.id), notice: 'Payment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    authorize @payment

    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url(:client_id => @payment.client.id) }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:client_id, :description, :mode, :paid_on, :amount, :payment_type, :payment_added_by, :payment_last_modified_by)
    end
end
