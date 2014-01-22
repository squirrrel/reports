# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
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