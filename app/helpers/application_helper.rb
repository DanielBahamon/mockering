module ApplicationHelper
  def avatar_url(mocker)

	if mocker == nil
	      "https://mockering.s3-sa-east-1.amazonaws.com/assets/avatar-placeholder.png"
  	elsif mocker.provider != "facebook" && !mocker.photo?
	    if mocker.image
	      mocker.image
	    else
	      gravatar_id = Digest::MD5::hexdigest(mocker.email).downcase
	      "https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identicon&s=150"
	    end
	elsif mocker.provider == "facebook" && !mocker.photo?
        "https://graph.facebook.com/#{mocker.uid}/picture?type=large"
	else
		mocker.photo.url(:medium)
	end

  end

end


def toastr_flash
  flash.each_with_object([]) do |(type, message), flash_messages|
    type = 'success' if type == 'notice'
    type = 'error' if type == 'alert'
    text = "<script>toastr.#{type}('#{message}') </script>"
    flash_messages << text.html_safe if message
  end.join("\n").html_safe
end
									
