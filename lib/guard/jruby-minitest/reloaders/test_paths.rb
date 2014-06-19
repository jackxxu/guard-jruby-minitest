module Guard
  class JRubyMinitest
    module TestPaths
      extend self

      attr_writer :test_folders

      def test_folders
        @test_folders ||= ['test', 'spec']
      end

      def in_test_folders?(path)
        test_folders.any? {|folder| path.start_with?("#{folder}/")}
      end
    end
  end
end
