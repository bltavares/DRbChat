require "drb/drb"
require File.expand_path('../client.rb', __FILE__)

puts "What is your name?"
name = readline.chomp

DRb.start_service
error = 0

begin
  logger = DRbObject.new_with_uri "druby://localhost:8888"
rescue DRb::DRbConnError
    puts "No server found! Trying again in 10s"
    error += 1
    sleep 10
    retry if error <= 3
    exit -1
end

puts "Connected at localhost:8888"
client = Client.new logger, name


updater = Thread.new do
  while true
    sleep 10
    client.receive_msg.each { |m| puts m }
  end
end

while (c = readline.chomp) != ":q"
  client.send_msg c
  client.receive_msg(c).each { |m| puts m }
end
