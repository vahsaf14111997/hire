class UserMailer < ApplicationMailer
  def send_email mail_data
    @mail_data = JSON.parse mail_data

    mail(to: @mail_data["email"], subject: "SPRITLE FRESHERS DRIVE - REGISTRATION SUCCESS!")
  end
end
