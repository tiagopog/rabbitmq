# encoding: utf-8
require 'bunny'

conn = Bunny.new
conn.start

ch = conn.create_channel
x = ch.direct('messages_2')

q = []

q[1] = ch.queue('messages_1', durable: true)
q[1].bind(x, routing_key: 'messages_1')

q[2] = ch.queue('messages_2', durable: true)
q[2].bind(x, routing_key: 'messages_2')
q[2].bind(x, routing_key: 'messages_3')

ch.prefetch(1)

begin
  q = q[ARGV.empty? ? 1 : ARGV.join('').to_i]
  puts " [*] Waiting for messages #{q.name}. To exit press CTRL+C"  
  
  q.subscribe(ack: true, block: true) do |delivery_info, properties, body|
    puts " [x] Received '#{body}'"
    sleep 3
    puts ' [x] Done'
    ch.ack(delivery_info.delivery_tag)
  end
rescue Interrupt => _
  ch.close
  conn.close
end

# Example:
# => ruby worker.rb 1
# or
# => ruby worker.rb 2
