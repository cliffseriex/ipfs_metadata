
output "aws_subnet_prod_public_1a_ue1" {
    value = aws_subnet.public_1.id
}

output "aws_subnet_prod_public_1b_ue1" {
    value = aws_subnet.public_2.id
}

output "aws_subnet_prod_private_1a_ue1" {
    value = aws_subnet.private_1.id
}

output "aws_subnet_prod_private_1b_ue1" {
    value = aws_subnet.private_2.id
}

output "public_subnet_ids" {
  value = [aws_subnet.public_1.id, aws_subnet.public_2.id]
}

output "private_subnet_ids" {
  value = [aws_subnet.private_1.id, aws_subnet.private_2.id]
}

output "vpc_id" {
  value = aws_vpc.prod-ue1.id
}