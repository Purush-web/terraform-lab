#-This is the first to put without any information
#resource "aws_s3_bucket" "Purush-bucket" {}


#To import the s3 bucket from AWS
#   terraform import aws_s3_bucketk.Purush-bucket mybucketofpurush
#After import, copy the required details of the bucket in this main block like below
resource "aws_s3_bucket" "Purush-bucket" {
    bucket = "mybucketofpurush"
}
