# Preview all emails at http://localhost:3000/rails/mailers/result_mailer
class ResultMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/result_mailer/name:string
  def name:string
    ResultMailer.name:string
  end

  # Preview this email at http://localhost:3000/rails/mailers/result_mailer/email:string
  def email:string
    ResultMailer.email:string
  end

end
