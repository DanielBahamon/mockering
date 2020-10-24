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

	def markdown(text)
	  renderer = Redcarpet::Render::SmartyHTML.new(filter_html: true, 
	                                               hard_wrap: true, 
	                                               prettify: true)
	  markdown = Redcarpet::Markdown.new(renderer, markdown_layout)
	  markdown.render(sanitize(text)).html_safe
	end

	def markdown_layout
	  { autolink: true, space_after_headers: true, no_intra_emphasis: true,
	    tables: true, strikethrough: true, highlight: true, quote: true,
	    fenced_code_blocks: true, disable_indented_code_blocks: true,
	    lax_spacing: true }
	end

	def toastr_flash
	  flash.each_with_object([]) do |(type, message), flash_messages|
	    type = 'success' if type == 'notice'
	    type = 'error' if type == 'alert'
	    text = "<script>toastr.#{type}('#{message}') </script>"
	    flash_messages << text.html_safe if message
	  end.join("\n").html_safe
	end

	def badge_icon(mocker)
		if mocker.verification == '0'
			"https://mockering.s3-sa-east-1.amazonaws.com/assets/images/badges/badge-verification.svg"
		elsif mocker.verification == '1'
			"https://mockering.s3-sa-east-1.amazonaws.com/assets/images/badges/badge-contribuitor.svg"
		elsif mocker.verification == '2'
			"https://mockering.s3-sa-east-1.amazonaws.com/assets/images/badges/badge-contribuitor-master.svg"
		elsif mocker.verification == '3'
			"https://mockering.s3-sa-east-1.amazonaws.com/assets/images/badges/badge-contribuitor-legend.svg"
		end
	end

	def tooltip_badge(mocker)
		if mocker.verification == '0'
			'Verificated'
		elsif mocker.verification == '1' 
			'Contributor Learner'
		elsif mocker.verification == '2'
			'Contributor Master'
		elsif mocker.verification == '3'
			'Contributor Legend'
		end
	end


	def paginate(collection, params= {})
		will_paginate collection, params.merge(:renderer => RemoteLinkPaginationHelper::LinkRenderer)
	end

end