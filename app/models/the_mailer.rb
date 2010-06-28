class TheMailer < ActionMailer::Base
  
  def new_name_notification(name)
    recipients "aguvench@gmail.com"
    from       "aguvench@gmail.com"
    subject    "#{name.user.login} suggested a new name!"
    sent_on    Time.now
    body       :name=>name
  end

end
