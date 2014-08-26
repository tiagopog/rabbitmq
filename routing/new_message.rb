# encoding: utf-8
require 'bunny'

conn = Bunny.new
conn.start

ch = conn.create_channel
x = ch.direct('messages_2')

msg  = ARGV.empty? ? '1 Empty body' : ARGV.join(' ')

q = msg =~ /^\d+/ ? msg.split(' ').first : 1
q = "messages_#{q}"

x.publish(msg, routing_key: q)

puts "Queue: #{q}"
puts " [x] Sent '#{msg}'"

conn.close

# Example:
# => ruby new_message.rb 1 Hello
# => ruby new_message.rb n Hello
