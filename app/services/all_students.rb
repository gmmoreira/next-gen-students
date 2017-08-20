class AllStudents
  include Concerns::ServiceConcern

  def call
    Try() do
      Student.all
    end.to_either
      .or do
      Left([])
    end
  end
end
