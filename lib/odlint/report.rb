
require 'logger'

module ODLint
  class Report
    attr_accessor :filename, :line_num

    def initialize(output)
      @log = Logger.new(output)
      @filename = nil
      @line_num = nil
      @warnings = {}
    end

    def warn(msg)
      @log.warn(msg)
    end

    def <<(report_class)
      @warnings[report_class] ||= 0
      @warnings[report_class] += 1
    end

    def log_warning_stats
      @warnings.keys.each do |report_class|
        @log.info "#{report_class.to_s}: #{@warnings[report_class]}"
      end
    end
  end
end
