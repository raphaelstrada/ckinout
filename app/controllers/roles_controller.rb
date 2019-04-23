class RolesController < ApplicationController
  before_action :set_role, only: [:show, :update, :destroy]

  # GET /roles
  def index
    @roles = Role.all
    # render json: @roles
    json_response(@roles) 
  end

  # GET /roles/1
  def show
    # render json: @role
    json_response(@role) 
  end

  # POST /roles
  def create
    # @role = Role.new(role_params)
    @role = Role.create!(role_params)
    if @role.save
      # render json: @role, status: :created, location: @role
      json_response(@role, :created) 
    else
      # render json: @role.errors, status: :unprocessable_entity
      json_response(@role.error, :error) 
    end
  end

  # PATCH/PUT /roles/1
  def update
    if @role.update(role_params)
      # render json: @role
      head :no_content
    else
      # render json: @role.errors, status: :unprocessable_entity
      json_response(@role.error, :error)
    end
  end

  # DELETE /roles/1
  def destroy
    @role.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def role_params
      params.permit(:description)
      # params.require(:role).permit(:description)
    end
end
