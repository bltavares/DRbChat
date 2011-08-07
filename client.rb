require File.expand_path('../message.rb', __FILE__)

class Client
  def initialize(server, nick)
    @logger = server
    @updated = Time.new
    @nick = nick.to_s
  end

  def send_msg msg
    s = Message.new(msg.to_s, @nick)
    @logger.log s
  end

  def receive_msg(msg = "")
    msgs = @logger.lasts @updated, msg, @nick
    @updated = Time.new  
    msgs
  end
end
