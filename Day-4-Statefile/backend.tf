terraform {
    backend "s3" {
        bucket = "mybucketofpurush"
        key    = "terraform.tfstate"
        region = "us-east-1"
    }
}