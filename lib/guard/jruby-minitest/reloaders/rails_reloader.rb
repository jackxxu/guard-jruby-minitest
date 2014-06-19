module Guard
  class JRubyMinitest
    class RailsReloader
      def self.run(*)
        if defined? ::ActionDispatch::Reloader
          Containment.new.protect do
            ActionDispatch::Reloader.cleanup!
            ActionDispatch::Reloader.prepare!
          end
        end
      end
    end
  end
end
