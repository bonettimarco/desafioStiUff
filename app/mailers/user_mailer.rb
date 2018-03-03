class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.emailDefinicao.subject
  #
  def emailDefinicao(dado)
    @user = dado
    mail to: 'marco_bonetti@uol.com.br', subject: "Ativação de e-mail"
    mail to: 'rennanoliveira@id.uff.br', subject: "Ativação de e-mail"
  end
end
