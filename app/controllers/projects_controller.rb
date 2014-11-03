class ProjectsController < ApplicationController

  def create
    @project = Project.new(project_params)
    @project.user = current_user

    authorize @project
    if @project.save
      render json: @project.to_json
    else
      render :edit
    end
  end

private

  def project_params
    params.require(:project).permit(:name, :url_name, :description)
  end

end
