
require 'block'
require 'odlinter'
require 'logger'
require 'rule'
require 'odlint/report'

module ODLint
  def self.log
    @logger ||= ::Logger.new(STDERR)
  end


  def self.report
    #@reporter ||= ::Logger.new(STDOUT)
    @reporter ||= ODLint::Report.new(STDOUT)
  end
end

