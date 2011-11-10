# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	$('ul.sf-menu').superfish({
		animation: {height:'show'},
		delay: 400
	})
	
	$('.item-interaction .hp').fadeTo(1,0.01)
			
	$('.item-request').each ->
		# $(this).toggle \
		# 	( -> 
		# 		$(this).next(':first').fadeTo(400, 1.0)
		# 		$(this).find('a').text('Withdraw')
		# 		status=$(this).find('a').attr('href')
		# 	)
		# 	,
		# 	( -> 
		# 		$(this).next(':first').fadeTo(400, 0.01)
		# 		$(this).find('a').text('I want')
		# 		status=''
		# 	)
	
		$(this).hover \
			( ->
				$(this).addClass('item-request-background')
			)
			,
			( ->
				$(this).removeClass('item-request-background')				
			)
			
	# $('.item-info .category-tag').each ->
	# 	$(this).click -> 
	# 		status=$(this).find('a').attr('href')
	# 		
	# 	$(this).css('cursor','pointer')
	
	
	
	
	
	