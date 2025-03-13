module Projects
  class Create < ApplicationService
    attr_reader :user, :params, :project, :errors

    def initialize(user, params)
      @user = user
      @params = params
      @errors = []
    end

    def call
      @project = @user.projects.build(project_params)

      @errors = @project.errors.full_messages unless @project.save

      self
    end

    def success?
      @errors.empty?
    end

    def status
      :unprocessable_entity
    end

    private

    def project_params
      params.require(:project).permit(:name, :description)
    end
  end
end
