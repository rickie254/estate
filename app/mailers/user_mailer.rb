class UserMailer < ApplicationMailer

  def question_email(sender, message, property_id)
    @message = message
    @property = Property.find(question.property_id)

    mail(to: ENV['EMAIL_RECIPIENT'], from: sender,
      subject: "zordanimoveis.com.br - mensagem sobre #{@property.title}")
  end
end
