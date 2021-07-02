terraform {
  backend "s3" {
    bucket         = "alkemio-terraform-state" //ideally var.bucket_name but backend configuration fails with vars
    key            = "global/s3/terraform.tfstate"
    region         = "eu-west-2" //ideally var.region but backend configuration fails with vars
    dynamodb_table = "alkemio-terraform-locks" //ideally var.dynamodb_table but backend configuration fails with vars
    encrypt        = true
  }
}
