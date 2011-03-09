require 'generators/jquery'
require 'rails/generators/resource_helpers'

module Jquery
  module Generators
    class ScaffoldControllerGenerator < Base
      include Rails::Generators::ResourceHelpers
      
      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"
      
      class_option :orm, :desc => "ORM used to generate the controller"
      class_option :template_engine, :desc => "Template engine to generate view files"
      class_option :routes, :type => :boolean, :default => true
      class_option :color_dark, :type => :string, :default => '#A2C0DA', :desc => "CSS dark color"
      class_option :color_medium, :type => :string, :default => '#DAE6F0', :desc => "CSS medium color"
      class_option :color_light, :type => :string, :default => '#FAFAFF', :desc => "CSS light color"
      
      check_class_collision :suffix => "Controller"

      def create_controller_files
        template 'controller.rb', File.join('app/controllers', class_path, "#{controller_file_name}_controller.rb")
      end

      # create js files under public/javascipts/app/controller
      def create_js_root_folder
        empty_directory File.join("public/javascripts", "app")
        empty_directory File.join("public/javascripts/app", controller_file_path)
      end

      # copy over js files
      def copy_js_files
        available_js.each do |name|
          filename = [name, :js].compact.join(".")
          template filename, File.join("public/javascripts/app", controller_file_path, filename)
        end
      end

      # create css files under public/stylesheets/app/controller
      def create_css_root_folder
        empty_directory File.join("public/stylesheets", "app")
        empty_directory File.join("public/stylesheets/app", controller_file_path)
      end

      # copy over js files
      def copy_css_files
        available_css.each do |name|
          filename = [name, :css].compact.join(".")
          to_filename = "#{plural_table_name}.css"
          template filename, File.join("public/stylesheets/app", controller_file_path, to_filename)
        end
      end
      
      def add_resource_route
        return unless options[:routes]
        route_config =  class_path.collect{|namespace| "namespace :#{namespace} do " }.join(" ")
        route_config << "resources :#{file_name.pluralize} do \n"
        route_config << "    collection do \n"
        route_config << "      post :list_action \n"
        route_config << "    end\n"
        route_config << "  end"
        route_config << " end" * class_path.size
        route route_config
      end

      hook_for :test_framework, :as => :scaffold

      # Invoke the helper using the controller name (pluralized)
      hook_for :helper do |invoked|
        invoke invoked, [ controller_name ]
      end
      
      hook_for :template_engine

      protected
        def available_js
          %w(list detail)
        end

        def available_css
          %w(controller)
        end
    end
  end
end
