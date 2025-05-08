# ALB-Test
Setup sample ALB
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.97.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.ALB_VPC_NAT_EIP](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_instance.ALB_EC2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.ALB_IGW](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_lb.ALB_Test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.ALB_Test_Listener_Default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener_rule.ALB_Test_Listener_Movies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_listener_rule.ALB_Test_Listener_Shows](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_target_group.TGS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.TG_Attachments](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_nat_gateway.ALB_VPC_NAT_GW](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.ALB_VPC_Public_RT](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.RDS-VPC-Private-RT](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.ALB_VPC_Private_RT_Association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.ALB_VPC_Public_RT_Association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.ALB_VPC_SG](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.ALB_VPC_Private_Subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.ALB_VPC_Public_Subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.ALB_VPC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ALB_VPC_Private_Subnet"></a> [ALB\_VPC\_Private\_Subnet](#input\_ALB\_VPC\_Private\_Subnet) | n/a | `any` | n/a | yes |
| <a name="input_ALB_VPC_Public_Subnet"></a> [ALB\_VPC\_Public\_Subnet](#input\_ALB\_VPC\_Public\_Subnet) | n/a | `any` | n/a | yes |
| <a name="input_ALB_VPC_SG"></a> [ALB\_VPC\_SG](#input\_ALB\_VPC\_SG) | n/a | `any` | n/a | yes |
| <a name="input_EC2-Name"></a> [EC2-Name](#input\_EC2-Name) | n/a | `any` | n/a | yes |
| <a name="input_TGS"></a> [TGS](#input\_TGS) | n/a | `any` | n/a | yes |
| <a name="input_VPC_Name"></a> [VPC\_Name](#input\_VPC\_Name) | n/a | `any` | n/a | yes |
| <a name="input_VPC_cidr_block"></a> [VPC\_cidr\_block](#input\_VPC\_cidr\_block) | n/a | `any` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `any` | n/a | yes |
| <a name="input_azs"></a> [azs](#input\_azs) | n/a | `any` | n/a | yes |
| <a name="input_homepage_user_data"></a> [homepage\_user\_data](#input\_homepage\_user\_data) | n/a | `string` | `"#!/bin/bash\nsudo apt update\nsudo apt install nginx -y\nsudo sed -i 's/<h1>Welcome to nginx!<\\/h1>/<h1>Welcome to Homepage<\\/h1>/' /var/www/html/index.nginx-debian.html\necho '<a href=\"https://www.gehana26.fun/movies/\">Visit for Movies</a>' | sudo tee -a /var/www/html/index.nginx-debian.html\necho '</div>' | sudo tee -a /var/www/html/index.nginx-debian.html\necho '<br>' | sudo tee -a /var/www/html/index.nginx-debian.html\necho '<a href=\"https://www.gehana26.fun/shows/\">Visit for Shows</a>' | sudo tee -a /var/www/html/index.nginx-debian.html\nsudo systemctl restart nginx\nsudo systemctl enable nginx\n"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | n/a | `any` | n/a | yes |
| <a name="input_movies_user_data"></a> [movies\_user\_data](#input\_movies\_user\_data) | n/a | `string` | `"#!/bin/bash\nsudo apt update\nsudo apt install nginx -y\nsudo mkdir -p /var/www/html/movies\nsudo mv /var/www/html/index.nginx-debian.html /var/www/html/movies/index.nginx-debian.html\nsudo sed -i 's/<h1>Welcome to nginx!<\\/h1>/<h1>Welcome to Movies<\\/h1>/' /var/www/html/movies/index.nginx-debian.html\nsudo systemctl restart nginx\nsudo systemctl enable nginx\n"` | no |
| <a name="input_shows_user_data"></a> [shows\_user\_data](#input\_shows\_user\_data) | n/a | `string` | `"#!/bin/bash\nsudo apt update\nsudo apt install nginx -y\nsudo mkdir -p /var/www/html/shows\nsudo mv /var/www/html/index.nginx-debian.html /var/www/html/shows/index.nginx-debian.html\nsudo sed -i 's/<h1>Welcome to nginx!<\\/h1>/<h1>Welcome to Shows<\\/h1>/' /var/www/html/shows/index.nginx-debian.html\nsudo systemctl restart nginx\nsudo systemctl enable nginx\n"` | no |