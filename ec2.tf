resource "aws_instance" "web" {
  ami                         = "ami-0c7217cdde317cfec"
  instance_type               = "t2.micro"
  key_name                    = "ubuntu-key"
  subnet_id                   = aws_subnet.public[count.index].id
  vpc_security_group_ids      = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  count                       = 2
  //Use different userdata scripts for each instance
  user_data = base64encode(file("userdata${count.index + 1}.sh"))

  tags = {
    Name = "WebServer"
  }


  // this required for connect private ec2 instance from public ec2 instance
  provisioner "file" {
    source      = "./ubuntu-key.pem"
    destination = "/home/ubuntu/ubuntu-key.pem"

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("./ubuntu-key.pem")
    }
  }
}

//Created ec2 instance for database
resource "aws_instance" "db" {
  ami                    = "ami-0c7217cdde317cfec"
  instance_type          = "t2.micro"
  key_name               = "ubuntu-key"
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.allow_tls_db.id]

  tags = {
    Name = "DB Server"
  }
}
