locals {
    cloudfront_s3_origin_id = "S3${var.source_hostname}"

    # routing_rules = templatefile("${path.module}/RoutingRules.template",{
    #     "target_hostname" = var.target_hostname,
    #     "http_redirect_code" = var.http_redirect_code,
    #     "replace_key_prefix_with" = var.replace_key_prefix_with,
    #     "replace_key_with" = var.replace_key_with,
    # })
    common_tags = {
        Name = var.source_hostname
    }
}