# frozen_string_literal: true

module RestApiGenerator
  module ControllerCallbacks
    extend ActiveSupport::Concern
    include ActiveSupport::Callbacks

    included do
      define_callbacks :set_resource
      define_callbacks :set_parent_resource
    end

    module ClassMethods
      # Code from rails source code
      [:before, :after, :around].each do |callback|
        define_method "#{callback}_set_resource" do |*names, &blk|
          _insert_callbacks(names, blk) do |name, options|
            set_callback(:set_resource, callback, name, options)
          end
        end

        define_method "#{callback}_set_parent" do |*names, &blk|
          _insert_callbacks(names, blk) do |name, options|
            set_callback(:set_parent_resource, callback, name, options)
          end
        end
      end
    end
  end
end
