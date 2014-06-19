module Guard
  class JRubyMinitest
    class AppPathsReloader
      extend TestPaths

      def self.run(paths)

        paths.select{|p| !in_test_folders?(p)}.each do |p|
          if File.exists?(p)
            Containment.new.protect { load p }
          end
        end
      end
    end
  end
end
