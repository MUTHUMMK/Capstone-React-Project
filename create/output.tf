output "Private_ip1" {
  value = aws_instance.public-1.private_ip
}
output "Private_ip2" {
  value = aws_instance.public-2.private_ip
}
