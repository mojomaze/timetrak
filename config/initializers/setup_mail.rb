# config/initializers/setup_mail.rb

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "localhost",
  :user_name            => "mwinkler@sologroup.com",
  :password             => "hedger08",
  :authentication       => "plain",
  :enable_starttls_auto => true
}