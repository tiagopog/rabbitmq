# encoding: utf-8
require 'bunny'

conn = Bunny.new
conn.start

ch = conn.create_channel
x = ch.topic('topics')

q = ch.queue('message_1', durable: true)
q.bind(x, routing_key: '*.message_1')

ch.prefetch(1)

begin
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
# => ruby worker.rb
