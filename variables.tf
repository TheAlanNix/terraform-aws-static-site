variable "fqdn" {
  type        = string
  description = "The FQDN of the website and also name of the S3 bucket"
}

variable "aliases" {
  type        = list(string)
  description = "Any other domain aliases to add to the CloudFront distribution"
  default     = []
}

variable "cloudfront_price_class" {
  type        = string
  description = "PriceClass for CloudFront distribution"
  default     = "PriceClass_100"
}

variable "force_destroy" {
  type        = bool
  description = "The force_destroy argument of the S3 bucket"
  default     = true
}

variable "index_document" {
  type        = string
  description = "HTML file to show at root"
  default     = "index.html"
}

variable "tags" {
  type        = map(string)
  description = "Tags"
  default     = {}
}
