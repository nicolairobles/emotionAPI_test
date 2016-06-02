class ResultMailer < ApplicationMailer
  default from: "emotize.it@gmail.com"
 
  def send_results(recipient)
    @recipients = recipient["email"]
    mail(to: @recipients, subject: "
Your Emotize Results are ready!")
  end

end
