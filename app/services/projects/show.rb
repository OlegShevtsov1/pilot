module Projects
  class Show < ApplicationService
    attr_reader :user, :project_id, :project, :errors

    def initialize(user, project_id)
      @user = user
      @project_id = project_id
      @errors = []
    end

    def call
      find_project

      self
    end

    def success?
      @errors.empty?
    end

    def status
      return :not_found if @errors.include?('Project not found')
      :unprocessable_entity
    end

    private

    def find_project
      @project = Project.find(project_id)
    rescue ActiveRecord::RecordNotFound
      @errors << 'Project not found'
    end
  end
end
