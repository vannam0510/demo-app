class UserMailer < ApplicationMailer

  def send_mail_demo email
    mail(to: email, subject: "Amazon Simple Email Service") do |format|
      format.text
    end
  end
end
