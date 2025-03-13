module Projects
  class Update < ApplicationService
    attr_reader :user, :project_id, :params, :project, :errors

    def initialize(user, project_id, params)
      @user = user
      @project_id = project_id
      @params = params
      @errors = []
    end

    def call
      find_project
      update_project if @project

      self
    end

    def success?
      @errors.empty?
    end

    def status
      :unprocessable_entity
    end

    private

    def find_project
      @project = Project.find(project_id)
    rescue ActiveRecord::RecordNotFound
      raise ApiExceptions::ResourceNotFoundError.new('Project')
    end

    def update_project
      unless @project.update(project_params)
        @errors = @project.errors.full_messages
      end
    end

    def project_params
      params.require(:project).permit(:name, :description)
    end
  end
end
