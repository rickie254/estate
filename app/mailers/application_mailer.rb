class ApplicationMailer < ActionMailer::Base
  default from: ENV['ZOHO_MAIL']
  layout 'mailer'
end
