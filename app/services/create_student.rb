class CreateStudent
  include Concerns::ServiceConcern

  def call(params)
    Right(Student.new(params)).bind do |student|
      student.save ? Right(student) : Left(student)
    end
  end
end
