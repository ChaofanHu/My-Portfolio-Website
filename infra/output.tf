output "ami" {
    value = module.my_website_instance.aim
}
output "public_ip" {
    value = module.my_website_instance.instance.public_ip
}
