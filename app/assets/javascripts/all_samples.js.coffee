do load_report_form = ->
	$(document).ready(
		()-> $("select#templates").change((e)=>
			template = $(this).find('option:selected').text()
			$.ajax({
				type: "GET",
				url: "/reports/new",
				data: { title: template }
			})
		)
	)

@update_item = update_item = (obj_id, controller)->
	collection = new Array
	$("##{obj_id} div").each(()-> 
		original = $(this).attr('id') 
		changed = $(this).text()
		collection.push([original,changed])
	)
	$('div').attr('contenteditable','false')
	$.ajax({
		type: "PATCH",
		url: "/#{controller}/#{obj_id}",
		data: { collection: collection }
	})
