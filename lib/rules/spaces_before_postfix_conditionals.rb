
require 'rule'
require 'reportable'

class SpacesBeforePostfixConditionals < LintRule
  include Reportable

  def initialize(required_spaces_before_postfix_conditional = 2)
    @required_spaces = required_spaces_before_postfix_conditional
  end

  def matches?(line)
    /^\s*#/ !~ line and /[^ ]+ {1,#{@required_spaces - 1}}\b(if|unless|rescue).*\w+\b/ =~ line or /[^ ]+ {#{@required_spaces + 1},}\b(if|unless|rescue).*\w+\b/ =~ line
  end
  
  def handle_line(line, filename, line_num)
    warn!("#{@required_spaces} space#{@required_spaces == 1 ? '' : 's'} required before postfix conditional")
  end

end

