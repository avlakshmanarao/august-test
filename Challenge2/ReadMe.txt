curl -Lo ec2-metadata-mock https://github.com/aws/amazon-ec2-metadata-mock/releases/download/v1.5.0/ec2-metadata-mock-`uname | tr '[:upper:]' '[:lower:]'`-amd64

1. run ec2-metadata-mock

2. python3 test.py localhost:1338/latest/meta-data iam/info