class FindStudent
  include Concerns::ServiceConcern

  def call(id)
    Try() do
      Student.find id
    end.to_either
  end
end
