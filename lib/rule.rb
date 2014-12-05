
class LintRule

  def match?(line)
    return !!matches?(line)
  end

  def handle_line(line, filename, line_num)
  end

  def self.rules
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end

  def self.warning
    raise "this should be overridden in subclasses"
  end

end
