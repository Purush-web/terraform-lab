provider "aws" {
  region = "us-east-1"
  alias  = "dev"
}

provider "aws" {
  region = "us-west-1"
  alias  = "test"
}