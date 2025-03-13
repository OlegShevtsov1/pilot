class ApplicationController < ActionController::API
  before_action :authenticate_user!

  def authenticate_user!
    # This will be overridden in the base controller
  end

  protected

  # Render a JSON response with filtered fields
  # @param resource [Object] The resource to serialize
  # @param fields [Array<Symbol>] List of fields to include in the response
  # @param options [Hash] Additional serialization options
  def render_with_fields(resource, fields, options = {})
    # Convert fields array to AMS-compatible format
    fields_hash = {}

    # If resource is a collection, set fields for the collection type
    if resource.respond_to?(:model_name)
      # Single resource
      fields_hash[resource.class.name.underscore.to_sym] = fields
    elsif resource.respond_to?(:klass)
      # Collection of resources
      fields_hash[resource.klass.name.underscore.to_sym] = fields
    end

    # Merge fields with other options and render
    render json: resource, fields: fields_hash, **options
  end
end
