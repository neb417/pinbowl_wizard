class MatchesController < ApplicationController
  before_action :set_match, only: %i[ show edit update destroy submit_match_result ]

  # GET /matches or /matches.json
  def index
    @matches = Match.all
  end

  # GET /matches/1 or /matches/1.json
  def show
  end

  # GET /matches/new
  def new
    @match = Match.new
  end

  # GET /matches/1/edit
  def edit
  end

  # POST /matches or /matches.json
  def create
    @match = Match.new(match_params)

    respond_to do |format|
      if @match.save
        format.html { redirect_to @match, notice: "Match was successfully created." }
        format.json { render :show, status: :created, location: @match }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @match.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /matches/1 or /matches/1.json
  def update
    respond_to do |format|
      if @match.update(match_params)
        format.html { redirect_to @match, notice: "Match was successfully updated." }
        format.json { render :show, status: :ok, location: @match }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @match.errors, status: :unprocessable_content }
      end
    end
  end

  def submit_match_result
    CalculateMatchResults.call(player_matches: format_player_match_params(match_player_match_params[:player_matches_attributes]))
  end

  # DELETE /matches/1 or /matches/1.json
  def destroy
    @match.destroy!

    respond_to do |format|
      format.html { redirect_to matches_path, status: :see_other, notice: "Match was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def match_params
      params.expect(match: [ :id, :flight_id, :machine_id ])
    end

    def match_player_match_params
      params.expect(match: [ :id, :flight_id, :machine_id, player_matches_attributes: [ [ :id, :score, :user_id ] ] ])
    end

    def format_player_match_params(params)
      {
        player_1: {
          id: params["0"][:id].to_i,
          user_id: params["0"][:user_id].to_i,
          score: params["0"][:score].to_i
        },
        player_2: {
          id: params["1"][:id].to_i,
          user_id: params["1"][:user_id].to_i,
          score: params["1"][:score].to_i
        }
      }
    end
end
