class StudentsController < ApplicationController
  include AppImport['create_student', 'welcome_student', 'all_students', 'find_student']
  include Dry::Monads::Either::Mixin

  def index
    @students = all_students.call.or do |students|
      flash[:alert] = 'Could not load all students. Please check with your system administrator.'
      Left(students)
    end.value
  end

  def new
    @student = Student.new
  end

  def show
    find_student.call(params[:id]).fmap do |student|
      @student = student
    end.or_fmap do
      flash[:error] = 'Ocurred an error when loading student.'
      redirect_to students_url
    end
  end

  def create
    create_student.call(student_params).bind do |student|
      welcome_student.call(student).fmap do
        flash[:notice] = 'Student created succesfully.'
        redirect_to student_url(id: student.id)
      end.or_fmap do
        flash[:alert] = 'Student created but failed to welcome him.'
        redirect_to student_url(id: student.id)
      end
    end.or do |student|
      flash[:error] = 'Failed to create student.'
      @student = student
      render :new, status: :conflict
    end
  end

  private

  def student_params
    params.require(:student).permit(*%i[first_name last_name email])
  end
end
