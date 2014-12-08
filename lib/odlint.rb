
require 'block'
require 'odlinter'
require 'logger'
require 'rule'
require 'odlint/report'
require 'odlint/options'

module ODLint
  @@options = Options.new
  @@option_parser = OptionParser.new


  def self.options
    @@options
  end


  def self.log
    @logger ||= ::Logger.new(STDERR)
  end


  def self.report
    #@reporter ||= ::Logger.new(STDOUT)
    @reporter ||= ODLint::Report.new(STDOUT)
  end

  @@option_parser.parse!

end

