class Suggestion < MailForm::Base
  attributes :name,  :validate => true
  attributes :email, :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attributes :kind_suggestions
  attributes :message
  attributes :i_agree
  attributes :nickname,  :captcha  => true

  def headers 
  	{
	  	:subject => "Suggestions",
	  	:to => "mockering.com@gmail.com",
	  	:from => %("#{name}" <#{email}>)
  	}
  end
end