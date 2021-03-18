terraform {
  backend "s3" {
    bucket         = "cherrytwist-terraform-state" //ideally var.bucket_name but backend configuration fails with vars
    key            = "global/s3/terraform.tfstate"
    region         = "eu-west-2" //ideally var.region but backend configuration fails with vars
    dynamodb_table = "cherrytwist-terraform-locks" //ideally var.dynamodb_table but backend configuration fails with vars
    encrypt        = true
  }
}
