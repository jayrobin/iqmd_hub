class LevelsController < ApplicationController
  # GET /levels
  # GET /levels.json

  #skip_before_filter :verify_authenticity_token, only: :create

  def index
    @levels_latest = Level.limit(10).order("created_at desc").all
    @levels_popular = Level.limit(10).order("plays desc").all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @levels }
    end
  end

  # GET /levels/1
  # GET /levels/1.json
  def show
    @level = Level.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @level }
    end
  end

  # GET /levels/new
  # GET /levels/new.json
  def new
    @level = Level.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @level }
    end
  end

  # GET /levels/1/edit
  def edit
    @level = Level.find(params[:id])
  end

  # POST /levels
  # POST /levels.json
  def create
    puts "ENV"
    puts ENV["S3_BUCKET_NAME"]
    path = File.join("public/levels/icons", "#{Time.now.getutc}.png")
    file = File.open(path, "wb") { |f| f.write(Base64.decode64(params[:icon])) }

    file = File.open(path, "r")
    @level = Level.new(tiles: params[:tiles], objects: params[:objects], enemies: params[:enemies], icon: file)
    file.close

    if @level.save
      #create_icon_for @level
      render json: @level, status: :created, location: @level
    else
      render json: @level.errors, status: :unprocessable_entity
    end
  end

  def create_icon_for(level)
    #file = File.open()
    #path = File.join("public/levels/icons", "#{@level.id}.png")
    #File.open(path, "wb") { |f| f.write(Base64.decode64(params[:icon])) }
  end

  # PUT /levels/1
  # PUT /levels/1.json
  def update
 #   @level = Level.find(params[:id])

#    respond_to do |format|
#      if @level.update_attributes(params[:level])
#        format.html { redirect_to @level, notice: 'Level was successfully updated.' }
#        format.json { head :no_content }
#      else
#        format.html { render action: "edit" }
#        format.json { render json: @level.errors, status: :unprocessable_entity }
#      end
#    end
  end

  # DELETE /levels/1
  # DELETE /levels/1.json
  def destroy
  end

  def load
    @level = Level.find(params[:id])
    @level.update_attribute(:plays, @level.plays + 1)

    render json: @level
  end
end
