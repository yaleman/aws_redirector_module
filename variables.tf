variable target_hostname {
    description = "Hostname to redirect to"
    type = string
    default = ""
}
variable source_hostname {
    description = "Hostname to redirect from"
    type = string
}

variable http_redirect_code {
    description = "HTTP Redirect Code to use"
    default = 301
    type = number
}

variable replace_key_prefix_with {
    description = "If you want to redirect to a path, set this"
    type = string
    default = ""
}

variable replace_key_with {
    description = "If you want to redirect to a file, set this"
    type = string
    default = ""
}

variable make_bucket_public {
    description = "Make the bucket public"
    type = bool
    default = false
}

variable min_ttl {
    type = number
    default = 0
    description = "Minimum TTL on the CloudFront Distribution"
}
variable max_ttl {
    type = number
    default = 3600
    description = "Maximum TTL on the CloudFront Distribution"
}
variable default_ttl {
    type = number
    default = 60
    description = "Default TTL on the CloudFront Distribution"
}

variable cloudfront_price_class {
    type = string
    default = "PriceClass_100"
    description = "CloudFront price class - info here: https://aws.amazon.com/cloudfront/pricing/, default is super cheap"
}

variable cert_validation_method {
    type = string
    default = "DNS"
    description = "Method for validating your certificate"
}