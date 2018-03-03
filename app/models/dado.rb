class Dado < ActiveRecord::Base
      # Sends password reset email.
  def send_email
    UserMailer.emailDefinicao(self).deliver_now
  end
end
