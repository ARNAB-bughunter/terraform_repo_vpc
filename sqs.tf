resource "aws_sqs_queue" "fifo_queues" {
  for_each = toset(var.sqs_fifo_queue_names)

  name       = each.value
  fifo_queue = true

}
