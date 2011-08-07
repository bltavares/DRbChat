require "drb/drb"
require File.expand_path('../message.rb', __FILE__)

class Logger
  def initialize
    @chat = [] 
  end

  def log msg
    @chat << msg
  end

  def lasts date, msg, nick
    @chat.select { |m| m.date > date && m.nick != nick && m.msg != msg }
  end
end


DRb.start_service "druby://localhost:8888", Logger.new

puts "Server online at localhost:8888"
DRb.thread.join
