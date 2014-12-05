
require 'odlint'

module Reportable

  def reporter_class
    @reporter_class ||= self.class
  end

  def log_prefix
    @log_prefix ||= reporter_class.to_s
  end

  
  def self.included(base)
    base.send(:define_method, :warn!) do |str = nil|
      report = ODLint.report
      report << reporter_class
      #report.warn("#{report.filename.ljust(50)}:#{report.line_num.to_s.rjust(5)}  : #{"<#{reporter_class.to_s}>".ljust(40)} #{str ? str : reporter_class.warning}")
      report.warn("#{report.filename.ljust(50)}:#{report.line_num.to_s.rjust(5)}  : #{str ? str : reporter_class.warning}")
    end
  end
end
