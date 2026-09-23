resource "aws_vpc" "vpcname" {
  cidr_block = "10.0.0.0/16"
  #This block stops creating VPC first and then its creats the depending resource and then vpc
  depends_on = [aws_s3_bucket.newbucket]
}

resource "aws_s3_bucket" "newbucket" {
  bucket = "new_bucket_purush"
}