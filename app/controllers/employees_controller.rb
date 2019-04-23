
class EmployeesController < ApplicationController
  before_action :set_school
  before_action :set_school_employee, only: [:show, :update, :destroy]
  before_action :set_school_employee_shifts, only: [:show]
  
  # GET /employees
  def index
    # @employees = Employee.all
    json_response(@school.employees)

    # render json: @employees
  end
  
  # GET /employees/1
  def show
    employee_clocked = @employee.as_json.merge("clocked_in" => !@shift.worked_to.present?, "shift_id_last" => @shift.id)

    json_response(employee_clocked)
  end

  # POST /employees
  def create
    # @employee = Employee.new(employee_params)
    @school.employees.create!(employee_params)
    json_response(@school, :created)
  end

  # PATCH/PUT /employees/1
  def update
    if @employee.update(employee_params)
      # render json: @employee
      head :no_content
    else
      # render json: @employee.errors, status: :unprocessable_entity
      json_response(@employee.error, :error)
    end
  end

  # DELETE /employees/1
  def destroy
    @employee.destroy
    head :no_content
  end

  private
    def set_school
      @school = School.find(params[:school_id])
    end
    
    def set_school_employee
      # @employee = Employee.find(params[:id])
      @employee = @school.employees.find_by!(id: params[:id]) if @school
    end

    def set_school_employee_shifts
      # @employee = Employee.find(params[:id])
      logger.debug "PARAMS: #{params[:employee_id]}"      
      @shift = @employee.shifts.last if @employee
    end

    # Only allow a trusted parameter "white list" through.
    def employee_params
      # params.require(:employee).permit(:school_id, :role_id, :name, :uid, :password, :password, :password_confirmation)
      params.permit(:id, :school_id)
    end

    
end
