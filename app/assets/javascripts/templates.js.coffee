# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
do update_template = ->
	$(document).ready(
		()-> $("button#ok").click((e)=>
			main_div = $('div').first().attr('id')
			collection = new Array
			$("##{main_div} div").each(()-> 
				original = $(this).attr('id') 
				changed = $(this).text()
				collection.push([original,changed])
			)
			$('div').attr('contenteditable','false')
			$.ajax({
				type: "PATCH",
				url: "/admin/templates/#{main_div}",
				data: { collection: collection }
			})
		)
	)