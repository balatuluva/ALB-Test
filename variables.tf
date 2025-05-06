variable "aws_region" {}
variable "VPC_cidr_block" {}
variable "VPC_Name" {}
variable "ALB_VPC_Public_Subnet" {}
variable "azs" {}
variable "ALB_VPC_Private_Subnet" {}
variable "ALB_VPC_SG" {}
variable "key_name" {}
variable "EC2-Name" {}
variable "homepage_user_data" {
  default = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install nginx -y
    sudo sed -i 's/<h1>Welcome to nginx!<\/h1>/<h1>Welcome to Homepage<\/h1>/' /var/www/html/index.nginx-debian.html
    echo '<a href="https://www.gehana26.fun/movies/">Visit for Movies</a>' | sudo tee -a /var/www/html/index.nginx-debian.html
    echo '</div>' | sudo tee -a /var/www/html/index.nginx-debian.html
    echo '<br>' | sudo tee -a /var/www/html/index.nginx-debian.html
    echo '<a href="https://www.gehana26.fun/shows/">Visit for Shows</a>' | sudo tee -a /var/www/html/index.nginx-debian.html
    sudo systemctl restart nginx
    sudo systemctl enable nginx
  EOF
}
variable "movies_user_data" {
  default = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install nginx -y
    sudo mkdir -p /var/www/html/movies
    sudo mv /var/www/html/index.nginx-debian.html /var/www/html/movies/index.nginx-debian.html
    sudo sed -i 's/<h1>Welcome to nginx!<\/h1>/<h1>Welcome to Movies<\/h1>/' /var/www/html/movies/index.nginx-debian.html
    sudo systemctl restart nginx
    sudo systemctl enable nginx
  EOF
}

variable "shows_user_data" {
  default = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install nginx -y
    sudo mkdir -p /var/www/html/shows
    sudo mv /var/www/html/index.nginx-debian.html /var/www/html/shows/index.nginx-debian.html
    sudo sed -i 's/<h1>Welcome to nginx!<\/h1>/<h1>Welcome to Shows<\/h1>/' /var/www/html/shows/index.nginx-debian.html
    sudo systemctl restart nginx
    sudo systemctl enable nginx
  EOF
}