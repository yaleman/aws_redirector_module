output cert_domain_validation {
    value = aws_acm_certificate.cert.domain_validation_options
}

output cert_status {
    value = aws_acm_certificate.cert.status
}

output cloudfront_domain_name {
    value = aws_cloudfront_distribution.cloudfront.domain_name
}

output cloudfront_status {
    value = aws_cloudfront_distribution.cloudfront.status
}