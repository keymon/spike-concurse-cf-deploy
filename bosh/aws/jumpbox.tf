resource "aws_instance" "jumpbox" {
  ami = "${lookup(var.ubuntu_amis, var.region)}"
  instance_type = "m3.medium"
  subnet_id = "${aws_subnet.infra.0.id}"
  private_ip = "10.0.0.4"
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.jumpbox.id}"]
  key_name = "${aws_key_pair.id_rsa.key_name}"
  source_dest_check = false

  root_block_device = {
    volume_type = "gp2"
    volume_size = 100
  }

  tags = {
    Name = "${var.env}-jumpbox"
  }

  connection {
    user = "ubuntu"
    key_file = "./ssh/id_rsa"
  }

  provisioner "file" {
    source = "./ssh/id_rsa"
    destination = "/home/ubuntu/.ssh/id_rsa"
  }

  provisioner "file" {
    source = "./ssh/id_rsa.pub"
    destination = "/home/ubuntu/.ssh/id_rsa.pub"
  }


}
