variable "cluster_name" {
  default = "k8s-the-hague"
}

variable "region" {
  default     = "eu-west-2"
  description = "AWS region"
}

variable "bucket_name" {
  default     = "cherrytwist-the-hague-terraform-state"
  description = "AWS S3 Bucket. Must be unique among all AWS customers!"
}

variable "dynamo_table" {
  default     = "cherrytwist-the-hague-terraform-locks"
  description = "AWS DynamoDB table name. Used for locking the terraform state."
}
