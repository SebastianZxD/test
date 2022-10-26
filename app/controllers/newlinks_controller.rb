class NewlinksController < ApplicationController
  before_action :set_newlink, only: %i[ show edit update destroy ]

  # GET /newlinks or /newlinks.json
  def index
    @newlinks = Newlink.all
  end

  # GET /newlinks/1 or /newlinks/1.json
  def show
  end

  # GET /newlinks/new
  def new
    @newlink = Newlink.new
  end

  # GET /newlinks/1/edit
  def edit
  end

  # POST /newlinks or /newlinks.json
  def create
    @newlink = Newlink.new(newlink_params)

    respond_to do |format|
      if @newlink.save
        format.html { redirect_to newlink_url(@newlink), notice: "Newlink was successfully created." }
        format.json { render :show, status: :created, location: @newlink }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @newlink.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /newlinks/1 or /newlinks/1.json
  def update
    respond_to do |format|
      if @newlink.update(newlink_params)
        format.html { redirect_to newlink_url(@newlink), notice: "Newlink was successfully updated." }
        format.json { render :show, status: :ok, location: @newlink }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @newlink.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /newlinks/1 or /newlinks/1.json
  def destroy
    @newlink.destroy

    respond_to do |format|
      format.html { redirect_to newlinks_url, notice: "Newlink was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_newlink
      @newlink = Newlink.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def newlink_params
      params.require(:newlink).permit(:url, :slug)
    end
end
