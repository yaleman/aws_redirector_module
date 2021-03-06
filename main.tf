# store the redirector
resource aws_s3_bucket bucket {
    bucket = var.source_hostname
    acl = "%{ if var.make_bucket_public == true }public-read%{else}private%{endif}"

    tags = local.common_tags

    website {
        index_document = "index.html"
        routing_rules = local.routing_rules
    }
}

# S3 Policy Document Data
data aws_iam_policy_document cloudfront_policy {
  statement {
    sid = "S3GetObjectForCloudFront"
    effect = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.source_hostname}/*"]
    principals {
        type    = "AWS"
        identifiers = ["*"]
    }
  }
  statement {
    sid = "S3ListBucketForCloudFront"
    effect = "Allow"
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::${var.source_hostname}"]
    principals {
        type    = "AWS"
        identifiers = ["*"]
    }
  }
}

# Assign the Policy to the S3 Bucket
resource aws_s3_bucket_policy site_bucket {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.cloudfront_policy.json
}

# grab a certificate
resource aws_acm_certificate cert {
  domain_name       = var.source_hostname
  validation_method = var.cert_validation_method

  tags = local.common_tags

  lifecycle {
    create_before_destroy = true
  }
}

# access policy
resource aws_cloudfront_origin_access_identity s3_origin_access_identity {
  comment = "Used for accessing ${var.source_hostname} via CloudFront"
}

# the actual cloudfront thing
resource  aws_cloudfront_distribution cloudfront {
  enabled = true
  comment             = "${var.source_hostname} Distribution"
  aliases = [var.source_hostname]
  origin {
    domain_name = aws_s3_bucket.bucket.website_endpoint
    origin_id   = local.cloudfront_s3_origin_id
    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy = "http-only"
      origin_read_timeout = 30
      origin_ssl_protocols = [
        "TLSv1.2",
      ]
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  default_cache_behavior {
    allowed_methods  = ["GET","HEAD","OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.cloudfront_s3_origin_id

    forwarded_values {
        query_string = false
        cookies {
            forward = "none"
        }
        headers = []
    }
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl
  }
  price_class = var.cloudfront_price_class 

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.cert.arn
    ssl_support_method = "sni-only"
  }
}