variable "aliases" {
  type        = list(string)
  description = "Additional domain aliases to add to the CloudFront distribution"
  default     = []
}

variable "cloudfront_price_class" {
  type        = string
  description = "The PriceClass for CloudFront distribution"
  default     = "PriceClass_100"
}

variable "force_destroy" {
  type        = bool
  description = "The force_destroy argument of the S3 bucket"
  default     = true
}

variable "fqdn" {
  type        = string
  description = "The primary FQDN of the website and also name of the S3 bucket"
}

variable "index_document" {
  type        = string
  description = "The HTML file to use as the index document"
  default     = "index.html"
}

variable "tags" {
  type        = map(string)
  description = "A key/value map to use for tagging resources"
  default     = {}
}

variable "use_existing_route53_zone" {
  type        = bool
  description = "A boolean representing whether to use an existing Route53 domain"
  default     = true
}
