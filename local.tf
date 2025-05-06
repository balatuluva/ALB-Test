locals {
 user_data_scripts = [
   var.homepage_user_data,
   var.movies_user_data,
   var.shows_user_data
 ]
}