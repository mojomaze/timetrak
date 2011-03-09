require 'rails/generators/named_base'

module Jquery
  module Generators
    class Base < Rails::Generators::NamedBase #:nodoc:
      def self.source_root
        @_jquery_source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'jquery', generator_name, 'templates'))
      end
    end
  end
end
