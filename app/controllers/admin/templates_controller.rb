class Admin::TemplatesController < ApplicationController
	def new
	end

	def create
		permitted_params = params.require(:template).permit!
		Template.create_record(permitted_params)
		redirect_to action: 'new'
	end

	def index
		@templates = Template.get_all
	end

	# TODO: move all the js's to separate files where they belong
	def destroy
		Template.delete_record(params[:id])
		render js: "$('##{params[:id]}').remove();"
	end

	def edit
		render js: "$('div##{params[:id]} div').attr('contenteditable','true');
								$('button#ok').css('display', 'inline');"
	end

	# TODO: instead of location.reload() I should reload the main div only by a new partial or whatever
	def update
		Template.update_record(params)
		render js: "$('button#ok').css('display', 'none');
								location.reload();"
	end
end
