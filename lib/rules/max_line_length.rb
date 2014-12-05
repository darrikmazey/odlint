
require 'reportable'

class MaxLineLength < LintRule
  include Reportable

  def initialize(max_line_length = 80)
    @max_line_length = max_line_length
  end

  def matches?(line)
    /^.{#{@max_line_length + 1},}/ =~ line
  end

  def handle_line(line, filename, line_num)
    warn!
  end

  def self.warning
    "longer than #{@max_line_length} characters"
  end
end
