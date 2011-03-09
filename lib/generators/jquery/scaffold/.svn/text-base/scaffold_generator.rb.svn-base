require 'generators/jquery'
require 'rails/generators/resource_helpers'

module Jquery
  module Generators
    class ScaffoldGenerator < Base
      include Rails::Generators::ResourceHelpers
      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

      class_option :orm, :desc => "ORM used to generate the controller"
      class_option :template_engine, :desc => "Template engine to generate view files"
      class_option :views, :type => :boolean, :default => true
      class_option :routes, :type => :boolean, :default => true
      class_option :color_dark, :type => :string, :default => '#A2C0DA', :desc => "CSS dark color"
      class_option :color_medium, :type => :string, :default => '#DAE6F0', :desc => "CSS medium color"
      class_option :color_light, :type => :string, :default => '#FAFAFF', :desc => "CSS light color"
      
      hook_for :orm
      
      hook_for :scaffold_controller
  
    end
  end
end
