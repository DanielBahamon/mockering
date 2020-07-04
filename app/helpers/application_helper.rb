module ApplicationHelper
  def avatar_url(mocker)
  	if mocker.provider != "facebook" && !mocker.photo?
		mocker.image
	elsif mocker.provider == "facebook" && !mocker.photo?
		if mocker.image
	      "https://graph.facebook.com/#{mocker.uid}/picture?type=large"
	    else
	      gravatar_id = Digest::MD5::hexdigest(mocker.email).downcase
	      "https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identicon&s=150"
	    end
	else
		mocker.photo.url(:medium)
	end

    # if mocker.image
    #   "https://graph.facebook.com/#{mocker.uid}/picture?type=large"
    # else
    #   gravatar_id = Digest::MD5::hexdigest(mocker.email).downcase
    #   "https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identicon&s=150"
    # end
  end
end


									
