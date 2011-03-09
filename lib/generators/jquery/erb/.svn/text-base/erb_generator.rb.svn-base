require 'generators/jquery'
require 'rails/generators/resource_helpers'

module Jquery
  module Generators
    class ErbGenerator < Base
      include Rails::Generators::ResourceHelpers
      
      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"
      
      class_option :views, :type => :boolean, :default => true

      def create_root_folder
        return unless options[:views]
        empty_directory File.join("app/views", controller_file_path)
      end

      def copy_view_files
        return unless options[:views]
        available_views.each do |view|
          filename = filename_with_extensions(view, :html)
          template filename, File.join("app/views", controller_file_path, filename)
        end
      end

      # handling these separately so we can rename file
      def copy_record_partials
        return unless options[:views]
        to_filename = "_#{singular_table_name}.html.erb"
        template "_record.html.erb", File.join("app/views", controller_file_path, to_filename)
      end

      def copy_js_view_files
        return unless options[:views]
        available_js_views.each do |view|
          filename = filename_with_extensions(view, :js)
          template filename, File.join("app/views", controller_file_path, filename)
        end
      end

      protected
        def available_views
          %w(index edit show new _form _list_actions _detail_actions _detail_info _error_messages _record_body _record_detail)
        end

        def available_js_views
          %w(edit show update destroy error)
        end

        def filename_with_extensions(name, prefix)
          [name, prefix, :erb].compact.join(".")
        end
    end
  end
end
