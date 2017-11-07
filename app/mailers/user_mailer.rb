class UserMailer < ApplicationMailer

  def question_email(sender, message, property_id)
    @message = message
    @sender = sender
    @property = Property.find(property_id)

    mail(to: ENV['EMAIL_RECIPIENT'], subject: "#{@sender} - mensagem sobre #{@property.title}")
  end
end
