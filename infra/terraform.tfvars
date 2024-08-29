bucket_name = "dev-proj-1-remote-state-bucket"
name        = "environment"
environment = "dev-1"

vpc_cidr             = "10.0.0.0/16"
vpc_name             = "dev-proj-ap-southeast-vpc-1"
cidr_public_subnet   = ["10.0.1.0/24", "10.0.2.0/24"]
cidr_private_subnet  = ["10.0.3.0/24", "10.0.4.0/24"]
eu_availability_zone = ["ap-southeast-2a", "ap-southeast-2b"]

public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCcdmgoHFvUjnlX+xIb8vHmjLWgjWDX528mU1Fl2ewdcU0gSK++GIpG3ZQJCxZGtH5bQDDwyAik/1qvypWsasmZE3WGS+9RrUYPKfWp1RuBubJ8IoNNlhld/igy7xkxlVEGNJqk2Oe+a8G+Jo+bArBKCwT1gSmWCHm06A9h6l2xjymm2DUIO38faYj32b+dfViU9/ZK/Tet/aqrhUvKjrSCp9wqp07GoBvuIRSWnFXaH6Jg75/A70MBdtpQM28cvACWSt6flmOgQPWvduI21urpPELND0bYJD0KUDsJose3/J9pl4bBei0s5FL4SL61AYX7aiF3clDiysQxVoEHGro6CjBh1Wrj3aS6W2T1WZgF6ghYrgLH4hKI42PmlK1gq6wy1R6BrizzCDtsIcRZZoi56xkysd57x0r+zR+cuH3d0uY84SiSvgT/NeCJOWSNbxihBuit47e5FevuD5H801BDqv7C2g+Bt2HK/nbuFA+AS3o3vRkISZKDRUeGEn/cu0k= ubuntu@ip-11-0-1-205"
ec2_ami_id     = "ami-0375ab65ee943a2a6"

ec2_user_data_install_apache = ""

domain_name = "app.shadowghosts.xyz"