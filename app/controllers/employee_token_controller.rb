class EmployeeTokenController < ApplicationController
    before_action :set_school
    before_action :set_school_employee, only: [:validate_uid, :validate_password]
    
    def validate_uid
        @employee = Employee.find_by!(uid: params[:uid]) if @school
        sleep(2)
        json_response(@employee)
    end

    def validate_password
        @employee = Employee.find_by!(uid: params[:uid], password: params[:password]) if @employee
        json_response(@employee)
    end

    
    private
        def set_school
            @school = School.find(params[:school_id])
        end
        
        def set_school_employee
            @employee = @school.employees.find_by!(uid: params[:uid]) if @school
        end
        
        def employee_params
            params.permit(:school_id, :uid, :password)
        end

end
