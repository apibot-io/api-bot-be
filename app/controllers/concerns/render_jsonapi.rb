module RenderJsonapi
  extend ActiveSupport::Concern

  included do
    def render_jsonapi(*args)
      options = args.extract_options!
      collection = args.first

      serializer_key = options[:serializer] || compute_collection_type(collection)
      serializer_class_name = compute_serializer_name(serializer_key)
      serializer_options = build_jsonapi_options(options)

      serialized_collection = serializer_class_name.new(collection, serializer_options)
      status = options[:status] || :ok

      render json: serialized_collection.serializable_hash, status: status
    end
  end

  private

  def compute_collection_type(collection)
    collection_class = if collection.is_a?(ActiveRecord::Relation)
                         collection.klass
                       else
                         collection.class
                       end

    collection_class.base_class.name.to_sym
  end

  def compute_serializer_name(serializer_key)
    return serializer_key unless serializer_key.is_a?(Symbol)

    serializer_name = "#{serializer_key.to_s.classify}Serializer"
    serializer_name.constantize
  end

  def build_jsonapi_options(options)
    json_options = {
      params: options[:params] || {},
      meta: options[:meta] || {}
    }

    includes = options[:include]
    if includes.present?
      json_options[:include] = includes_array(includes)
    end

    json_options
  end

  def includes_array(includes)
    includes.is_a?(Array) ? includes : [includes]
  end
end
