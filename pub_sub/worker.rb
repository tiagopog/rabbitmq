# encoding: utf-8

require 'bunny'

conn = Bunny.new
conn.start

ch = conn.create_channel
x = ch.fanout('messages')

q1 = ch.queue('messages_1', durable: true)
q1.bind(x)

q2 = ch.queue('messages_2', durable: true)
q2.bind(x)

ch.prefetch(1)

begin
  q = ARGV
  eval "q = q#{q.empty? ? 1 : q.join('')}"
  
  puts " [*] Waiting for messages #{q.name}. To exit press CTRL+C"  
  
  q.subscribe(ack: true, block: true) do |delivery_info, properties, body|
    puts " [x] Received '#{body}'"
    sleep 3
    puts ' [x] Done'
    ch.ack(delivery_info.delivery_tag)
  end
rescue Interrupt => _
  conn.close
end

# Example:
# => ruby worker.rb 1
# or
# => ruby worker.rb 2
