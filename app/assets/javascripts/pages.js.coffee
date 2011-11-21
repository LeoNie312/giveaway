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
	
	$('div#homepage-choices div.round').each ->
		$(this).hover \
			( ->
				$(this).addClass('big-div-mouseover')
			)
			,
			( ->
				$(this).removeClass('big-div-mouseover')
			)
		
		
	
	$('div#homepage-choices div.clickable-dropdown').toggle \
		( ->
			$('.big-div-clickable').next().slideUp('fast')
			$('.big-div-clickable').removeClass('big-div-clickable')
			$(this).addClass('big-div-clickable')
			$(this).next().slideDown('slow')
		)
		,
		( ->
			$(this).removeClass('big-div-clickable')
			$(this).next().slideUp('fast')
		)
	
	$('div#homepage-choices div#browse-div').click ->
		window.location = $(this).find('a').attr('href')