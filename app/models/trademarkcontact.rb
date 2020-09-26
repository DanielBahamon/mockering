class Trademarkcontact < MailForm::Base
  attributes :name,  :validate => true
  attributes :email, :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attributes :title
  attributes :company_name
  attributes :relationship_owner
  attributes :kind_company
  attributes :url
  attributes :specification
  attributes :nickname,  :captcha  => true

  def headers 
  	{
	  	:subject => "Trademark Complaint",
	  	:to => "mockering.com@gmail.com",
	  	:from => %("#{name}" <#{email}>)
  	}
  end
end