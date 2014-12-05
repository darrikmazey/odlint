
require 'rule'
require 'reportable'

class EmptyLines < LintRule
  include Reportable

  def initialize(between_method_definitions = 2, max_lines_in_methods = 1)
    @current_blocks = []
    @between_methods = false


    @empty_line_count = 0
    @lines_between_method_definitions = between_method_definitions
    @lines_in_methods = max_lines_in_methods
    @last_block_type = nil
  end


  def matches?(line)
    true
  end


  def handle_line(line, filename, line_num)
    if line =~ /\b(if|do|begin|def|class|module)\b/
      block = Block.new($1, line_num)
      @current_blocks << block
      @last_block_type = block.type
      warn(filename, line_num) if block.type == 'def' and @between_methods
      reset!
    elsif line =~ /\bend\b/ and !@current_blocks.empty?
      block = @current_blocks.pop
      block.eline = line_num
      if block.type == 'def'
        @between_methods = true
        @empty_line_count = 0
      else
        reset!
      end
    elsif line =~ /^\s*$/
      #ODLint.log.debug("blank line: #{@between_methods}")
      @empty_line_count += 1
    elsif line !~ /^\s*$/
      warn(filename, line_num) if !@current_blocks.empty? and @current_blocks.last.type == 'def' and !@between_methods
      reset!
    end
  end

  def self.warning
    "incorrect number of blank lines in some context"
  end

  private

  def reset!
    @between_methods = false
    @empty_line_count = 0
    if @current_blocks.empty?
      @last_block_type = nil
    else
      @last_block_type = @current_blocks.last.type
    end
  end

  def warn(filename, line_num)
    if @between_methods and @empty_line_count != @lines_between_method_definitions
      warn!("#{@empty_line_count} blank line#{@empty_line_count == 1 ? '' : 's'} between method definitions")
    elsif !@between_methods and !@current_blocks.empty? and @current_blocks.last.type == 'def' and @empty_line_count > @lines_in_methods
      warn!("#{@empty_line_count} blank line#{@empty_line_count == 1 ? '' : 's'} inside method definition")
    end
  end

end

