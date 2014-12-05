
class Block
  def initialize(type, sline, eline = nil)
    @type = type
    @sline = sline
    @eline = eline
  end


  def type
    @type
  end


  def sline=(sline)
    @sline = sline
  end


  def eline=(eline)
    @eline = eline
  end


  def to_s
    "#{@sline},#{@eline}"
  end

end

