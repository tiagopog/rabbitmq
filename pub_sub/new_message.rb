# encoding: utf-8
require 'bunny'

conn = Bunny.new
conn.start

ch = conn.create_channel
x = ch.fanout('messages')

msg  = ARGV.empty? ? 'Empty body' : ARGV.join(' ')

q = msg =~ /^2/ ? 2 : 1
q = "messages_#{q}"

x.publish(msg, routing_key: q)

puts "Queue: #{q}"
puts " [x] Sent '#{msg}'"

conn.close

# Example:
# => ruby new_message.rb 1 Hello
# or
# => ruby new_message.rb 2 Hello
