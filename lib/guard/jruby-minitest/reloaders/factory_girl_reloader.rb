module Guard
  class JRubyMinitest
    class FactoryGirlReloader
      def self.run(*)
        if defined? ::FactoryGirl
          Containment.new.protect { FactoryGirl.reload }
        end
      end
    end
  end
end
