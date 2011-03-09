module Jquery
  module Generators
    class InstallGenerator < Rails::Generators::Base

      desc <<DESC
Description:
    Add jquery 1.4.2, jquery-ui-1.8.1, app base css and images
DESC

      def self.source_root
        @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
      end

      def copy_public_files
        directory 'public'
      end
    end
  end
end
