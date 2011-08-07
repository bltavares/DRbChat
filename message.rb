class Message
  attr :date, :msg, :nick

  def initialize msg, nick
    @msg = msg
    @nick = nick
    @date = Time.new
  end

  def to_s
    nick + ": " + msg  
  end
end
