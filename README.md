## S3 Archival Utility
Backup selected parts of the local filesystem to S3. Files are stored in Glacier Deep Archive and a maximum of 5 noncurrent object versions are kept.

Naming configuration of the S3 Bucket is $HOSTNAME-archive.

#### Configuration
1. Deploy CloudFormation Stack: `aws cloudformation deploy --template-file archive_bucket_cfn.yaml --stack-name $(hostname -s | tr '[:upper:]' '[:lower:]')-archive-bucket --parameter-overrides BucketName=$(hostname -s | tr '[:upper:]' '[:lower:]')-archive`

2. Set desired directories to be backed up in `backup.sh` by adding the relative path to the directory in the `PATHS` array.

3. *Optional:* Exclude selected subdirectories or files by adding `--include "<PATH>/*" \` to the command `aws s3 sync ..`

### Usage
Run `backup.sh` on CRON schedule


### Resources
[S3 sync filters](https://docs.aws.amazon.com/cli/latest/reference/s3/index.html#use-of-exclude-and-include-filters)
[S3 cp docs](https://docs.aws.amazon.com/cli/latest/reference/s3/cp.html)