# RabbitMQ Examples

Install the Bunny gem: 

```shell
$ gem install bunny --version ">= 0.9.1"
```

Start one or more workers (sub):

```shell
$ ruby work_queue/worker.rb
```

Add tasks to the queue (pub):

```shell
$ ruby work_queue/new_task.rb A hard task!
```

...and check your workers:

```shell
[*] Waiting for messages in task_queue. To exit press CTRL+C
[x] Received 'A hard task!'
[x] Done
```
