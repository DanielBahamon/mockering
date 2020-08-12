json.array! @notifications do |notification|
	json.id notification.id
	# json.recipient notification.recipient
	json.actor notification.actor.slug
	json.action notification.action
	json.notifiable do # notification.notifiable
		json.type "a post #{notification.notifiable.class.to_s.underscore.humanize.downcase}"
		"Mocks"
	end
	json.url polymorphic_path(notification.notifiable, anchor: dom_id(notification.notifiable))
end