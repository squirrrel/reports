class Admin::TemplatesController < ApplicationController
	before_action :authenticate_user!

	def new
	end

	# TODO: reload _list partial only!!
	def create
		permitted_params = params.require(:template).permit!
		
		Template.create_record(permitted_params)
		
		redirect_to action: 'index'
	end

	def index
		@templates = Template.get_all
		
		respond_to do |format|
			format.js { render 'index.js.erb' }
		end
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
