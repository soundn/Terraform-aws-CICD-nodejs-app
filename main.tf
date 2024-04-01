resource "aws_instance" "node_client" {
  count         = 2  # Create two Node.js client instances for redundancy
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids

  user_data = filebase64("user_data_node_client.sh")

  tags = {
    Name = "Node Client Instance"
  }
}

resource "aws_instance" "postgres_server" {
  count         = 1  # Keep a single Postgres server instance
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids

  user_data = filebase64("user_data_postgres_server.sh")

  tags = {
    Name = "Postgres Server Instance"
  }
}

resource "aws_lb" "app_lb" {
  name = "node-client-lb"

  security_groups = var.vpc_security_group_ids

  subnets = aws_subnet.public_subnet.*.id

  tags = {
    Name = "Node Client Load Balancer"
  }
}

resource "aws_lb_target_group" "node_client_tg" {
  name     = "node-client-tg"
  port     = 80  # Assuming your Node.js application listens on port 80
  protocol = "http"

  vpc_id = aws_vpc.main.id

  health_check {
    interval = 30  # Health check every 30 seconds
    timeout  = 5    # Timeout after 5 seconds
    path     = "/health"  # Assuming your Node.js application has a health check endpoint at /health
  }
}

resource "aws_lb_target_group_attachment" "node_client_attachment" {
  target_group_arn = aws_lb_target_group.node_client_tg.arn
  target_id         = aws_instance.node_client.*.private_ip
  port              = 80  # Matches target group port
}

resource "aws_eip" "public_ip" {
  depends_on = [aws_lb.app_lb]

  allocation_id = aws_lb.app_lb.allocation_id
}

output "lb_dns_name" {
  value = aws_eip.public_ip.public_ip
}
