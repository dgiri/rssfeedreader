class RssfeedsController < ApplicationController
	before_filter :authenticate_user!
  # GET /rssfeeds
  # GET /rssfeeds.json
  def index
    @feedsurls = current_user.rssfeeds
    @rssfeeds = @feedsurls.paginate :page => params[:page], :per_page => 1, :order => "created_at DESC"
    
    @rssfeed = Rssfeed.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rssfeeds }
    end
  end

  # GET /rssfeeds/1
  # GET /rssfeeds/1.json
  def show
    @rssfeed = Rssfeed.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rssfeed }
    end
  end

  # GET /rssfeeds/new
  # GET /rssfeeds/new.json
  def new
    @rssfeed = Rssfeed.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rssfeed }
    end
  end

  # GET /rssfeeds/1/edit
  def edit
    @rssfeed = Rssfeed.find(params[:id])
  end

  # POST /rssfeeds
  # POST /rssfeeds.json
  def create
    @rssfeed = Rssfeed.new(params[:rssfeed])
    @rssfeed.user_id = current_user.id
    respond_to do |format|
      if @rssfeed.save
        format.html { redirect_to @rssfeed, notice: 'Rssfeed was successfully created.' }
        format.json { render json: @rssfeed, status: :created, location: @rssfeed }
        format.js{}
      else
        format.html { render action: "new" }
        format.json { render json: @rssfeed.errors, status: :unprocessable_entity }
        format.js{}
      end
    end
  end

  # PUT /rssfeeds/1
  # PUT /rssfeeds/1.json
  def update
    @rssfeed = Rssfeed.find(params[:id])

    respond_to do |format|
      if @rssfeed.update_attributes(params[:rssfeed])
        format.html { redirect_to @rssfeed, notice: 'Rssfeed was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @rssfeed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rssfeeds/1
  # DELETE /rssfeeds/1.json
  def destroy
    @rssfeed = Rssfeed.find(params[:id])
    @rssfeed.destroy

    respond_to do |format|
      format.html { redirect_to rssfeeds_url, notice: 'Rssfeed was successfully deleted.'  }
      format.json { head :no_content }
    end
  end
end
