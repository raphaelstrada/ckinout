class SchoolsController < ApplicationController
  before_action :set_school, only: [:show, :update, :destroy]

  # GET /schools
  def index
    @schools = School.all
    # render json: @schools
    json_response(@schools) 
  end

  # GET /schools/1
  def show
    # render json: @school
    json_response(@school)
  end

  # POST /schools
  def create
    # @school = School.new(school_params)
    @school = School.create!(school_params)

    if @school.save
      # render json: @school, status: :created, location: @school
      json_response(@school, :created)
    else
      # render json: @school.errors, status: :unprocessable_entity
      json_response(@school.error, :error)
    end
  end

  # PATCH/PUT /schools/1
  def update
    if @school.update(school_params)
      # render json: @school
      # json_response(@schools)
      head :no_content
    else
      # render json: @school.errors, status: :unprocessable_entity
      # json_response(@school.errors, status: :unprocessable_entity)
      json_response(@school.error, :error)
    end
  end

  # DELETE /schools/1
  def destroy
    @school.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school
      @school = School.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def school_params
      # params.require(:school).permit(:name)
      params.permit(:name)
    end
end
