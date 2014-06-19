require 'ruby_parser'

module Guard
  class JRubyMinitest
    class TestPathsReloader
      extend TestPaths

      def self.run(paths)
        paths.select{|p| in_test_folders?(p)}.each do |p|
          if File.exists?(p)
            Containment.new.protect { unload p; load p }
          end
        end
      end

      def self.unload(path)
        code = RubyParser.new.parse(IO.read(path))
        test_classes = []
        test_classes << code[1] if code[0] == :class
        code.each_of_type(:class) {|c| test_classes << c[1] if c[1].is_a?(Symbol) }
        test_classes.each do |c|
          Object.send(:remove_const, c) if Object.const_defined?(c)
        end
      end
    end
  end
end
