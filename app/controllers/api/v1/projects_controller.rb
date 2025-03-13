class Api::V1::ProjectsController < Api::V1::BaseController
  include Authorization

  load_and_authorize_resource

  def index
    @projects = current_user.projects
    render json: {
      data: ActiveModelSerializers::SerializableResource.new(
        @projects, each_serializer: ProjectSerializer
      )
    }
  end

  def show
    render json: {
      data: ActiveModelSerializers::SerializableResource.new(
        @project, serializer: ProjectSerializer
      )
    }
  end

  def create
    @project = current_user.projects.build(project_params)

    if @project.save
      render json: {
        data: ActiveModelSerializers::SerializableResource.new(
          @project, serializer: ProjectSerializer
        )
      }, status: :created
    else
      render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      render json: {
        data: ActiveModelSerializers::SerializableResource.new(
          @project, serializer: ProjectSerializer
        )
      }
    else
      render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @project.destroy
      head :no_content
    else
      render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
