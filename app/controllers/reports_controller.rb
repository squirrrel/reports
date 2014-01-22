class ReportsController < ApplicationController
  before_action :authenticate_user!

  def new
    @template = Template.find_by_(params[:title])
    
    respond_to do |format|
      format.js { render 'new.js.erb' }
    end
  end

  def edit
  end

  def update
  end

  # TODO: reload _list partial only!!
  def create
    title = params.permit(:title)
    permitted_params = params.require(:report).permit!
    
    Report.create_record(permitted_params
                          .merge(title)
                          .merge(user_id: current_user.id))
    
    redirect_to action: 'index'
  end

  def index
    @templates = Template.get_all.map { |template| template[:title] }
    @reports = Report.get_all(current_user: current_user.id)
    
    respond_to do |format|
      format.html { render 'index' }
      format.js { render 'index.js.erb' }
    end
  end

  def destroy
    Report.delete_record(params[:id])
    render js: "$('##{params[:id]}').remove();"
  end
end
