begin
  require 'pry'
rescue LoadError
end

if RUBY_PLATFORM != "java"
  require 'coveralls'
  Coveralls.wear!
end

require 'fist_of_fury'

Dir[File.join(File.dirname(__FILE__), 'fixtures/**/*.rb')].each do |fixture|
  require fixture
end

FistOfFury.logger = Logger.new(nil)
# Celluloid.logger = Logger.new(nil)

RSpec.configure do |config|
  config.after(:each) do
    # Make sure supervisor is fake
    class ::FistOfFury::Supervisor
      def self.clock
        @clock ||= FistOfFury::Clock.new
      end

      def self.dispatcher
        @dispatcher ||= FistOfFury::Dispatcher.new
      end
    end

    FistOfFury.configure_with_defaults
  end
end
