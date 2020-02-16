class ApplicationMailer < ActionMailer::Base
  after_action :amazon_send_email

  default from: "vannam051096@gmail.com"
  layout "mailer"

  private
  def amazon_send_email
    mail.perform_deliveries = false
    ses_params = {
      destination: {
        to_addresses: mail.to_addrs
      },
      message: {
        body: body_type(mail.mime_type, mail.body.raw_source, mail.charset),
        subject: {
          charset: mail.charset,
          data: mail.subject
        }
      },
      source: "<#{mail.from.join}>"
    }

    begin
      ses_response = AMAZON_SES.send_email ses_params
      p "FINISHED"
    rescue StandardError => e
      p "FAILED: #{e.message}"
    end
  end

  def body_type mime_type, body, mail_charset
    type = mime_type == "text/plain" ? :text : :html

    {
      type => {
        charset: mail_charset,
        data: body
      }
    }
  end
end
