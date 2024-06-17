output "instance" {
    value = aws_instance.my_website_instance
}
output "aim" {
    value = data.aws_ami.my_website_ami.id
}