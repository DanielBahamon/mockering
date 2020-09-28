class Forgerycontact < MailForm::Base
  attributes :name,  :validate => true
  attributes :email, :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attributes :title
  attributes :country
  attributes :company_name
  attributes :trademark_name
  attributes :business_address
  attributes :business_website
  attributes :trademark
  attributes :registration_number
  attributes :product_issue
  attributes :clarify
  attributes :url
  attributes :i_believe
  attributes :i_agree
  attributes :fullname
  attributes :nickname,  :captcha  => true

  def headers 
  	{
	  	:subject => "Forgery Complaint",
	  	:to => "mockering.com@gmail.com",
	  	:from => %("#{name}" <#{email}>)
  	}
  end
end