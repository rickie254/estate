class QuestionsController < ApplicationController
  def create
    question = Question.new question_params

    if question.valid?
      UserMailer.question_email(question.email, question.message, question.property_id).deliver_later
      flash[:notice] = "Mensagem enviada! Responderemos ao seu e-mail o mais breve possível."
    else
      flash[:alert] = "Ocorreu um problema com a sua mensagem, por favor, tente novamente."
    end

    property = Property.find(question.property_id)
    redirect_to property
  end

  private

  def question_params
    params.require(:question).permit(:email, :message, :property_id)
  end
end
