# AWS Redirector

Makes an S3-hosted redirector, fronted by CloudFront.

Example Usage:

    module wiki_yaleman_org {
        source = "github.com/yaleman/aws_redirector_module"
        source_hostname = "redirectme.example.com"
        target_hostname = "github.com"
        replace_key_prefix_with = "yaleman/aws_redirector_module/"
    }

This'll redirect `redirectme.example.com` to `https://github.com/yaleman/aws_redirector_module/`.

Outputs

| Name | Value |
| --- | --- |
| cert_domain_validation | map of data about how to validate your certificate |
| cert_status | Status of the ACM certificate |