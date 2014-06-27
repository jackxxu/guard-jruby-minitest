require 'guard/guard'
require 'guard/minitest'
require_relative 'jruby-minitest/version'

module Guard
  class JRubyMinitest < ::Guard::Minitest
    require_relative 'jruby-minitest/containment'
    require_relative 'jruby-minitest/runner'
    require_relative 'jruby-minitest/reloaders/test_paths'
    require_relative 'jruby-minitest/reloaders/rails_reloader'
    require_relative 'jruby-minitest/reloaders/factory_girl_reloader'
    require_relative 'jruby-minitest/reloaders/app_paths_reloader'
    require_relative 'jruby-minitest/reloaders/test_paths_reloader'

    class << self
      attr_accessor :reloaders
      @reloaders = [RailsReloader, AppPathsReloader, FactoryGirlReloader]
    end

    unless Utils.minitest_version_gte_5?
      require_relative 'jruby-minitest/runners/old_runner'
    end

    def initialize(options = {})
      @custom_watchers = options[:watchers]
      general_watchers = [Watcher.new(%r{^(.+)\.rb$}), Watcher.new(%r{^(.+)\.(erb|haml)$})]
      TestPaths.test_folders = options[:test_folders]
      super(options.merge(watchers: general_watchers))
    end

    def run_all
      unload_previous_tests
      super
    end

    %w(run_on_modifications run_on_additions run_on_removals).each do |method_name|
      define_method method_name do |raw_paths = []|
        unload_previous_tests
        reload_application(raw_paths)
        super matched_paths(raw_paths)
      end
    end

    def self.template(plugin_location)
      File.read("#{ plugin_location }/lib/guard/jruby-minitest/templates/Guardfile")
    end

    private

      def matched_paths(raw_paths)
        [].tap do |paths|
          raw_paths.each do |p|
            @custom_watchers.each do |w|
              if (m = w.match(p))
                paths << (w.action.nil? ? p : w.call_action(m))
              end
            end
          end
        end
      end

      def reload_application(paths)
        self.class.reloaders.each do |reloader|
          reloader.run(paths)
        end
      end

      def unload_previous_tests
        if Utils.minitest_version_gte_5?
          ::Minitest::Test.reset
        else
          ::MiniTest::Unit::TestCase.reset
        end
      end
  end
end
