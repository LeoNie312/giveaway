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
	
	$('div#homepage-choices div').each ->
		$(this).hover \
			( ->
				$(this).addClass('big-div-mouseover')
			)
			,
			( ->
				$(this).removeClass('big-div-mouseover')
			)