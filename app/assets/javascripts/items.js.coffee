# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	$('#item-categories-block li a').click ->
		category_string = $(this).text()
		category_string = category_string.substring(0, category_string.length - 2)
		$('form.new_item :text').attr('value',category_string)
		return false