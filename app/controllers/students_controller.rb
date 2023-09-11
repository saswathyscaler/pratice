class StudentsController < ApplicationController
  # skip_before_action :verify_authenticity_token
  
  before_action :authenticate_user, only: [:create, :edit, :update, :destroy]
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  

  
  # GET /students
  def index
    @students = Student.all
    render json: @students
  end


  # GET /students/1
  def show
    if @student
      render json: @student
    else
      render json: { message: "Student not available" }, status: :not_found
    end
  end


  # POST /students
  def create
    @student = current_user.students.new(student_params)
    if @student.save
      render json: @student, status: :created
    else
      render json: { errors: @student.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  # PATCH/PUT /students/1
  def update
    if @student.update(student_params)
      render json: @student
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  # DELETE /students/1
  def destroy
    @student.destroy
    render json: { message: "Student deleted successfully" }, status: :ok
  end

  private

  def set_student
    @student = current_user.students.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Student not found" }, status: :not_found
  end

  def student_params
    params.require(:student).permit(:first_name, :last_name, :email, :contact_number, :address, :date_of_birth, :rating)
  end

  def record_not_found
    render json: { error: "Student not found" }, status: :not_found
  end


  def authenticate_user
    token = request.headers['Authorization']&.split(' ')&.last
    if token.present? && JsonWebToken.decode(token)
      return true
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  rescue JWT::DecodeError
    render json: { error: "Invalid token" }, status: :unauthorized
  end


end
  
  




  # EXAMPLE FOR CREATE STUDENT
  
  
  # {
  #   "student": {
  #     "first_name": "sim",
  #     "last_name": "Doe",
  #     "email": "simpo.doe@example.com",
  #     "contact_number": "123-456-7890",
  #     "address": "123 Main St",
  #     "date_of_birth": "1990-01-01",
  #     "rating": 85
  #   }
  # }