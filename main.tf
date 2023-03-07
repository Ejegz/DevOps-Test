provider "aws" {
  region = "us-east-2"
}


resource "aws_instance" "testEC2" {
  ami           = "ami-00eeedc4036573771"
  instance_type = "t2.micro"
  key_name      = "Testkey"
  subnet_id     = "subnet-08243affea13c67e0"
  vpc_security_group_ids = [
    "sg-0529f910bf89e0170"
  ]

  tags = {
    Name = "test-ec2-instance"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/Users/jesse/Downloads/Afri-health/Testkey.pem")
    host        = "${aws_instance.testEC2.public_ip}"
  }

  provisioner "file" {
    source      = "nginx.yml"
    destination = "/home/ubuntu/nginx.yml"
  }

  provisioner "local-exec" {
    command = "echo '${aws_instance.testEC2.public_ip}' > ip_address.txt"
  }

  provisioner "remote-exec" {
  inline = [
    "echo 'Executing remote commands...'",
    "sudo apt-add-repository --yes --update ppa:ansible/ansible",
    "sudo apt install -y ansible",
    "echo 'starting ansible ........'",
    "export ansible_host=$(curl ifconfig.me)",
#    "sleep 30 && ansible-playbook -i '${self.public_ip},' nginx.yml"
    "sleep 30 && ansible-playbook /home/ubuntu/nginx.yml --extra-vars ansible_host=$(ansible_host)"
#    "sleep 30 && ansible-playbook -i '${aws_instance.testEC2.public_ip},' nginx.yml"
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/Users/jesse/Downloads/Afri-health/Testkey.pem")
    host        = aws_instance.testEC2.public_ip
    ssh_options = ["-o", "StrictHostKeyChecking=no"]
  }

 }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/Users/jesse/Downloads/Afri-health/Testkey.pem")
      host        = aws_instance.testEC2.public_ip
    }
    inline = [
      "sudo apt update",
      "sudo apt install -y nodejs npm",
      "sudo npm install -g pm2"
    ]
  }

}

data "template_file" "nginx_playbook" {
  template = file("${path.module}/nginx.yml")
}

output "ip_address" {
  value = "${aws_instance.testEC2.public_ip}"
}

output "public_ip" {
  value = aws_instance.testEC2.public_ip
}

