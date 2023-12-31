# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Notifications
	constructor: ->
		@notifications = $("[data-behavior='notifications']")
		@setup() if @notifications.length > 0

	setup: ->
		$("[data-behavior='notifications-link']").on "click", @handleClick
		$.ajax(
			url: "/notifications.json"
			dataType: "JSON"
			method: "GET"
			success: @handleSuccess
		)
	handleClick: (e) =>
		$.ajax(
			url: "/notifications/mark_as_read"
			dataType: "JSON"
			method: "POST"
			success: ->
				$("[data-behavior='unread-count']").remove()
		)

	handleSuccess: (data) =>
		items = $.map data, (notification) ->
			"<a class='dropdown-item' href='#{notification.url}'>@#{notification.actor} #{notification.notifiable.type}</a>"


		if items.length > 9 
			itemslength = "+9"
		else
			itemslength = items.length

		if items.length < 1 
			$("[data-behavior='unread-count']").remove()

		if @notifications.length >  0
			$("[data-behavior='unread-count']").addClass("show")

		$("[data-behavior='unread-count']").text(itemslength)

		if items.length < 1
			$("[data-behavior='notification-items']").html("
				<div class='no-notification fullscreen'>
					<div class='d-table fullscreen'>
						<div class='d-tablecell v-middle'>
							<p class=' _text-none-notification'>Everything is okay!</p>
						</div>
					</div>
				</div>")
		else 
			$("[data-behavior='notification-items']").html(items)
jQuery ->
	new Notifications