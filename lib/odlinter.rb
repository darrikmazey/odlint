
class ODLinter
  def self.instance
    @@inst
  end
      

  def initialize(default_rules= nil)
    @rules = []
    @@inst = self
    load_rules
    if default_rules == :all
      add_rules LintRule.rules
    end
  end


  def lint(filename)
    File.open(filename, 'r') { |f|
      f.each_line.with_index { |line, idx|
        line.sub!(/\n$/, '')
        @rules.each do |rule|
          if rule.match?(line)
            ODLint.report.filename = filename
            ODLint.report.line_num = idx + 1
            rule.handle_line(line, filename, idx + 1)
          end
        end
      }
    }
  end

  def add_rule(*rule_class)
    rule_classes = [rule_class].flatten
    rule_classes.each { |rule|
      if rule.is_a?(Class)
        @rules << rule.new
      else
        @rules << rule
      end
    }
  end
  alias_method :add_rules, :add_rule

  private

  def load_rules
    Dir.glob(File.expand_path(File.join(Dir.pwd, 'lib/rules/*.rb'))).each { |file|
      require file
    }
  end
end
