json.array! @notifications do |notification|
	json.id notification.id
	# json.recipient notification.recipient
	json.actor notification.actor.slug
	json.action notification.action
	if notification.action == "followed"
		json.notifiable do # notification.notifiable
			json.type " <p class='m-0 _text_notification'> started following you.</p> <i class='fas fa-user-plus _icon_notification'></i>"
			"Mocks"
		end
	elsif notification.action == "reviewed"
		json.notifiable do # notification.notifiable
			json.type " <p class='m-0 _text_notification'> has been commented on your mock.</p> <i class='fas fa-comment _icon_notification'></i>"
			"Mocks"
		end
	elsif notification.action == "mentioned"
		json.notifiable do # notification.notifiable
			json.type " <p class='m-0 _text_notification'> has been mentioned in some mock.</p> <i class='fas fa-at _icon_notification _2'></i>"
			"Mocks"
		end
	elsif notification.action == "answered"
		json.notifiable do # notification.notifiable
			json.type " <p class='m-0 _text_notification'> has answered your comment.</p> <i class='fas fa-comments _icon_notification'></i>"
			"Mocks"
		end
	elsif notification.action == "chated"
		json.notifiable do # notification.notifiable
			json.type " <p class='m-0 _text_notification'> has send you a message.</p> <i class='fas fa-comment-alt _icon_notification _2'></i>"
			"Mocks"
		end
	else
		json.notifiable do # notification.notifiable
			json.type " <p class='m-0 _text_notification'> has been posted a new mock.</p> <i class='fas fa-video _icon_notification'></i>"
			"Mocks"
		end
	end
		
	if notification.action == "chated"
		json.url conversation_messages_path(notification.notifiable, anchor: dom_id(notification.notifiable))
	else
		json.url polymorphic_path(notification.notifiable, anchor: dom_id(notification.notifiable))
	end
end 