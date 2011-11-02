jQuery ->
	$('div#sidebar.locations :submit').each ->
		$(this).hover \
			( ->
				$(this).addClass('location-mouseover')
			)
			,
			( ->
				$(this).removeClass('location-mouseover')
			)
		
		$(this).click ->
			$('body').find('.location-chosen')
				.removeClass('location-chosen')
				
			$(this).addClass('location-chosen')
			
			new_location = $(this).attr('value')
			$('span#current-location').text(new_location)