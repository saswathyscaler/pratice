class EmployeesController < ApplicationController

    before_action :set_employee, only: [:show, :edit, :update, :destroy]
    skip_before_action :verify_authenticity_token # Disable CSRF protection for API
  
    # Show all employees in JSON format
    def index
      @employees = Employee.all
      render json: @employees
    end
  
    # Show a single employee by ID in JSON format
    def show
      render json: @employee
    end
  
    # Create a new employee via JSON
    def create
      @employee = Employee.new(employee_params)
      if @employee.save
        render json: @employee, status: :created
      else
        render json: @employee.errors, status: :unprocessable_entity
      end
    end
  
    # Update employee details via JSON
    def update
      if @employee.update(employee_params)
        render json: @employee
      else
        render json: @employee.errors, status: :unprocessable_entity
      end
    end
  
    # Delete an employee via JSON
    def destroy
      @employee.destroy
      head :no_content
    end
  
    private
  
    def set_employee
      @employee = Employee.find(params[:id])
    end
  
    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :email, :contact_number, :address, :date_of_birth)
    end
  end
  


  
  # EXAMPLE FOR CREATE STUDENT
  
  
#   {
#     "student": {
#       "first_name": "John",
#       "last_name": "Doe",
#       "email": "john.doe@example.com",
#       "contact_number": "123-456-7890",
#       "address": "123 Main St",
#       "date_of_birth": "1990-01-01",
#       "rating": 85
#     }
#   }