class Trademarkcontact < MailForm::Base
  attribute :name, validate: true
  attribute :email, validate: /\A[^@\s]+@[^@\s]+\z/i
  attribute :type, validate: ["General", "Interface bug"]
  attribute :message, validate: true

  def headers 
  	{
	  	:subject => "Trademark Form",
	  	:to => "mockering.com@gmail.com",
	  	:from => %("#{name}" <#{email}>)
  	}
  end
end