class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :prepare_params, only: :create
  before_action :set_transaction, only: [:show, :edit, :update, :destroy, :chargeback]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.where(bank_account_id: current_user.current_bank_account_id).order(created_at: :asc)
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    redirect_to new_transaction_path(type: :credit) unless params["type"]
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        if params["transaction"]["transaction_type_key"] == "transfer"
          bank_account_destination = BankAccount.find(params["transaction"]["bank_account_destination"])
          @transaction.transfer_to(bank_account_destination.id)
        end
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def chargeback
    if @transaction.chargeback
      respond_to do |format|
        format.html { redirect_to transactions_url, notice: 'Transaction was successfully chargeback.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to transactions_url, notice: 'Transaction was rejected for chargeback.' }
        format.json { head :no_content }
      end
    end

  end

  def new_type
    @transaction = Transaction.new
    @transaction_type = params[:type]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:bank_account_id, :amount, :transaction_type, :user_id)
    end

    def prepare_params
      params["transaction"]["user_id"] = current_user.id
      params["transaction"]["transaction_type"] = (params["transaction"]["transaction_type_key"] == "transfer") ? "debit" : params["transaction"]["transaction_type_key"]
    end
end
