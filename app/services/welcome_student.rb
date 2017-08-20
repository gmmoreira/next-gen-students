class WelcomeStudent
  include Concerns::ServiceConcern
  include AppImport['send_email']

  def call(student)
    Right(student.email).bind do |email|
      send_email.call(email)
    end.fmap { student }.or(Left(student))
  end
end
