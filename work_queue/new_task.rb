# encoding: utf-8
require 'bunny'

conn = Bunny.new
conn.start

ch = conn.create_channel
q = ch.queue('task_queue', durable: true)

msg  = ARGV.empty? ? "Hello World!" : ARGV.join(" ")
q.publish(msg, persistent: true)

puts "Queue: #{q.name}"
puts " [x] Sent '#{msg}'"

conn.close
