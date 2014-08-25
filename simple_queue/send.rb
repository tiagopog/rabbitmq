# encoding: utf-8
require 'bunny'

conn = Bunny.new
conn.start

ch = conn.create_channel
q = ch.queue('hello')

msg = 'Hello world!!'
ch.default_exchange.publish(msg, routing_key: q.name)

puts "Queue: #{q.name}"
puts " [x] Sent '#{msg}'"

conn.close
