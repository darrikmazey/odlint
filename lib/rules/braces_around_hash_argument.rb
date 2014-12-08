
require 'rule'
require 'reportable'

class BracesAroundHashArgument < LintRule
  include Reportable

  def matches?(line)
    /\((.*, *)?\{(\s*.*? ?=> ?.*?\s*,?)\1*}\)/ =~ line and /^\s*#/ !~ line
  end

  def handle_line(line, filename, line_num)
    warn!
  end

  def whatever
    puts('this', {:this => :that})
    puts('this', {:this => :that, :whatever => 'this'})
    puts('this', {   :this=>:that, :whatever =>'this'   })
  end

  def self.warning
    "unnecessary braces around hash argument"
  end

end
