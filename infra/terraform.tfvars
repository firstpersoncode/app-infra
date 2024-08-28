bucket_name = "dev-proj-1-remote-state-bucket"
name        = "environment"
environment = "dev-1"

vpc_cidr             = "10.0.0.0/16"
vpc_name             = "dev-proj-ap-southeast-vpc-1"
cidr_public_subnet   = ["10.0.1.0/24", "10.0.2.0/24"]
cidr_private_subnet  = ["10.0.3.0/24", "10.0.4.0/24"]
eu_availability_zone = ["ap-southeast-2a", "ap-southeast-2b"]

public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCoALPvQcQnQyhS6C9+jhYrLOGEuZZKSzWHwC1Y7KGa3Z0DulbSbfTrqDzWe7/YcH8gaT1Aizspc3cjPjKHi862PTtKazJe17P0u5R01M5nTJdQ6FbIC34OPSPVS5UwJZ3S8fc/rdWfd8YXwXEN453Q5ZaZz0gZa9XJ+YjuidNp12GkswuJOKpxUXZyE9chsY1FIzCh31Y46YN+Fmz3jI4r3HKnQ733j4hqg6YUnAcwNyJmQBI8NDjcFNyll8kE530Tro0RFsIKbBzUjeONIdmi8BAaKlLgKQpt590eYHx0bRzXtiA23YdZswar8zkggvFHVJ5sL0+KQWooX3cLjTjifdYNVyXaHkYrFhuOJjRlQCCDGTkd/Q+7zZGHyk2+t/6lHpg4kV5mWmURM1NtI7+Y6e3xot+ZseUYaPNkzs9iq9pPE0DDwo5xw2ssvg1Nxq2LEJFxDBAm9Kbts/uXWOFCrYYBpWADn03Jg172KeGd3Qzk/T1lTZFSDBFv6cHdlMU= ubuntu@ip-10-0-1-170"
ec2_ami_id     = "ami-0497a974f8d5dcef8"

ec2_user_data_install_apache = ""

domain_name = "shadowghosts.xyz"