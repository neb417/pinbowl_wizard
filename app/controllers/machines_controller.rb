class MachinesController < ApplicationController
  before_action :set_machine, only: %i[ show edit update destroy ]

  # GET /machines or /machines.json
  def index
    @machines = Machine.all
  end

  # GET /machines/1 or /machines/1.json
  def show
  end

  # GET /machines/new
  def new
    @machine = Machine.new
    format_respond_to
  end

  # GET /machines/1/edit
  def edit
  end

  # POST /machines or /machines.json
  def create
    @machine = Machine.new(machine_params)

    respond_to do |format|
      if @machine.save
        format.html { redirect_to machines_path, notice: "Machine was successfully created." }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  # PATCH/PUT /machines/1 or /machines/1.json
  def update
    respond_to do |format|
      if @machine.update(machine_params)
        format.html { redirect_to @machine, notice: "Machine was successfully updated." }
        format.json { render :show, status: :ok, location: @machine }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @machine.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /machines/1 or /machines/1.json
  def destroy
    @machine.destroy!

    respond_to do |format|
      format.html { redirect_to machines_path, status: :see_other, notice: "Machine was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_machine
      @machine = Machine.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def machine_params
      params.expect(machine: [ :name ])
    end
end
