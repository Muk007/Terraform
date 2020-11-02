terraform {
        backend "s3" {
                bucket = "terra-muk"
                key = "terra-muk/terra_state"
        }
}
