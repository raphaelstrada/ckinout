class ShiftsController < ApplicationController
  before_action :set_school
  before_action :set_school_employee
  before_action :set_school_employee_shift, only: [:show, :update, :destroy]
  

  # GET /shifts
  def index
    # @shifts = Shift.all
    # render json: @shifts
    @newShifts = [];
    
    @employee.shifts.each do |shift|
      if shift.uploads.attached?
        if shift.uploads.attachments().length <= 1
          snapshot_blob_from = shift.snapshot_from.present? ? url_for( shift.uploads.attachments().find(shift.snapshot_from) ) : ""
          snapshot_blob_to = ""
          # logger.debug "snapshot_blob_from #{shift.snapshot_from.present?}"
        else
          snapshot_blob_from = shift.snapshot_from.present? ? url_for( shift.uploads.attachments().find(shift.snapshot_from) ) : ""
          snapshot_blob_to = shift.snapshot_to.present? ? url_for( shift.uploads.attachments().find(shift.snapshot_to) ) : ""
        end
        @newShift = @newShift.as_json.merge("snapshot_blob_from" => snapshot_blob_from, "snapshot_blob_to" => snapshot_blob_to) 
      else
        @newShift = shift
      end
      @newShifts << @newShift
    end
    json_response(@newShifts) 
    
  end

  # GET /shifts/1
  def show
    

    if @shift.uploads.attached?
      if @shift.uploads.attachments().length <= 1
        snapshot_blob_from = @shift.snapshot_from.present? ? url_for( @shift.uploads.attachments().find(@shift.snapshot_from) ) : ""
        snapshot_blob_to = ""
        @shift_with_snapshot = @shift.as_json.merge("snapshot_blob_from" => snapshot_blob_from, "snapshot_blob_to" => snapshot_blob_to)  
      else
        snapshot_blob_from = @shift.snapshot_from.present? ? url_for( @shift.uploads.attachments().find(@shift.snapshot_from) ) : ""
        snapshot_blob_to = @shift.snapshot_to.present? ? url_for( @shift.uploads.attachments().find(@shift.snapshot_to) ) : ""
        @shift_with_snapshot = @shift.as_json.merge("snapshot_blob_from" => snapshot_blob_from, "snapshot_blob_to" => snapshot_blob_to)  
      end
    else
      @shift_with_snapshot = @shift
    end   
    

    
    
    json_response(@shift_with_snapshot)
  end

  # POST /shifts
  def create
    # @employee.shifts.uploads.attach(params[:uploads])
    @shift = @employee.shifts.create!(shift_params)
    if params[:uploads]
      @snapshot_from = @shift.uploads.attach(params[:uploads])  
      @shift.update(:snapshot_from => @snapshot_from.last.id)
    end
    
    employee_clocked = @employee.as_json.merge("clocked_in" => "false", "shift_id_last" => @employee.shifts.last.id)
    json_response(employee_clocked, :created)   
    
    
    # if @shift.save
    #   # render json: @shift, status: :created, location: @shift
    #   json_response(@shift, status: :created)
    # else
    #   # render json: @shift.errors, status: :unprocessable_entity
    #   json_response(@shift.errors, :error)
    # end
  end

  # PATCH/PUT /shifts/1
  def update
    if @shift.update(shift_params)
      
      if params[:uploads]
        @snapshot_to = @shift.uploads.attach(params[:uploads]) 
        @shift.update(:snapshot_to => @snapshot_to.last.id)
      end
      
      employee_clocked = @employee.as_json.merge("clocked_in" => !@shift.worked_to.present?, "shift_id_last" => params[:id])
      json_response(employee_clocked)
      
    else
      # render json: @shift.errors, status: :unprocessable_entity
      json_response(@employee.errors, :error)
    end
  end

  # DELETE /shifts/1
  def destroy
    @shift.destroy
    head :no_content
  end

  private
    
    def set_school
      @school = School.find(params[:school_id])
      logger.debug "School: #{@school.attributes.inspect}"
    end
    
    def set_school_employee
      # @employee = Employee.find(params[:id])
      @employee = @school.employees.find_by!(id: params[:employee_id]) if @school
      logger.debug "Employee: #{@employee.attributes.inspect}"

    end

    def set_school_employee_shift
      # @employee = Employee.find(params[:id])
      @shift = @employee.shifts.find_by!(id: params[:id]) if @employee
      logger.debug "Shift: #{@shift.attributes.inspect}"
    end

    # def set_employee
    #   @employee = Employee.find(params[:employee_id])
    # end

    # def set_employee_shift
    #   @shift = @employee.shifts.find_by!(id: params[:id]) if @employee
    # end


    # Only allow a trusted parameter "white list" through.
    def shift_params
      params.permit(:worked_from, :worked_to, :business_day, uploads: [])      

      #params.permit(:name)
    end
end
