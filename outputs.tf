output cert_domain_validation {
    value = aws_acm_certificate.cert.domain_validation_options
}

output cert_status {
    value = aws_acm_certificate.cert.status
}