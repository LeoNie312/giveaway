jQuery ->
	# ajaxify locations sidebar
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
	
	# add mouseover effects to three big div
	$('div#homepage-choices div.round').each ->
		$(this).hover \
			( ->
				$(this).addClass('big-div-mouseover')
			)
			,
			( ->
				$(this).removeClass('big-div-mouseover')
			)
		
		
	# slideDown and slideUp effects
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
	
	# turn 'just browse' div to a link
	$('div#homepage-choices div#browse-div').click ->
		window.location = $(this).find('a').attr('href')