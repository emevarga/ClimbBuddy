require 'geokit'

class ClimbDataController < ApplicationController
  # GET /climb_data
  # GET /climb_data.json
  def index
    if params[:dist] && params[:lat] && params[:lng] && (params[:dist].to_i >= 0)
      if params[:filter] == 'closest'
        @climb_data = ClimbDatum.geo_scope(:within => params[:dist], :origin => [params[:lat],params[:lng]]).order("distance ASC")
      elsif
        @climb_data = ClimbDatum.geo_scope(:within => params[:dist], :origin => [params[:lat],params[:lng]])
        logger.debug "cats #{@climb_data.count}"
        #@climb_data = ClimbDatum.climb_within(params[:dist], :options => {:origin => [params[:lat],params[:lng]]})
      end
    end

      my_conditions = {}
      my_conditions[:skill_level] = params[:min_difficulty].to_i..params[:max_difficulty].to_i if params[:min_difficulty] && params[:max_difficulty]
      my_conditions[:climb_type] = params[:climb_type] if params[:climb_type]
     

    if !@climb_data
      @climb_data = ClimbDatum.find(:all, :conditions => my_conditions)
    else 
      
      if my_conditions[:skill_level]  
        @climb_data.delete_if {|x| x.skill_level < params[:min_difficulty].to_i}
        @climb_data.delete_if {|x| x.skill_level > params[:max_difficulty].to_i}
      end
      
      if params[:climb_type]
        @climb_data.delete_if {|x| x.climb_type != params[:climb_type]}  
      end
      
      if params[:filter] 
        if params[:filter] == 'closest'
          #@climb_data = @climb_data.sort { |a,b| b.dist <=> a.dist }
        elsif params[:filter] == 'hardest'
          @climb_data = @climb_data.sort { |a,b| b.skill_level <=> a.skill_level }
        end         
      end

    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @climb_data }
    end
  end

  # GET /climb_data/1
  # GET /climb_data/1.json
  def show
    @climb_datum = ClimbDatum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @climb_datum }
    end
  end

  # GET /climb_data/new
  # GET /climb_data/new.json
  def new
    @climb_datum = ClimbDatum.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @climb_datum }
    end
  end

  # GET /climb_data/1/edit
  def edit
    @climb_datum = ClimbDatum.find(params[:id])
  end

  # POST /climb_data
  # POST /climb_data.json
  def create
    @climb_datum = ClimbDatum.new(params[:climb_datum])

    respond_to do |format|
      if @climb_datum.save
        format.html { redirect_to @climb_datum, notice: 'Climb datum was successfully created.' }
        format.json { render json: @climb_datum, status: :created, location: @climb_datum }
      else
        format.html { render action: "new" }
        format.json { render json: @climb_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /climb_data/1
  # PUT /climb_data/1.json
  def update
    @climb_datum = ClimbDatum.find(params[:id])

    respond_to do |format|
      if @climb_datum.update_attributes(params[:climb_datum])
        format.html { redirect_to @climb_datum, notice: 'Climb datum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @climb_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /climb_data/1
  # DELETE /climb_data/1.json
  def destroy
    @climb_datum = ClimbDatum.find(params[:id])
    @climb_datum.destroy

    respond_to do |format|
      format.html { redirect_to climb_data_url }
      format.json { head :no_content }
    end
  end
end
