class RoundsController < ApplicationController
  before_action :set_round, only: %i[ show edit update destroy ]

  # GET /rounds or /rounds.json
  def index
    @rounds = Round.all
  end

  # GET /rounds/1 or /rounds/1.json
  def show
  end

  # GET /rounds/new
  def new
    @round = Round.new
  end

  # GET /rounds/1/edit
  def edit
  end

  # POST /rounds or /rounds.json
  def create
    @round = Round.new(round_params)

    # create matches between players and machines

    respond_to do |format|
      if @round.save
        format.html { redirect_to @round, notice: "Round was successfully created." }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_content }
        format.turbo_stream
      end
    end
  end

  # PATCH/PUT /rounds/1 or /rounds/1.json
  def update
    respond_to do |format|
      if @round.update(round_params)
        format.html { redirect_to @round, notice: "Round was successfully updated." }
        format.json { render :show, status: :ok, location: @round }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @round.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /rounds/1 or /rounds/1.json
  def destroy
    @round.destroy!

    respond_to do |format|
      format.html { redirect_to rounds_path, status: :see_other, notice: "Round was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_round
      @round = Round.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def round_params
      params.expect(round: [ :season_id, :number ])
    end
end
