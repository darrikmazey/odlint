require 'hashie'
require 'optparse'

module ODLint

  class Options < ::Hashie::Mash
    def initialize
      super

      self.ignored_classes = []
    end
  end

  class OptionParser < ::OptionParser
    def initialize
      super

      self.banner = "USAGE: #{$0} [OPTIONS] FILES"

      self.on('-i CLASS', '--ignore CLASS', 'ignore warning class') do |klass|
        ODLint.options.ignored_classes << klass
      end

      self.on('-L', '--list', 'list rules') do
        puts self.to_s
        puts " "
        LintRule.rules.map(&:to_s).sort.each do |r|
          puts r
        end
        exit(0)
      end

      self.on_tail('-?', '--help', 'this help text') do
        puts self.to_s
        exit(0)
      end
    end

  end

end
