# encoding: utf-8
require 'bunny'

conn = Bunny.new
conn.start

ch = conn.create_channel
x = ch.topic('topics')

msg  = ARGV.empty? ? '1 Empty body' : ARGV.join(' ')

topic = msg =~ /^\d+/ ? msg.split(' ').first : 1
q = "#{topic}.message_1"

x.publish(msg, routing_key: q)

puts "Queue: #{q}"
puts " [x] Sent '#{msg}'"

conn.close

# Example:
# => ruby new_message.rb 1
# => ruby new_message.rb 1.2
