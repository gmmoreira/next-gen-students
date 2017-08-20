class SendEmail
  include Concerns::ServiceConcern

  def call(email)
    Right(email).bind do |email|
      # send email here
      Rails.logger.info("Email sent to #{email}")
      Right(email)
    end
  end
end
