
require 'reportable'

class NoTrailingSpace < LintRule
  include Reportable

  def matches?(line)
    /\s+$/ =~ line
  end


  def handle_line(line, filename, line_num)
    warn!
  end

  def self.warning
    "trailing whitespace"
  end

end
