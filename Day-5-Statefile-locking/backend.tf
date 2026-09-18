terraform {
    backend "s3" {
        bucket = "mybucketofpurush"
        key    = "terraform.tfstate"
        region = "us-east-1"
        use_lockfile = true #supports terrafrom latest version >=1.10
        #dynamodb_table = "tf-state-locking" #supports terrafrom any version 
    }
}