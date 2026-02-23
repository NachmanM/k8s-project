resource "aws_instance" "k8s-node" {
  ami           = data.aws_ami.ami.id
  instance_type = var.instance_config["instance_type"]

  iam_instance_profile   = var.instance_profile_name
  key_name               = var.key_pair_name
  vpc_security_group_ids = [var.security_group_id]
  tags = {
    Name = var.instance_config["key"]
    k8s  = var.instance_config["tag"]
    env  = var.global_tag

  }

  root_block_device {
    volume_size           = 32
    volume_type           = "gp2"
    delete_on_termination = true
  }

}



resource "aws_ec2_instance_state" "start_instance" {
  instance_id = aws_instance.k8s-node.id
  state       = "running"
}