class Trademarkcontact < MailForm::Base
  attributes :name,  :validate => true
  attributes :email, :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attributes :message
  attribute :nickname,  :captcha  => true

  def headers 
  	{
	  	:subject => "Trademark Form",
	  	:to => "mockering.com@gmail.com",
	  	:from => %("#{name}" <#{email}>)
  	}
  end
end