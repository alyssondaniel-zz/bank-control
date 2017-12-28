class BankAgenciesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bank_agency, only: [:show, :edit, :update, :destroy]

  # GET /bank_agencies
  # GET /bank_agencies.json
  def index
    @bank_agencies = BankAgency.all
  end

  # GET /bank_agencies/1
  # GET /bank_agencies/1.json
  def show
  end

  # GET /bank_agencies/new
  def new
    @bank_agency = BankAgency.new
  end

  # GET /bank_agencies/1/edit
  def edit
  end

  # POST /bank_agencies
  # POST /bank_agencies.json
  def create
    @bank_agency = BankAgency.new(bank_agency_params)

    respond_to do |format|
      if @bank_agency.save
        format.html { redirect_to @bank_agency, notice: 'Bank agency was successfully created.' }
        format.json { render :show, status: :created, location: @bank_agency }
      else
        format.html { render :new }
        format.json { render json: @bank_agency.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bank_agencies/1
  # PATCH/PUT /bank_agencies/1.json
  def update
    respond_to do |format|
      if @bank_agency.update(bank_agency_params)
        format.html { redirect_to @bank_agency, notice: 'Bank agency was successfully updated.' }
        format.json { render :show, status: :ok, location: @bank_agency }
      else
        format.html { render :edit }
        format.json { render json: @bank_agency.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bank_agencies/1
  # DELETE /bank_agencies/1.json
  def destroy
    @bank_agency.destroy
    respond_to do |format|
      format.html { redirect_to bank_agencies_url, notice: 'Bank agency was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank_agency
      @bank_agency = BankAgency.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bank_agency_params
      params.require(:bank_agency).permit(:number, :zip, :street, :city, :state, :country)
    end
end
