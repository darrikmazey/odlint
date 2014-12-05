
require 'rule'
require 'reportable'

class PreferBracesToDoEnd < LintRule
  include Reportable

  def initialize
    @current_blocks = []
  end


  def matches?(line)
    nline = line.gsub(/(["']).*?\1/, '')
    /\b(if|do|end)\b/ =~ nline and /^\s*#/ !~ nline
  end


  def handle_line(line, filename, line_num)
    line.gsub!(/(["']).*?\1/, '')
    if line =~ /\b(if|do)\b/
      @current_blocks << Block.new($1, line_num)
    elsif line =~ /\bend\b/ and !@current_blocks.empty?
      block = @current_blocks.pop
      block.eline = line_num
      warn! if block.type == 'do'
    end
  end

  def self.warning
    "do...end block"
  end

end
