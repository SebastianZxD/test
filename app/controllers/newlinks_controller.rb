class NewlinksController < ApplicationController
  before_action :set_newlink, only: %i[ show edit update destroy ]
  before_action :check_expired
  # GET /newlinks or /newlinks.json
  def index
    @newlinks = Newlink.all
  end

  # GET /newlinks/1 or /newlinks/1.json
  def show
    begin
      response = HTTParty.get(@newlink.url, timeout: 5)
    rescue Net::ReadTimeout
      begin
        response = HTTParty.get(@newlink.url, timeout: 5)
      rescue Net::ReadTimeout
        @refined_title = 'Sadly your webpage is down, but the title will refresh when its back up'
      else
        extracted_title = response.body.match(/<title>(.*?)<*title>/)
        extracted_title[1].slice!("</")
        @refined_title = extracted_title[1]
      end
    rescue OpenSSL::SSL::SSLError
      @refined_title = 'I have no idea whats going on with that webpage of yours.. but this is not the title'
    else
      extracted_title = response.body.match(/<title>(.*?)<*title>/)
      extracted_title[1].slice!("</")
      @refined_title = extracted_title[1]
    end
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
      params.require(:newlink).permit(:url, :slug, :expire)
    end

    def check_expired
      @newlinks = Newlink.all

      @newlinks.each do |link|
        if !link.expire.future?
        link.destroy
        end
      end 
    end
end
