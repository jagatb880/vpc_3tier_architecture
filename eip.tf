resource "aws_eip" "myeip" {
  instance = aws_instance.web[count.index].id
  count    = 2
}
