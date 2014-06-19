require 'minitest/unit'

module Guard
  class Minitest
    class Runner

      def _run_command(paths, all)
        $LOAD_PATH << 'test' unless $LOAD_PATH.include?('test')
        paths.each {|path| reload path, all}

        # if ::MiniTest.respond_to?(:run) # minitest 5
        if Utils.minitest_version_gte_5?
          ::MiniTest.run(ARGV)
          ::MiniTest.class_variable_get(:@@after_run).reverse_each(&:call)
        else
          ::Minitest::Unit.runner = nil # resets the runner for minitest
          ::MiniTest::Unit.new.run(ARGV)
          ::MiniTest::Unit.class_variable_get(:@@after_tests).reverse_each(&:call)
        end
      end

      private

        def reload(path, all)
          if all
           load path
          else
            ::Guard::JRubyMinitest::TestPathsReloader.run([path])
          end
        end

    end
  end
end


